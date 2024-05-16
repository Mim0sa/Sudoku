//
//  SudokuView.swift
//  Sudoku
//
//  Created by 吉彦臻 on 2024/5/16.
//

import SwiftUI

struct SudokuView: View {
    
    @StateObject var brain = SudokuBrain()
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0...8, id: \.self) { i in
                HStack(spacing: 2) {
                    ForEach(0...8, id: \.self) { j in
                        let index = SudokuIndex(i, j)
                        let value = brain.board.value(index)
                        if value == 0 {
                            Text(" ")
                                .frame(width: 30, height: 30)
                                .background(Rectangle().foregroundStyle(.bar))
                        } else {
                            Text("\(value)")
                                .frame(width: 30, height: 30)
                                .background(Rectangle().foregroundStyle(.bar))
                        }
                    }
                }
            }
        }
        .padding(3)
        .background(Rectangle().foregroundStyle(.secondary))
        .onAppear {
            brain.generateNewBoard()
        }
    }
}

#Preview {
    SudokuView()
}
