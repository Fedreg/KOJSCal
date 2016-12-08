
d = new Date()

# Main view model.
AppViewModel = ->
    @months = ko.observableArray([
        'January'
        'February'
        'March'
        'April'
        'May'
        'June'
        'July'
        'August'
        'September'
        'Ocotober'
        'November'
        'December'
    ])
    @year = ko.observable(d.getFullYear())
    @index = ko.observable(d.getMonth())
    @days = ko.observableArray([])
    @monthInput = ko.observable()
    @dayInput = ko.observable()
    @yearInput = ko.observable()

    console.log @year(), @index()

    # Sets the date to display on top of calendar.
    @date = ko.pureComputed =>
        a = @index()
        @months()[a] + ' | ' + @year()

    # Determines how many days in each month, + how many days append and prepend each month.  Pushes those to the @days array for rendering.
    @daysOfMonth = ko.computed =>
        month = @index()
        year = @year.peek()
        numberOfDays = new Date(year, month + 1, 0).getDate()
        startDay = new Date(year, month, 1).getDay()
        endDay = new Date(year, month, numberOfDays).getDay()

        # Iiterate and push the number of days that prepend current month.
        a = numberOfDays - startDay
        while a < numberOfDays
            preDays =
                date: a
                pre: true
                month: month
                year: year
            @days.push preDays
            a++

        # Iterate and push the number of days in the month.
        i = 1
        while i < numberOfDays + 1
            currentDays =
                date: i
                current: true
                month: month
                year: year
            @days.push currentDays
            i++

        # Iterate and push the number of days that append current month.
        l = 1
        while l < 7 - endDay
            postDays =
                date: l
                post: true
                month: month
                year: year
            @days.push postDays
            l++
        return
    
    # Increments month when "+ button" is pushed. resets days array.
    @plusMonth =  ->
        @days []

        if @index() < 11
            @index(@index() + 1)

        else if @index() == 11
            @year(@year() + 1)
            @index(0)
        return

    # Decrements month when "- button" is pushed. resets days array.
    @minusMonth =  ->
        @days []
        
        if @index() > 0
            @index(@index() - 1)

        else if @index() == 0
            @year(@year() - 1)
            @index(11)
        return
    

    # Highlight clicked calendar date / populate input date field
    @datePicker = (date, element) =>
        @monthInput @months()[date.month]
        @dayInput date.date
        @yearInput date.year
        return

    # Applies color to selected date
    @checkSelected = (date) =>

        if date.date is @dayInput() #and if  data.date == @dayInput()
            return true

        else
            return false

    # Goes to date selected on input 
    @goToDate = =>
        @days []
        @year(Number(@yearInput()))
        @index(@months.indexOf(@monthInput()))
        @checkSelected(@dayInput())
        @daysOfMonth()
        

    return

# Initializes viewModel
ko.applyBindings new AppViewModel
