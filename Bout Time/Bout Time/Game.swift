//
//  Game.swift
//  Bout Time
//
//  Created by Alex Koumparos on 29/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

class Game: TimerManagerDelegate {
    
    private var roundNumber = 0
    private var score = 0
    private var secondsPerRound: Int
    private var maxRounds: Int
    
    private var timerManager: TimerManager?
    
    init(rounds: Int, secondsPerRound: Int) {
        maxRounds = rounds
        self.secondsPerRound = secondsPerRound
        
    }
    
    
    public func startGame() {
        print("starting game!")
        
        
        while roundNumber <= maxRounds {
            startRound()
        }
        
        // gameover
    }
    
    private func startRound() {
        
        print("starting round!")
        let timerManager = TimerManager(game: self)
        
        print("starting timer...")
        timerManager.start()
        
        while timerManager.getRemainingTime() > 0 {
            print("time's not up yet!")
        }
        
        print("time's up!")
        evaluateGameState()
        
    }
    
    private func evaluateGameState() {
        // if game conditions are correct:
        // - increment score
        
        // if game conditions are incorrect:
        // - do not increment score
        
        // increment round
        print("evaluating game state!")
        roundNumber += 1
    }
    
    func testMessage() {
        print("this is a test message from the game instance")
    }
    
    //MARK: - TimerManagerDelegate Methods
    //------------------------------------
    public func timerWasUpdated() {
        print("timer was updated")
    }
    
}
