typealias SimpleDate = (Int, Int?, Int?)


/**
 Quick list of methods added in this extension:
 
 `from(year:month:day:hour:minute:second:calendar) -> Date?` : create a date object from specified date components
 
 `fromYear() -> Date?` : create a date object when only the year is known
 
 `add(dateComponent:value) -> Date?` : increment a `Date` by a given `Calendar Component`
 
 `startOfMonth() -> Date?` : get the `Date` corresponding to the beginning of the month of a `Date`
 
 `endOfMonth() -> Date?` : get the `Date` corresponding to one second prior to the end of the month containing the `Date`
 
 `daysInMonth() -> Int` : the number of days in the month
 
 `dayOfWeek() -> String` : the day of the week (as a `String`)
 
 `component(component:) -> Int` : the value for the supplied `Calendar.Component`
 */
extension Date {
    
    /**
     Returns an optional date because some inputs could be out of bounds (e.g., day = 32)
     */
    func from(year: Int, month: Int, day: Int, hour: Int?, minute: Int?, second: Int?, calendar: Calendar = Calendar.current) -> Date? {
        
        let cal = calendar
        let dateComponents = DateComponents(calendar: cal, timeZone: cal.timeZone, era: nil, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        
        return cal.date(from: dateComponents)
    }
    
    /**
     Use this when you only know the year but need to create a date object
     It will supply midnight, jan 1
     */
    func fromYear(_ year: Int, calendar: Calendar = Calendar.current) -> Date {
        let cal =  calendar
        let dateComponents = DateComponents(calendar: cal, timeZone: cal.timeZone, era: nil, year: year, month: nil, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        return cal.date(from: dateComponents)!
    }
    
    /**
     This is a convenience function to increment a `Date` by a specified calendar component, assuming the user's current calendar (which would almost always be the case) as a method on the date itself rather than on the `Calendar`.
     */
    func add(dateComponent component: Calendar.Component, value: Int) -> Date? {
        
        return Calendar.current.date(byAdding: component, value: value, to: self)
    }
    
    /**
     This will give a `Date` value using the user's current calendar for the beginning of the date's month.
     
     Example (2017-02-18 16:23 T-7, Gregorian Calendar):
     ```Swift
     let now = Date()
     now.startOfMonth()
     ```
     
     will return a `Date` object representing 2017-02-01 00:00 T-7, Gregorian calendar
     */
    func startOfMonth() -> Date? {
        
        let userCalendar = Calendar.current
        
        var beginningOfMonthDateComponents = DateComponents()
        beginningOfMonthDateComponents.year = userCalendar.component(.year, from: self)
        beginningOfMonthDateComponents.month = userCalendar.component(.month, from: self)
        beginningOfMonthDateComponents.day = 1
        
        let beginningOfMonthDate = userCalendar.date(from: beginningOfMonthDateComponents)
        return beginningOfMonthDate
        
    }
    
    /**
     This will give a Date value using the user's current calendar for one second prior to the end of the date's month.
     
     Example (2017-02-18 16:23 T-7, Gregorian Calendar):
     ```Swift
     let now = Date()
     now.EndOfMonth()
     ```
     
     will return a `Date` object representing 2017-02-28 11:59 (and 59 seconds) T-7, Gregorian calendar
     */
    func endOfMonth() -> Date? {
        
        let userCalendar = Calendar.current
        
        let startOfSubsequentMonth = userCalendar.date(byAdding: .month, value: 1, to: startOfMonth()!)
        
        let oneSecondPrior = userCalendar.date(byAdding: .second, value: -1, to: startOfSubsequentMonth!)
        
        return oneSecondPrior
        
    }
    
    /**
     This will return the number of days in the month of the date represented by self.
     */
    func daysInMonth() -> Int {
        
        let lastDayOfMonth = self.endOfMonth()
        let day = Calendar.current.component(.day, from: lastDayOfMonth!)
        return day
    }
    
    /**
     Returns a `String` representation of the weekday property of `Date`: self
     */
    func dayOfWeek() -> String {
        
        let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        let dayNumber = Calendar.current.component(.weekday, from: self)
        return weekdays[dayNumber - 1]
    }
    
    /**
     Returns an `Int` corresponding to the supplied `Calendar.Component` (for the current `Calendar`)
     */
    func component(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
}


/**
  This class depends on the date extensions above
 */
class DateHelper {
    /**
     - Note: Doesn't perform any validation of month/day. E.g.: (1941, 2, 30) will not cause an error, will return March 2, 1941. Similarly (1999, 11, 30) will return December 1, 1999. (1956, 999, 31) yields March 31, 2039
     */
    func dateFromSimpleDate(date: SimpleDate) -> Date {
    
        let tempDate = Date()
    
        let year = date.0
        let month = date.1 ?? 1
        let day = date.2 ?? 1
    
    
        return tempDate.from(year: year, month: month, day: day, hour: nil, minute: nil, second: nil)!
    
    }

}

/* examples:
dateFromSimpleDate(date: (1933, nil, nil))
dateFromSimpleDate(date: (1916, 4, nil))
dateFromSimpleDate(date: (1936, nil, 5))
dateFromSimpleDate(date: (1941, 2, 30))
dateFromSimpleDate(date: (1956, 11, 31))
dateFromSimpleDate(date: (1956, 13, 31))
dateFromSimpleDate(date: (1956, 999, 31))
*/
