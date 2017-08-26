import DateHelper

class EventHelper {
    /**
     This helper function belongs with the simplified form of the data and outside the Historical Event type since: 
     a) its purpose is to translate non-standardised, unsafe, simplified data into structured, safe, entities; and
     b) it relies on a set of Date extensions being available, and it is preferred not to put those dependencies inside 
        the HistoricalEvent type
     */
    func makeHistoricalEvent(event: String, year: Int, url: String) -> HistoricalEvent {
        let dateHelper = DateHelper()
        return HistoricalEvent(name: event, date: dateHelper.dateFromSimpleDate(date: (year, nil, nil)), url: URL(string: url)!)
    }

    func convertSimpleEvents(events: [(String, Int, String)]) -> [HistoricalEvent] {
        return events.map {makeHistoricalEvent(event: $0.0, year: $0.1, url: $0.2)}
    }
}
