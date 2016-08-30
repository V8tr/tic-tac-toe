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
            if let winner = winnerInRow(row, cells: cells) {
                return .Win(winner)
            }
        }
        
        for col in 0..<board.cols {
            if let winner = winnerInColumn(col, cells: cells) {
                return .Win(winner)
            }
        }
        
        if let winner = winnerInDiagonal(cells) {
            return .Win(winner)
        }
        
        return hasEmptyCells(cells) ? .InProgress : .Draw
    }
    
    private func winnerInRow(row: Int, cells: [Cell]) -> Player? {
        let rowCells = cells.filter { $0.row == row }
        print("winner in row \(row)")
        return winnerInSequence(rowCells)
    }
    
    private func winnerInColumn(col: Int, cells: [Cell]) -> Player? {
        let colCells = cells.filter { $0.col == col }
        print("winner in column \(col)")
        return winnerInSequence(colCells)
    }
    
    private func winnerInDiagonal(cells: [Cell]) -> Player? {
        let firstDiagCells = cells.filter { $0.col == $0.row }
        print("winner in first diagonal \(firstDiagCells)")
        if let player = winnerInSequence(firstDiagCells) {
            return player
        }
        
        let secondDiagCells = cells.filter { $0.row == board.cols - $0.col - 1 }
        print("winner in second diagonal \(secondDiagCells)")
        return winnerInSequence(secondDiagCells)
    }
    
    private func winnerInSequence(cells: [Cell]) -> Player? {
        var previousMarker: Marker? = nil
        var minMarkedIdx = 0
        while (previousMarker == nil && minMarkedIdx < cells.count) {
            if case .Marked(let marker) = cells[minMarkedIdx].selection {
                previousMarker = marker
            }
            minMarkedIdx += 1
        }
        
        var sequenceLength = 1
        
        for idx in minMarkedIdx..<cells.count {
            if case .Marked(let marker) = cells[idx].selection {
                if (previousMarker == marker) {
                    sequenceLength += 1
                    if (sequenceLength >= self.sequenceLength) {
                        break;
                    }
                }
                else {
                    sequenceLength = 1
                }
                previousMarker = marker
            }
            else {
                sequenceLength = 0;
            }
        }
        
        print("seqLen \(sequenceLength), marker \(previousMarker) \n")
        return sequenceLength >= self.sequenceLength ? playerForMarker(previousMarker!) : nil
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