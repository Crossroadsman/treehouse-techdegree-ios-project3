//
//  HistoricalEvent.swift
//  Bout Time
//
//  Created by Alex Koumparos on 29/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

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
