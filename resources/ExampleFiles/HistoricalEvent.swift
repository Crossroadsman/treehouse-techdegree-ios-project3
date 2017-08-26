//  Created by Alex Koumparos on 25/08/17.
//  Copyright © 2017 Alex Koumparos. All rights reserved.

struct HistoricalEvent: CustomStringConvertible {
    
    public var description: String {
        return "\(name)"
    }
    
    private let date: Date
    private let name: String
    private let url: URL
    
    init(name: String, date: Date, url: URL) {
        self.date = date
        self.name = name
        self.url = url
    }
    
    public func getDate() -> Date {
        return date
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getUrl() -> URL {
        return url
    }
    
}
