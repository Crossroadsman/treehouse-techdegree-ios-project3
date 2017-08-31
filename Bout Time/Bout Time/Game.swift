//
//  Game.swift
//  Bout Time
//
//  Created by Alex Koumparos on 29/08/17.
//  Copyright © 2017 Koumparos Software. All rights reserved.
//

import Foundation

protocol GameDelegate {
    
    //MARK: - Universal game functions
    //--------------------------------
    func gameDidStart()
    func gameDidEnd()
    
    func roundDidStart()
    func roundDidEnd()
    
    func readyForNextRound()
    
    
    //MARK: - Typical game functions
    //------------------------------
    func timeRemainingDidChange()
    func timeExpired()
    func getRemainingTime() -> Double
    
    
    //MARK: - Bout Time specific game functions
    //-----------------------------------------
    func getEventStrings() -> [String]
    
    
}

class Game: TimerManagerDelegate {
    
    private var roundNumber = 0
    private var score = 0
    private var secondsPerRound: Int
    private var maxRounds: Int
    
    private var round: Round?
    private var timerManager: TimerManager?
    private var vc: ViewController!
    
    init(vc: ViewController, rounds: Int, secondsPerRound: Int) {
        self.vc = vc
        maxRounds = rounds
        self.secondsPerRound = secondsPerRound
        
    }
    
    
    public func startGame() {
        print("starting game!")
        
        vc.gameDidStart()
        
        if roundNumber <= maxRounds {
            startRound()
        }
    }
    
    private func startRound() {
        
        print("starting round!")
        round = Round()
        
        vc.roundDidStart()
        
        timerManager = TimerManager(game: self, timePerRound: secondsPerRound)
        
        print("starting timer...")
        timerManager!.start()
        
        vc.roundDidStart()
    }
    
    private func evaluateGameState() {
        // if game conditions are correct:
        // - increment score
        
        // if game conditions are incorrect:
        // - do not increment score
        
        // increment round
        print("evaluating game state!")
        
        vc.roundDidEnd()
        
        roundNumber += 1
        if roundNumber <= maxRounds {
            startRound()
        } else {
            vc.gameDidEnd()
        }
    }
    
    public func readyForNextRound() {
        evaluateGameState()
    }
    
    public func getRemainingTime() -> Double {
        
        guard timerManager != nil else {
            return Double(secondsPerRound)
        }
        
        return timerManager!.getRemainingTime()
    }
    
    public func getEventStrings() -> [String] {
        return round!.getEventStrings()
    }
    
    //MARK: - TimerManagerDelegate Methods
    //------------------------------------
    public func timerDidTick() {
        print("Timer told me: Tick!")
        vc.timeRemainingDidChange()
        
    }
    
    public func timerDidEnd() {
        print("Timer told me: Time Up!")
        vc.timeExpired()
    }
    
}
