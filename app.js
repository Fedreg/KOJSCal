// Generated by CoffeeScript 1.12.0
(function() {
  var AppViewModel, d;

  d = new Date();

  AppViewModel = function() {
    this.months = ko.observableArray(['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'Ocotober', 'November', 'December']);
    this.year = ko.observable(d.getFullYear());
    this.index = ko.observable(d.getMonth());
    this.days = ko.observableArray([]);
    this.monthInput = ko.observable();
    this.dayInput = ko.observable();
    this.yearInput = ko.observable();
    console.log(this.year(), this.index());
    this.date = ko.pureComputed((function(_this) {
      return function() {
        var a;
        a = _this.index();
        return _this.months()[a] + ' | ' + _this.year();
      };
    })(this));
    this.daysOfMonth = ko.computed((function(_this) {
      return function() {
        var a, currentDays, endDay, i, l, month, numberOfDays, postDays, preDays, startDay, year;
        month = _this.index();
        year = _this.year.peek();
        numberOfDays = new Date(year, month + 1, 0).getDate();
        startDay = new Date(year, month, 1).getDay();
        endDay = new Date(year, month, numberOfDays).getDay();
        a = numberOfDays - startDay;
        while (a < numberOfDays) {
          preDays = {
            date: a,
            pre: true,
            month: month,
            year: year
          };
          _this.days.push(preDays);
          a++;
        }
        i = 1;
        while (i < numberOfDays + 1) {
          currentDays = {
            date: i,
            current: true,
            month: month,
            year: year
          };
          _this.days.push(currentDays);
          i++;
        }
        l = 1;
        while (l < 7 - endDay) {
          postDays = {
            date: l,
            post: true,
            month: month,
            year: year
          };
          _this.days.push(postDays);
          l++;
        }
      };
    })(this));
    this.plusMonth = function() {
      this.days([]);
      if (this.index() < 11) {
        this.index(this.index() + 1);
      } else if (this.index() === 11) {
        this.year(this.year() + 1);
        this.index(0);
      }
    };
    this.minusMonth = function() {
      this.days([]);
      if (this.index() > 0) {
        this.index(this.index() - 1);
      } else if (this.index() === 0) {
        this.year(this.year() - 1);
        this.index(11);
      }
    };
    this.datePicker = (function(_this) {
      return function(date, element) {
        _this.monthInput(_this.months()[date.month]);
        _this.dayInput(date.date);
        _this.yearInput(date.year);
      };
    })(this);
    this.checkSelected = (function(_this) {
      return function(date) {
        if (date.date === _this.dayInput()) {
          return true;
        } else {
          return false;
        }
      };
    })(this);
    this.goToDate = (function(_this) {
      return function() {
        _this.days([]);
        _this.year(Number(_this.yearInput()));
        _this.index(_this.months.indexOf(_this.monthInput()));
        _this.checkSelected(_this.dayInput());
        return _this.daysOfMonth();
      };
    })(this);
  };

  ko.applyBindings(new AppViewModel);

}).call(this);
