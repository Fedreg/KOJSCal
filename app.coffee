
d = new Date()

#main view model
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

    #sets the date to display on top of calendar
    @date = ko.pureComputed(( ->
        a = @index()
        @months()[a] + ' | ' + @year()
    ), this)

    #determines how many days in each month, + how many days append and prepend each month.  Pushes those to the @days array for rendering
    @daysOfMonth = ko.computed(( ->
        month = @index()
        year = @year.peek()
        numberOfDays = new Date(year, month + 1, 0).getDate()
        startDay = new Date(year, month, 1).getDay()
        endDay = new Date(year, month, numberOfDays).getDay()

        #iterate and push the number of days that prepend current month
        a = numberOfDays - startDay
        while a < numberOfDays
            preDays =
                date: a
                pre: true
            @days.push preDays
            a++

        #iterate and push the number of days in the month
        i = 1
        while i < numberOfDays + 1
            currentDays =
                date: i
                current: true
            @days.push currentDays
            i++

        #iterate and push the number of days that append current month
        l = 1
        while l < 7 - endDay
            postDays =
                date: l
                post: true
            @days.push postDays
            l++
        return
    ), this)
    
    #increments month when "+ button" is pushed. resets days array
    @plusMonth =  ->
        @days []

        if @index() < 11
            @index(@index() + 1)

        else if @index() == 11
            @year(@year() + 1)
            @index(0)
        return

    #decrements month when "- button" is pushed. resets days array
    @minusMonth =  ->
        @days []
        
        if @index() > 0
            @index(@index() - 1)

        else if @index() == 0
            @year(@year() - 1)
            @index(11)
        return
    
    return


ko.applyBindings new AppViewModel
