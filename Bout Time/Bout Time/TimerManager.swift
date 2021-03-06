//
//  TimerManager.swift
//  Bout Time
//
//  Created by Alex Koumparos on 29/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

protocol TimerManagerDelegate {
    
    var timerWasInterrupted: Bool { get set }
    
    func timerDidTick()
    func timerDidEnd()
    
}


// note Timer is a class provided by Apple
class TimerManager {
    private var timeRemaining: Double = 0.0
    private var timer = Timer()
    private let timePerRound: Double
    
    public var delegate: TimerManagerDelegate?
    
    init(timePerRound: Int) {
        self.timePerRound = Double(timePerRound)
    }
    
    /// use the Timer class's scheduleTimer method
    /// to start the timer with the specified interval (in s)
    /// which calls the specified function/closure every time
    /// the timer fires
    public func start() {
        print("starting timer")
        timeRemaining = timePerRound
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            
            (t: Timer) in
            print("timer has been set up, calling update")
            self.update(t)
        })
        
    }
    
    /**
     Updates the time remaining property and, providing there is a delegate,
     invalidates the timer when the timer ends and notifies the delegate that
     timer ticked or ended
    */
    private func update(_ timer: Timer) {
        print("updating timer")
        print("timer value was \(timeRemaining)")
        timeRemaining -= timer.timeInterval.magnitude
        print("timer now: \(timeRemaining)")
        
        guard delegate != nil else {
            print("somehow delegate was nil")
            return
        }
        
        if delegate!.timerWasInterrupted {
            delegate!.timerWasInterrupted = false
            timer.invalidate()
        } else if timeRemaining <= 0 {
            timer.invalidate()
            delegate!.timerDidEnd()
        } else {
            delegate!.timerDidTick()
        }
    }
    
    /**
     Notifies the caller of remaining time
     */
    public func getRemainingTime() -> Double {
        return timeRemaining
    }
    
}
