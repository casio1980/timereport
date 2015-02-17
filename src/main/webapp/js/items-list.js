ItemsList = (function () {

    // TODO - move to plugins
    // Extend the validation callbacks to work with Bootstrap, as used in this example
    // See: http://thedersen.com/projects/backbone-validation/#configuration/callbacks
    _.extend(Backbone.Validation.callbacks, {
        valid: function (view, attr, selector) {
            var $el = view.$('[name=' + attr + ']'),
                $group = $el.closest('.form-group');

            $group.removeClass('has-error');
            $group.find('.help-block').html('').addClass('hidden');
        },
        invalid: function (view, attr, error, selector) {
            var $el = view.$('[name=' + attr + ']'),
                $group = $el.closest('.form-group');

            $group.addClass('has-error');
            $group.find('.help-block').html(error).removeClass('hidden');
        }
    });
    _.extend(Backbone.Validation.messages, {
        required: "Поле не может быть пустым"
    });

    var ItemModel = Backbone.Model.extend({

        url: function() {
            return this.options.id
                ? this.options.url + "?id=" + this.options.id
                : this.options.url;
        },

        validation: function() {
            return this.options.validation;
        },

        initialize: function (attributes, options) {
            this.options = options;

            if (this.options.id) { // existing model
                this.view = new ItemView({
                    model: this
                });
                this.load();
            } else { // new model
                this.view = new AddView({
                    model: this
                });
                this.view.render();
            }
        },

        load: function() {
            var self = this;
            this.fetch().done(function() {
                self.view.render();
            });
        },

        save: function(options) {
            Backbone.sync("create", this, options);
        },

        parse : function(resp) {
            this.item = new Backbone.Model(resp.item);
            this.lColName = resp.lColName;
            this.rColName = resp.rColName;
            this.lColUrl = resp.lColUrl;
            this.rColUrl = resp.rColUrl;
            this.lCol = new Backbone.Collection(resp.lCol);
            this.rCol = new Backbone.Collection(resp.rCol);
        }

    });

    var ListModel = Backbone.Collection.extend({
        model: Backbone.Model,

        url: function() {
            return this.options.url;
        },

        initialize: function (attributes, options) {
            this.options = options;

            this.view = new ListView({
                collection: this
            });

            this.view.render();
            this.load();
        },

        load: function() {
            var self = this;
            this.fetch().done(function() {
                self.view.renderList();
            });
        },

        search: function(searchStr) {
            if(searchStr == "") return this;

            var pattern = new RegExp(searchStr, "gi");
            return _(this.filter(function(data) {
                return pattern.test(data.get("name"));
            }));
        }

    });

    var ItemView = Backbone.View.extend({
        el: "#view",
        tagName: "div",
        template: _.template("<div class=\"row\">" +
        "<div class=\"col-md-10\">" +
        "<h3><%= name %></h3>" +
        "</div>" +
        "<div class=\"col-md-2 text-right\">" +
        "<h3><mark><%= hours %></mark></h3>" +
        "</div>" +
        "</div>" +
        "<%= description %>" +
        "<div class=\"row\">" +
        "<div class=\"col-md-6 info-col\">" +
        "<h4><%= lColName %></h4><ul id=\"lcol\" class=\"list-unstyled\"></ul>" +
        "</div>" +
        "<div class=\"col-md-6 info-col\">" +
        "<h4><%= rColName %></h4><ul id=\"rcol\" class=\"list-unstyled\"></ul>" +
        "</div>" +
        "</div>"),
        itemTemplate: _.template("<li><a href=\"<%= url %>#<%= id %>\"><%= name %></a><span><%= hours %></span></li>"),

        render: function() {
            this.$el.empty();

            var description = this.model.item.get("description")
                ? "<blockquote><p>" + this.model.item.get("description") + "</p></blockquote>"
                : "";

            this.$el.append(this.template({
                name: this.model.item.get("name"),
                description: description,
                hours: $.toHours(this.model.item.get("hours")),
                lColName: this.model.lColName,
                rColName: this.model.rColName
            }));

            this.renderCol("#lcol", this.model.lColUrl, this.model.lCol);
            this.renderCol("#rcol", this.model.rColUrl, this.model.rCol);
        },

        renderCol: function(listId, url, collection) {
            var self = this;
            var $list = this.$el.find(listId);

            collection.each(function(item) {
                $list.append(self.itemTemplate({
                    url: url,
                    id: item.get("id"),
                    name: item.get("name"),
                    hours: $.toHours(item.get("hours"))
                }));
            });
        }
    });

    var AddView = Backbone.View.extend({
        el: "#view",
        tagName: "div",

        events: {
            "submit form": "onSubmit"
        },

        initialize: function () {
            Backbone.Validation.bind(this);
            this.modelBinder = new Backbone.ModelBinder();
            this.template = _.template(this.model.options.addViewTemplate);
        },

        render: function() {
            this.$el.empty();
            this.$el.append(this.template({}));

            this.modelBinder.bind(this.model, this.el);
        },

        onSubmit: function(e) {
            e.preventDefault();

            if (this.model.isValid(true)) {

                this.model.save({
                    success: function () {
                        app.router.navigate("", true);
                    },
                    error: function () {
                        if ($(".alert").length) return;
                        $("form").prepend("<div class=\"alert alert-danger\" role=\"alert\">" +
                            "<strong>Ошибка!</strong> Не удалось сохранить запись.</div>");
                    }
                });
            }
        }
    });

    var ListView = Backbone.View.extend({
        el: "#view",
        tagName: "div",
        template: _.template("<div class=\"search inner-addon right-addon\">" +
            "<i class=\"glyphicon glyphicon-search\"></i>" +
            "<input id=\"search\" class=\"form-control\" placeholder=\"Поиск...\" />" +
            "</div>" +
            "<table class=\"table table-hover\">" +
            "<tbody id=\"items-list\">" +
            "</tbody>" +
            "</table>" +
            "<a id=\"add\" href=\"javascript:void(0);\" class=\"btn btn-success\">" +
            "<span class=\"glyphicon glyphicon-plus\" aria-hidden=\"true\"></span> <%= addButtonTitle %>" +
            "</a>"),
        itemTemplate: _.template("<tr data-id=\"<%= id %>\">" +
            "<td><a href=\"#<%= id %>\"><%= name %></a></td>" +
            "<td class=\"text-right\"><%= hours %></td>" +
            "</tr>"),

        events: {
            "keyup #search": "onSearch",
            "click #add": "onAdd"
        },

        render: function() {
            this.$el.empty().append(this.template({
                addButtonTitle: this.collection.options.addButtonTitle
            }));
        },

        renderList: function(searchStr) {
            this.$el.find("#items-list").empty();

            var self = this;
            this.collection.search(searchStr).each(function(item) {

                self.$el.find("#items-list").append(self.itemTemplate({
                    id: item.get("id"),
                    name: item.get("name"),
                    hours: $.toHours(item.get("hours"))
                }));

            });
        },

        onSearch: function(e) {
            switch(e.which) {
                case 13: // enter
                    var firstId = $("#items-list tr").first().attr("data-id");
                    app.router.navigate(firstId, true);
                    break;

                default: // filter
                    var $target = $(e.currentTarget);
                    this.renderList($target.val());
                    break;
            }
        },

        onAdd: function() {
            app.router.navigate("add", true);
        }
    });

    var ListRouter = Backbone.Router.extend({

        routes: {
            "": "defaultView",
            "add": "itemAdd",
            ":id": "itemView"
        },

        initialize: function() {
            Backbone.history.start();
        },

        defaultView: function() {
            new ListModel(null, {
                url: app.params.url,
                addButtonTitle: app.params.addButtonTitle
            });
        },

        itemAdd: function() {
            new ItemModel(null, {
                url: app.params.url,
                validation: app.params.validation,
                addViewTemplate: app.params.addViewTemplate
            });
        },

        itemView: function(id) {
            new ItemModel(null, {
                id: id,
                url: app.params.url
            });
        }

    });

    var app = this;
    return {
        init: function(params) {

            app.params = params;
            app.router = new ListRouter();
        }
    };


})();