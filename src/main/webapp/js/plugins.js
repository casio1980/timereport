(function($){

    $.extend({
        toHours: function(num) {
            num = num || 0;
            var lastDigit = num % 10;

            if (lastDigit == 0) return num.toFixed(1) + " часов";
            if (lastDigit == 1 && num != 11) return num.toFixed(1) + " час";
            if (lastDigit < 5 && [11, 12, 13, 14].indexOf(num) == -1 ) return num.toFixed(1) + " часа";
            return num.toFixed(1) + " часов";
        }
    });

    $.fn.extend({

        //getRowId: function() {
        //    return this.closest(".time-row").attr("data-id");
        //},

        moveUp: function() {
            var cn = this.attr("data-control-name") || "project";
            return this.closest("div.time-row").prev().find("input.time-control." + cn).focus();
        },

        moveDown: function() {
            var cn = this.attr("data-control-name") || "project";
            return this.closest("div.time-row").next().find("input.time-control." + cn).focus();
        },

        moveHome: function() {
            var cn = this.attr("data-control-name") || "project";
            $("div.time-row").first().find("input.time-control." + cn).focus();
        },

        moveEnd: function() {
            var cn = this.attr("data-control-name") || "project";
            var $row = $("div.time-row").last();
            $row.find("input.time-control." + cn).focus();
            return $row;
        },

        moveRight: function() {
            var $next = this.parent().next().find(".time-control");
            $next.length == 0 ? this.closest("div.time-row").moveDown() : $next.focus();
        },

        setTypeaheadSource: function(json, onSelect) {
            try {
                this.data("typeahead").source = json;
            } catch(e) {
                this.typeahead({
                    source: json,
                    onSelect: onSelect
                });
            }
        }

    });

})(jQuery);