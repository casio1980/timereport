TimeList = (function () {

    var ProjectModel = Backbone.Model.extend({
        initialize : function() {
            this.set({
                "activities": new Backbone.Collection(this.get("activities"))
            });
        }
    });
    var ProjectCollection = Backbone.Collection.extend({
        model: ProjectModel
    });

    var DataModel = Backbone.Model.extend({

        //defaults: {
        //    projectId: 0,
        //    activityId: 0,
        //    hours: 0
        //},

        reset: function(attributes) {
            this.clear()
                .set({
                    date: attributes.date
                });
        }
    });

    var DataCollection = Backbone.Collection.extend({
        model: DataModel,

        initialize: function (attributes, options) {
            this.options = options;
            this.on('remove', this.onRemove, this);
        },

        onRemove: function(item) {
            if (!item.get("id")) return;
            $.ajax({
                type: "DELETE",
                url: this.options.url + "?id=" + item.get("id"),
                dataType: "json"
            });
        },

        save: function (options) {
            var tmp = new Backbone.Collection( this.changed() );
            if (tmp.length == 0) return;
            tmp.url = this.options.url;

            // sync
            Backbone.sync("create", tmp, options);
        },

        changed: function () {
            return this.models.filter( function(model) {
                return model.hasChanged();
            });
        }
    });

    var TimeListModel = Backbone.Model.extend({

        url: function() {
            return this._loadWeek ? this.options.url + "?week=" + this._loadWeek : this.options.url;
        },

        initialize: function (attributes, options) {
            this.options = options;
            this.view = new TimeListView({
                "model": this
            });

            this.view.render();
            this.load();
        },

        load: function(week) {
            var self = this;
            if (week) this._loadWeek = week;

            this.fetch().done(function() {
                self.view.renderPager().renderData();
            });
        },

        loadPrev: function() {
            this.data.save();
            this.load(this.prevWeek.get("weekNum"));
        },

        loadNext: function() {
            this.data.save();
            this.load(this.nextWeek.get("weekNum"));
        },

        parse : function(resp) {
            this.thisWeek = new Backbone.Model({
                weekNum: resp.thisWeek.weekNum,
                current: resp.thisWeek.current
            });
            this.days = new Backbone.Collection(resp.thisWeek.week);
            this.nextWeek = new Backbone.Model(resp.nextWeek);
            this.prevWeek = new Backbone.Model(resp.prevWeek);
            this.projects = new ProjectCollection(resp.projects);
            this.data = new DataCollection(resp.data, {url: this.options.url});
        }
    });

    var TimeListView = Backbone.View.extend({
        el: "#view",
        tagName: "div",

        template: _.template("<nav>" +
        "<ul class=\"pager\">" +
        "<li class=\"previous disabled\" title=\"Предыдущая неделя\">" +
        "<a id=\"btnPrev\" href=\"javascript:void(0);\">" +
        "<span aria-hidden=\"true\">&larr;</span> <span id=\"prev-week\"></span>" +
        "</a></li>" +
        "<li id=\"page-title\"></li>" +
        "<li class=\"next disabled\" title=\"Следующая неделя\">" +
        "<a id=\"btnNext\" href=\"javascript:void(0);\">" +
        "<span id=\"next-week\"></span> <span aria-hidden=\"true\">&rarr;</span>" +
        "</a></li>" +
        "</ul></nav>" +
        "<div id=\"time-list\"></div>" +
        "<a id=\"add\" href=\"javascript:void(0);\" class=\"btn btn-success\">" +
        "<span class=\"glyphicon glyphicon-plus\" aria-hidden=\"true\"></span> Новая запись" +
        "</a>"),

        itemTemplate: _.template("<div class=\"row time-row\" data-id=\"<%= id %>\">" +
        "<div class=\"col-md-3\">" +
        "<input type=\"text\" class=\"form-control time-control project\" data-control-name=\"project\" value=\"<%= project %>\" placeholder=\"Проект\" />" +
        "</div>" +
        "<div class=\"col-md-4\">" +
        "<input type=\"text\" class=\"form-control time-control activity\" data-control-name=\"activity\" value=\"<%= activity %>\" placeholder=\"Задача\" />" +
        "</div>" +
        "<div class=\"col-md-2\">" +
        "<input type=\"text\" class=\"form-control time-control hours\" data-control-name=\"hours\" value=\"<%= hours %>\" placeholder=\"Время\" />" +
        "</div>" +
        "<div class=\"col-md-2\">" +
        "<select class=\"form-control time-control date\" data-control-name=\"date\" placeholder=\"Дата\">" +
        "<%= options %>" +
        "</select>" +
        "</div>" +
        "<div class=\"col-md-1\" style=\"text-align: center\">" +
        "<a href=\"javascript:void(0);\" class=\"delete\" title=\"Удалить запись\" tabindex=\"-1\">" +
        "<span class=\"glyphicon glyphicon-trash\" aria-hidden=\"true\"></span>&nbsp;" +
        "</a></div></div>"),

        optionTemplate: _.template("<option <%= selected %> value='<%= date %>'><%= day %></option>"),

        events: {
            "click #btnPrev": "onPrev",
            "click #btnNext": "onNext",
            "click #add": "onAdd",
            "click .delete": "onDelete",
            "focus .time-control": "setActiveRow",
            "focus .time-control.project": "setProjectTypeahead",
            "focus .time-control.activity": "setActivityTypeahead",
            "change .time-control": "onChange",
            "keydown .time-control": "onKeys"
        },

        initialize: function() {
            $(window).on('beforeunload', function() {
                this.model.data.save();
            });
        },

        render: function() {
            this.$el.empty().append(this.template());
            return this;
        },

        renderPager: function() {
            this.$el.find("#page-title")
                .text("Неделя " + this.model.thisWeek.get("weekNum"))
                .toggleClass("current", this.model.thisWeek.get("current"));
            this.$el.find("#prev-week").text("Неделя " + this.model.prevWeek.get("weekNum"));
            this.$el.find("#next-week").text("Неделя " + this.model.nextWeek.get("weekNum"));

            this.$el.find(".pager .previous").toggleClass("disabled", this.model.prevWeek.get("disabled"));
            this.$el.find(".pager .next").toggleClass("disabled", this.model.nextWeek.get("disabled"));
            return this;
        },

        renderData: function() {
            var self = this;
            var $list = this.$el.find("#time-list").empty();

            if (this.model.data.length == 0)
                this.model.data.add(new DataModel({
                    date: this.model.days.at(0).get("date")
                }));

            this.model.data.each(function(item) {

                var project = self.model.projects.get(item.get("projectId"));
                var activity = project ? project.get('activities').get(item.get("activityId")) : null;

                $list.append(self.itemTemplate({
                    "id": item.cid,
                    "project": project ? project.get("name").replace(/\"/g, '&quot;') : "",
                    "activity": activity ? activity.get("name").replace(/\"/g, '&quot;') : "",
                    "hours": $.toHours(item.get("hours")),
                    "options": self.getOptions(item.get("date"))
                }));
            });

            // Activate the first row
            $list.find(".time-control.project").first().focus();
            return this;
        },

        getOptions: function(selectedDate) {
            var self = this;
            var options = "";
            this.model.days.each(function (day) {
                options += self.optionTemplate({
                    selected: day.get("date") == selectedDate ? "selected" : "",
                    date: day.get("date"),
                    day: day.get("name")
                });
            });
            return options;
        },

        onPrev: function(e) {
            if (!$(e.currentTarget).parent().hasClass("disabled")) this.model.loadPrev();
        },

        onNext: function(e) {
            if (!$(e.currentTarget).parent().hasClass("disabled")) this.model.loadNext();
        },

        onAdd: function() {
            this.model.data.add(new DataModel({
                date: this.model.days.at(0).get("date")
            }));
            this.renderData();
            this.$el.find("#time-list").find(".time-control.project").last().focus();
        },

        onDelete: function(e) {
            var $target = $(e.currentTarget);
            var $row = $target.closest("div.time-row");
            var item = this.model.data.get($row.attr("data-id"));

            this.model.data.remove(item);
            if ($row.hasClass("active")) {
                if ($row.next().length != 0) $row.next().find("input.time-control.project").focus();
                else $row.prev().find("input.time-control.project").focus();
            }
            $row.remove();

            if (this.model.data.length == 0) this.onAdd(); // at least 1 row should remain
        },

        setActiveRow: function(e) {
            $("div.time-row.active").removeClass("active");
            $(e.currentTarget).closest(".time-row").addClass("active");
        },

        setProjectTypeahead: function(e) {
            var $target = $(e.currentTarget);
            var $row = $target.closest("div.time-row");
            var item = this.model.data.get($row.attr("data-id"));

            $target.setTypeaheadSource(this.model.projects.toJSON(), function(sel) {
                if (item.get("projectId") == sel.value) return; // this value was already selected
                item.set({
                    projectId: +sel.value,
                    projectName: sel.text,
                    activityId: 0 // reset activity
                });
                $row.find("input.time-control.activity").val(""); // reset activity
            });
        },

        setActivityTypeahead: function(e) {
            var $target = $(e.currentTarget);
            var $row = $target.closest("div.time-row");
            var item = this.model.data.get($row.attr("data-id"));

            var projectId = item.get("projectId");
            projectId
                ? $target.setTypeaheadSource(this.model.projects.get(projectId).get("activities").toJSON(), function(sel) {
                        if (item.get("activityId") == sel.value) return; // this value was already selected
                        item.set({
                            activityId: +sel.value,
                            activityName: sel.text
                        });
                    })
                : $target.setTypeaheadSource(null);
        },

        onChange: function(e) {
            var $target = $(e.currentTarget);
            var $row = $target.closest("div.time-row");
            var item = this.model.data.get($row.attr("data-id"));

            $target.val($.trim($target.val()));

            if ($target.hasClass("project")) { // project input
                // TODO fired twice
                if (item.get("projectName") == $target.val()) return; // was selected already via typeahead

                // this is a new item
                item.set({
                    projectId: 0,
                    projectName: $target.val()
                });
            }

            if ($target.hasClass("activity")) { // activity input
                if (item.get("activityName") == $target.val()) return; // was selected already via typeahead

                // this is a new item
                item.set({
                    activityId: 0,
                    activityName: $target.val()
                });
            }

            if ($target.hasClass("hours")) { // hours input
                var hours = hours($target.val());
                item.set({
                    hours: hours
                });
                $target.val($.toHours(hours));
            }

            if ($target.hasClass("date")) { // date select
                item.set({
                    date: this.model.days.at(e.currentTarget.selectedIndex).get("date")
                });
            }

            function hours(hours) {
                var num = parseFloat(hours.toString()
                    .replace(/[,\-:]/g, '.').replace(/[^0-9\.]/g, ''));

                if (num) {
                    if (num < 0) num = 0;
                    if (num > 24) num = 24;
                    return Math.round(num * 10) / 10;
                }
                return 0;
            }
        },

        onKeys: function(e) {
            var $this = $(e.currentTarget);

            switch(e.which) {
                case 9: // tab
                    if (!e.shiftKey && $this.hasClass("date"))
                        if ($this.closest(".time-row").next().length == 0) {
                            e.preventDefault();
                            this.onAdd();
                        }
                    break;

                case 13: // enter
                    if ($this.hasClass("date")) {
                        if ($this.closest(".time-row").next().length == 0) this.onAdd();
                    }
                    else $this.moveRight();
                    break;

                case 38: // up
                    e.shiftKey
                        ? $this.moveHome()
                        : $this.moveUp();
                    break;

                case 40: // down
                    e.shiftKey
                        ? $this.moveEnd()
                        : $this.moveDown();
                    break;

                default:
                    return; // exit this handler for other keys
            }
        }
    });

    var app = this;
    return {
        init: function(params) {

            app.params = params;
            app.model = new TimeListModel(null, {
                url: app.params.url
            });
        }
    };

})();