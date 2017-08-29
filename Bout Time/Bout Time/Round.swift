//
//  Round.swift
//  Bout Time
//
//  Created by Alex Koumparos on 29/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

import GameplayKit

struct Round {
    
    private var roundData: [HistoricalEvent]
    
    init() {
        let randomSource = GKRandomSource()
        let shuffled = randomSource.arrayByShufflingObjects(in: events) as! [HistoricalEvent]
        roundData = Array(shuffled.prefix(4))
        roundData.sort(by: {
            isEvent($0, earlierThan: $1)
        })
    }
    
    private func isEvent(_ a: HistoricalEvent, earlierThan b: HistoricalEvent) -> Bool {
        return a.getDate() < b.getDate()
    }
    
    public func getEventStrings() -> [String] {
        let randomSource = GKRandomSource()
        return randomSource.arrayByShufflingObjects(in: roundData.map({$0.getName()})) as! [String]
    }
    
    public func eventsAreInOrder(_ events: [String]) -> Bool {
        return events == roundData.map {$0.getName()}
    }
    
    public func getUrlFor(event: String) -> URL? {
        for element in roundData {
            if event == element.getName() {
                return element.getUrl()
            }
        }
        return nil
    }
    
    
}

