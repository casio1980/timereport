ItemsList = (function () {

    var ItemModel = Backbone.Model.extend({

        url: function() {
            return this.options.url;
        },

        initialize: function (attributes, options) {
            this.options = options;
            this.view = new ItemView({
                "model": this
            });
            this.load();
        },

        load: function() {

            var self = this;
            this.fetch().done(function() {
                self.view.render();
            });
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
                "collection": this
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
                "name": this.model.item.get("name"),
                "description": description,
                "hours": $.toHours(this.model.item.get("hours")),
                "lColName": this.model.lColName,
                "rColName": this.model.rColName
            }));

            this.renderCol("#lcol", this.model.lColUrl, this.model.lCol);
            this.renderCol("#rcol", this.model.rColUrl, this.model.rCol);
        },

        renderCol: function(listId, url, collection) {
            var self = this;
            var $list = this.$el.find(listId);

            collection.each(function(item) {
                $list.append(self.itemTemplate({
                    "url": url,
                    "id": item.get("id"),
                    "name": item.get("name"),
                    "hours": $.toHours(item.get("hours"))
                }));
            });
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
                "addButtonTitle": this.collection.options.addButtonTitle
            }));
        },

        renderList: function(searchStr) {
            this.$el.find("#items-list").empty();

            var self = this;
            this.collection.search(searchStr).each(function(item) {

                self.$el.find("#items-list").append(self.itemTemplate({
                    "id": item.get("id"),
                    "name": item.get("name"),
                    "hours": $.toHours(item.get("hours"))
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
            // TODO
        }
    });

    var ListRouter = Backbone.Router.extend({

        routes: {
            "": "defaultView",
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

        itemView: function(id) {
            new ItemModel(null, {
                url: app.params.url + "?id=" + id
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