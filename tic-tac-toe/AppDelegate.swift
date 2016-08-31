//
//  AppDelegate.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let players = [
            Player(name: "V8tr", marker: .Circle),
            AIPlayer(name: "Dude", marker: .Cross)
        ]
        let board = Board(rows: 3, cols: 3)
        let game = Game(players: players, board: board)
        
        let viewModel = GameViewModel(game: game, activePlayer: players.first!)
        let gameVC = GameViewController.fromStoryboard() as GameViewController
        gameVC.viewModel = viewModel
        
        window?.rootViewController = gameVC
        window?.makeKeyAndVisible()
        
        return true
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

