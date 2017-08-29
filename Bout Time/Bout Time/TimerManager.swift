//
//  TimerManager.swift
//  Bout Time
//
//  Created by Alex Koumparos on 29/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

protocol TimerManagerDelegate {
    func timerWasUpdated()
}


// note Timer is a class provided by Apple
class TimerManager {
    private var timeRemaining = 60.0
    private var timer = Timer()
    private var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    // use the Timer class's scheduleTimer method
    // to start the timer with the specified interval (in s)
    // which calls the specified function/closure every time
    // the timer fires
    public func start() {
        // set up timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            (t: Timer) in self.update(t)
        })
    }
    
    private func update(_ timer: Timer) {
        print("updating timer")
        print("timer value was \(timeRemaining)")
        timeRemaining -= timer.timeInterval.magnitude
        print("timer now: \(timeRemaining)")
        
        if timeRemaining <= 0 {
            timer.invalidate()
        }
        game.timerWasUpdated()
    }
    
    /**
     Notifies the caller of remaining time
     */
    public func getRemainingTime() -> Double {
        return timeRemaining
    }
}
