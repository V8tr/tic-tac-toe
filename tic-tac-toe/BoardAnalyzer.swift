//
//  BoardAnalyzer.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/29/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class BoardAnalyzer {
    private let sequenceLength: Int
    private let board: Board

    init(board: Board, sequenceLength: Int) {
        self.board = board
        self.sequenceLength = sequenceLength
    }
    
    func gameResultForCells(cells: [Cell]) -> GameResult {
        for row in 0..<board.rows {
            if let gameResult = gameResultInRow(row, cells: cells) {
                return gameResult
            }
        }
        
        for col in 0..<board.cols {
            if let gameResult = gameResultInColumn(col, cells: cells) {
                return gameResult
            }
        }
        
        if let gameResult = gameResultInDiagonal(cells) {
            return gameResult
        }
        
        return hasEmptyCells(cells) ? .InProgress : .Draw
    }
    
    private func gameResultInRow(row: Int, cells: [Cell]) -> GameResult? {
        let rowCells = cells.filter { $0.row == row }
        print("winner in row \(row)")
        return gameResultInSequence(rowCells)
    }
    
    private func gameResultInColumn(col: Int, cells: [Cell]) -> GameResult? {
        let colCells = cells.filter { $0.col == col }
        print("winner in column \(col)")
        return gameResultInSequence(colCells)
    }
    
    private func gameResultInDiagonal(cells: [Cell]) -> GameResult? {
        let firstDiagCells = cells.filter { $0.col == $0.row }
        print("winner in first diagonal \(firstDiagCells)")
        if let player = gameResultInSequence(firstDiagCells) {
            return player
        }
        
        let secondDiagCells = cells.filter { $0.row == board.cols - $0.col - 1 }
        print("winner in second diagonal \(secondDiagCells)")
        return gameResultInSequence(secondDiagCells)
    }
    
    private func gameResultInSequence(cells: [Cell]) -> GameResult? {
        var previousMarker: Marker? = nil
        var minMarkedIdx = 0
        var positions: [Position] = []

        while (previousMarker == nil && minMarkedIdx < cells.count) {
            if case .Marked(let marker) = cells[minMarkedIdx].selection {
                previousMarker = marker
                positions.append(cells[minMarkedIdx].position)
            }
            minMarkedIdx += 1
        }
        
        var sequenceLength = 1
        
        for idx in minMarkedIdx..<cells.count {
            if case .Marked(let marker) = cells[idx].selection {
                if (previousMarker == marker) {
                    sequenceLength += 1
                    positions.append(cells[idx].position)
                    if (sequenceLength >= self.sequenceLength) {
                        break;
                    }
                }
                else {
                    sequenceLength = 1
                    positions = [cells[idx].position]
                }
                previousMarker = marker
            }
            else {
                sequenceLength = 0;
                positions.removeAll()
            }
        }
        
        print("seqLen \(sequenceLength), marker \(previousMarker) \n")
        if (sequenceLength < self.sequenceLength) {
            return nil;
        }
        return .Win(playerForMarker(previousMarker!)!, positions)
    }
    
    private func playerForMarker(marker: Marker) -> Player? {
        for player in board.players {
            if (player.marker == marker) {
                return player
            }
        }
        return nil
    }
    
    private func hasEmptyCells(cells: [Cell]) -> Bool {
        var emptyCount: Int = 0
        
        for cell in cells {
            if (cell.isEmpty) {
                emptyCount += 1
            }
        }
        
        return emptyCount > 0
    }
}