
d = new Date()

#main view model
AppViewModel = ->
    @months = ko.observableArray(["January","February","March","April","May","June","July","August","September","Ocotober","November","December"])
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
        d = numberOfDays - startDay
        while d < numberOfDays
            @days.push d
            d++

        #iterate and push the number of days in the month
        i = 1
        while i < numberOfDays + 1
            @days.push i
            i++

        #iterate and push the number of days that append current month
        l = 1
        while l < 7 - endDay
            @days.push(l)
            l++
        return
    ), this)
    
    #increments month when "+ button" is pushed. resets days array
    @plusMonth =  ->
        addIndex = @index()
        addYear = @year()
        @days []

        if addIndex < 11
            @index addIndex + 1

        if addIndex == 11
            @year addYear + 1
            @index addIndex = 0
        return

    #decrements month when "- button" is pushed. resets days array
    @minusMonth =  ->
        minusIndex = @index()
        minusYear = @year()
        @days []
        
        if minusIndex > 0
            @index minusIndex - 1

        if minusIndex == 0
            @year minusYear - 1
            @index minusIndex = 11
        return
    
    return


ko.applyBindings new AppViewModel
