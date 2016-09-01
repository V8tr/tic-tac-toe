//
//  AppDelegate.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import ReactiveCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.makeKeyAndVisible()
        
        startNewGame()
        
        return true
    }
    
    func startNewGame() {
        let players = [
            Player(name: "V8tr", marker: .Circle),
            AIPlayer(name: "Dude", marker: .Cross)
        ]
        let board = Board(rows: 3, cols: 3)
        let game = Game(players: players, board: board)
        
        let viewModel = GameViewModel(game: game, activePlayer: players.first!)
        
        viewModel.restartSignal
            .observeOn(UIScheduler())
            .observeNext { [unowned self] in
                self.startNewGame()
        }
        
        let gameVC = GameViewController(viewModel: viewModel)
        window!.rootViewController = gameVC
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }
}

