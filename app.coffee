
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
        'October'
        'November'
        'December'
    ])
    @appointments = ko.observableArray([
        appt1 =
            month: 8
            day: 24
            year: 1976
            desc: "Fed's birthday"

        appt2 =
            month: 12
            day: 25
            year: 2016
            desc: "Christmas"

        appt3 =
            month: 12
            day: 31
            year: 2016
            desc: "New Year's Eve"

        appt4 =
            month: 1
            day: 1
            year: 2017
            desc: "New Year's Day"
    ])
    @year = ko.observable(d.getFullYear())
    @index = ko.observable(d.getMonth())
    @days = ko.observableArray([])
    @yearInput = ko.observable(@year())
    @monthInput = ko.observable(@months()[@index()])
    @dayInput = ko.observable(d.getDate())
    @newTaskDay = ko.observable()
    @newTaskMonth = ko.observable()
    @newTaskYear  = ko.observable()
    @newTaskDescription = ko.observable()



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
    
    
    # Increments month when "+ button" is pushed. resets days array.
    @plusMonth =  ->
        @days []

        if @index() < 11
            @index(@index() + 1)

        else if @index() == 11
            @year(@year() + 1)
            @index(0)


    # Decrements month when "- button" is pushed. resets days array.
    @minusMonth =  ->
        @days []
        
        if @index() > 0
            @index(@index() - 1)

        else if @index() == 0
            @year(@year() - 1)
            @index(11)
    

    # Populate input date field.
    @datePicker = (date) =>
        @monthInput @months()[date.month]
        @dayInput date.date
        @yearInput date.year


    # Applies color to selected date.
    @checkSelected = (date) =>
        if date isnt null
            if date.date is @dayInput()
                true
    
    # Goes to date selected on input/clears out existing calendar dates/calls for new dates to be inserted. 
    @goToDate = =>
        
        @year Number(@yearInput())
        @index @months.indexOf(@monthInput())
        @days []
        @year.valueHasMutated()
        @index.valueHasMutated()
        
        # Pass @checkSelected a new date object.
        date =
            date: Number(@dayInput())
            
        # Not Working!!!
        #checkSelected date
        console.log date


    # Adds new event to Appointments array.
    @addEvent = ->
        appt =
            month: Number @newTaskMonth()
            day: Number @newTaskDay()
            year: Number @newTaskYear()
            desc: @newTaskDescription()
            
        @appointments.unshift appt

        @newTaskMonth("")
        @newTaskDay("")
        @newTaskYear("")
        @newTaskDescription("")

    return

# Initializes viewModel
ko.applyBindings new AppViewModel
