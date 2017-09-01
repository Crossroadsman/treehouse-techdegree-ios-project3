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
    func getEventStrings() -> [String] // for delegate to receive the array of event names
    func getLabelTexts() -> [String] // for Game to receive the array of label texts
    
}

enum GameState {
    case inRound
    case correct
    case incorrect
    case gameOver
}

class Game: TimerManagerDelegate {
    
    private var roundNumber = 0
    private var score = 0
    private var secondsPerRound: Int = 5
    private let maxRounds: Int = 6
    
    private var round: Round?
    private var timerManager: TimerManager?
    
    private var gameState: GameState = .gameOver
    
    public var delegate: GameDelegate!
    
    public func startGame() {
        print("starting game!")
        
        delegate.gameDidStart()
        
        if roundNumber <= maxRounds {
            startRound()
        }
    }
    
    private func startRound() {
        
        print("starting round!")
        round = Round()
        gameState = .inRound

        timerManager = TimerManager(timePerRound: secondsPerRound)
        timerManager!.delegate = self
        
        print("starting timer...")
        timerManager!.start()
        
        delegate.roundDidStart()
    }
    
    private func evaluateGameState() {
        // if game conditions are correct:
        // - increment score
        
        if round!.eventsAreInOrder(delegate.getLabelTexts()) {
            gameState = .correct
        } else {
            gameState = .incorrect
        }
        
        // if game conditions are incorrect:
        // - do not increment score
        
        // increment round
        print("evaluating game state!")
        
        delegate.roundDidEnd()
        
        roundNumber += 1
        if roundNumber <= maxRounds {
            //startRound()
        } else {
            gameState = .gameOver
            delegate.gameDidEnd()
        }
    }
    
    public func readyForNextRound() {
        switch gameState {
        case .correct, .incorrect:
            startRound()
        default:
            print("not in valid state to start round")
        }
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
    
    public func getGameState() -> GameState {
        return gameState
    }
    
    public func getScore() -> Int {
        return score
    }
    
    public func userDidEndRound() {
        evaluateGameState()
    }
    
    //MARK: - TimerManagerDelegate Methods
    //------------------------------------
    public func timerDidTick() {
        print("Timer told me: Tick!")
        delegate.timeRemainingDidChange()
        
    }
    
    public func timerDidEnd() {
        print("Timer told me: Time Up!")
        evaluateGameState()
        delegate.timeExpired()
    }
    
}
