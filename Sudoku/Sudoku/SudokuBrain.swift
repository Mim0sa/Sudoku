//
//  SudokuBrain.swift
//  Sudoku
//
//  Created by 吉彦臻 on 2024/5/16.
//

import Foundation

class SudokuBrain: ObservableObject {
    
    @Published var board = SudokuBoard()
    
    func generateNewBoard() {
        board.refreshBoard()
    }
    
}

struct SudokuIndex: Hashable {
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
        
        var gix = 0
        if x < 3 {
            if y < 3 {
                gix = 1
            } else if y < 6 {
                gix = 4
            } else if y < 9 {
                gix = 7
            }
        } else if x < 6 {
            if y < 3 {
                gix = 2
            } else if y < 6 {
                gix = 5
            } else if y < 9 {
                gix = 8
            }
        } else if x < 9 {
            if y < 3 {
                gix = 3
            } else if y < 6 {
                gix = 6
            } else if y < 9 {
                gix = 9
            }
        }
        self.groupIndex = gix
    }
    
    var x: Int
    var y: Int
    
    let groupIndex: Int
}

struct SudokuBoard {
    
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    // * * * * * * * * *
    
    var cells: [SudokuIndex : Int] = [:]
    
    init() {
        for i in 0...8 {
            for j in 0...8 {
                cells[SudokuIndex(i, j)] = 0
            }
        }
    }
    
    // query
    func group(_ index: SudokuIndex) -> [SudokuIndex] {
        return cells.keys.filter { i in
            i.groupIndex == index.groupIndex
        }
    }
    
    func col(_ index: SudokuIndex) -> [SudokuIndex] {
        return cells.keys.filter { i in
            i.y == index.y
        }
    }
    
    func row(_ index: SudokuIndex) -> [SudokuIndex] {
        return cells.keys.filter { i in
            i.x == index.x
        }
    }
    
    func value(_ index: SudokuIndex) -> Int {
        return cells[index]!
    }
    
    // update
    mutating func set(_ value: Int, with index: SudokuIndex) {
        cells[index] = value
    }
    
    mutating func refreshBoard() {
        cells.forEach { (key: SudokuIndex, value: Int) in
            set(Int.random(in: 1...9), with: key)
        }
    }
    
}
