// Generated by CoffeeScript 1.12.0
(function() {
  var AppViewModel, d;

  d = new Date();

  AppViewModel = function() {
    var appt1, appt2, appt3, appt4;
    this.months = ko.observableArray(['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']);
    this.appointments = ko.observableArray([
      appt1 = {
        month: 8,
        day: 24,
        year: 1976,
        desc: "Fed's birthday"
      }, appt2 = {
        month: 12,
        day: 25,
        year: 2016,
        desc: "Christmas"
      }, appt3 = {
        month: 12,
        day: 31,
        year: 2016,
        desc: "New Year's Eve"
      }, appt4 = {
        month: 1,
        day: 1,
        year: 2017,
        desc: "New Year's Day"
      }
    ]);
    this.year = ko.observable(d.getFullYear());
    this.index = ko.observable(d.getMonth());
    this.days = ko.observableArray([]);
    this.yearInput = ko.observable(this.year());
    this.monthInput = ko.observable(this.months()[this.index()]);
    this.dayInput = ko.observable(d.getDate());
    this.newTaskDay = ko.observable();
    this.newTaskMonth = ko.observable();
    this.newTaskYear = ko.observable();
    this.newTaskDescription = ko.observable();
    this.date = ko.pureComputed((function(_this) {
      return function() {
        var a;
        a = _this.index();
        return _this.months()[a] + ' | ' + _this.year();
      };
    })(this));
    this.daysOfMonth = ko.computed((function(_this) {
      return function() {
        var a, currentDays, endDay, i, l, month, numberOfDays, postDays, preDays, results, startDay, year;
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
        results = [];
        while (l < 7 - endDay) {
          postDays = {
            date: l,
            post: true,
            month: month,
            year: year
          };
          _this.days.push(postDays);
          results.push(l++);
        }
        return results;
      };
    })(this));
    this.plusMonth = function() {
      this.days([]);
      if (this.index() < 11) {
        return this.index(this.index() + 1);
      } else if (this.index() === 11) {
        this.year(this.year() + 1);
        return this.index(0);
      }
    };
    this.minusMonth = function() {
      this.days([]);
      if (this.index() > 0) {
        return this.index(this.index() - 1);
      } else if (this.index() === 0) {
        this.year(this.year() - 1);
        return this.index(11);
      }
    };
    this.datePicker = (function(_this) {
      return function(date) {
        _this.monthInput(_this.months()[date.month]);
        _this.dayInput(date.date);
        return _this.yearInput(date.year);
      };
    })(this);
    this.checkSelected = (function(_this) {
      return function(date) {
        if (date !== null) {
          if (date.date === _this.dayInput()) {
            return true;
          }
        }
      };
    })(this);
    this.goToDate = (function(_this) {
      return function() {
        var date;
        _this.year(Number(_this.yearInput()));
        _this.index(_this.months.indexOf(_this.monthInput()));
        _this.days([]);
        _this.year.valueHasMutated();
        _this.index.valueHasMutated();
        date = {
          date: Number(_this.dayInput())
        };
        return console.log(date);
      };
    })(this);
    this.addEvent = function() {
      var appt;
      appt = {
        month: Number(this.newTaskMonth()),
        day: Number(this.newTaskDay()),
        year: Number(this.newTaskYear()),
        desc: this.newTaskDescription()
      };
      this.appointments.unshift(appt);
      this.newTaskMonth("");
      this.newTaskDay("");
      this.newTaskYear("");
      return this.newTaskDescription("");
    };
  };

  ko.applyBindings(new AppViewModel);

}).call(this);
