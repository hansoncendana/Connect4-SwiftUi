//
//  ContentView.swift
//  Connect4Four
//
//  Created by User15 on 2022/3/18.
//

import SwiftUI

struct ContentView: View {
    enum Tile {
        case Red
        case Yellow
        case Empty
    }
    
    @AppStorage("red") var red = 0
    @AppStorage("yellow") var yellow = 0
    @AppStorage("draw") var draw = 0
    
    @State private var Board = Array(repeating: Tile.Empty, count: 42)
    @State private var RedPiece = 21
    @State private var YellowPiece = 21
    @State private var turn = "user"
    @State private var finish = false
    @State private var winner = ""
    @State private var connect : [Int] = []
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    VStack {
                        Text("CONNECT 4")
                            .bold()
                            .font(.largeTitle)
                            .frame(width: 200, height: 60)
                            .foregroundColor(.blue)
                            .background(Color(red: 70/255, green: 70/255, blue: 70/255))
                            .cornerRadius(15)
                    }
                    .padding(.bottom)
                    VStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width:80, height: 20)
                            .cornerRadius(10)
                            .overlay(Text("Draw").foregroundColor(.black).font(.headline))
                    }
                    HStack {
                        Image("Brave")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                            .overlay(Text("\(RedPiece)").foregroundColor(Color.white))
                        VStack {
                            HStack {
                                Text("Player 1")
                                    .font(.headline).foregroundColor(.white)
                                Spacer()
                                HStack {
                                    Rectangle()
                                        .fill(Color.red)
                                        .frame(width: 20, height: 40)
                                        .cornerRadius(10)
                                        .overlay(Text("\(red)").foregroundColor(Color.white))
                                    HStack {
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(width: 20, height: 40)
                                            .cornerRadius(10)
                                            .overlay(Text("\(draw)").foregroundColor(Color.white))
                                    }
                                    Rectangle()
                                        .fill(Color.yellow)
                                        .frame(width: 20, height:40)
                                        .cornerRadius(10)
                                        .overlay(Text("\(yellow)").foregroundColor(Color.white))
                                }
                                Spacer()
                                Text("Player 2")
                                    .font(.headline).foregroundColor(.white)
                            }
                        }
                        Image("Friendship")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                            .overlay(Text("\(RedPiece)").foregroundColor(Color.white))
                    }
                    let col = Array(repeating: GridItem(), count:7)
                    LazyVGrid(columns: col) {
                        ForEach(Board.indices) { index in
                            switch Board[index] {
                            case .Empty:
                                Circle()
                                    .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                    .foregroundColor(.black)
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                                    .onTapGesture {
                                        if (!finish && turn == "user" && winner != "draw") {
                                            turn = "Red"
                                            redTurn(index: index)
                                            RedPiece -= 1
                                            finish = PlayerWin()
                                            if (finish) {
                                                winner = "Red"
                                                red += 1
                                                RedPiece = 21
                                            }
                                            turn = "Yellow"
                                        } else if (!finish && turn == "Yellow" && winner != "draw") {
                                            yellowTurn(index: index)
                                            YellowPiece -= 1
                                            finish = PlayerWin()
                                            if (finish) {
                                                winner = "Yellow"
                                                yellow += 1
                                                YellowPiece = 21
                                            } else if (YellowPiece == 0) {
                                                winner = "draw"
                                                draw += 1
                                            } else {
                                                turn = "user"
                                            }
                                        }
                                    }
                            case .Red:
                                if connect.contains(index) {
                                    Image("Brave")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                } else {
                                    Image("Brave")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                }
                            case .Yellow:
                                if connect.contains(index) {
                                    Image("Friendship")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                                } else {
                                    Image("Friendship")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: geometry.size.width/9, height: geometry.size.width/9)
                            }
                        }
                    }
                }
                .padding()
                .background(Image("Digital"))
                .cornerRadius(15)
                .padding(.bottom)
                    
                HStack {
                   Spacer()
                    if (turn == "user" && winner == "") {
                        Text("Player 1 Turn")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    if (turn == "Yellow" && winner == "") {
                        Text("Player 2 Turn")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    if (winner == "Red") {
                        Text("Player 1 Win！")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                    } else if (winner == "Yellow") {
                        Text("Player 2 Win!")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    } else if (YellowPiece == 0){
                        Text("Draw")
                            .font(.largeTitle)
                    }
                        Spacer()
                }
                .padding(8)
                .background(Color(red: 70/255, green: 70/255, blue: 70/255))
                .cornerRadius(15)
                .padding(.bottom)
                if (winner != "") {
                    HStack {
                        Spacer()
                        Button {
                            Board = Array(repeating: Tile.Empty, count: 42)
                            RedPiece = 21
                            YellowPiece = 21
                            turn = "user"
                            finish = false
                            winner = ""
                            connect = []
                        } label: {
                            Text("New Round")
                                .bold()
                                .font(.largeTitle)
                            }
                            Spacer()
                        }
                        .padding(8)
                        .background(Color(red: 70/255, green: 70/255, blue: 70/255))
                        .cornerRadius(15)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            Board = Array(repeating: Tile.Empty, count: 42)
                            RedPiece = 21
                            YellowPiece = 21
                            turn = "user"
                            finish = false
                            winner = ""
                            connect = []
                            red = 0
                            yellow = 0
                            draw = 0
                            }
                            label: {
                            Text("Reset")
                            .bold()
                            .font(.title)
                            .scaledToFit()
                            .padding(9)
                            .background(Color(red: 70/255, green: 70/255, blue: 70/255))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding()
                
            }
            .background(Image("Digital").resizable())
            .navigationBarHidden(true)
        }
    }
    
    func redTurn(index: Int) {
        var cons = index
        while (cons+7 <= 41 && self.Board[cons+7] == Tile.Empty) {
            cons += 7
        }
        self.Board[cons] = Tile.Red
    }
    
    func yellowTurn(index: Int) {
        var cons = index
        while (cons+7 <= 41 && self.Board[cons+7] == Tile.Empty) {
            cons += 7
        }
        self.Board[cons] = Tile.Yellow
    }
    
    func PlayerWin() -> Bool {
        for row in 0...2 {
            for col in 0...3 {
                if (self.Board[7*row+col] != .Empty
                    && self.Board[7*row+col] == self.Board[7*row+col+8]
                    && self.Board[7*row+col+8] == self.Board[7*row+col+16]
                    && self.Board[7*row+col+16] == self.Board[7*row+col+24]) {
                    connect.append(7*row+col)
                    connect.append(7*row+col+8)
                    connect.append(7*row+col+16)
                    connect.append(7*row+col+24)
                    return true
                }
            }
        }
        for row in 0...2 {
            for col in 0...3 {
                if (self.Board[7*row+3+col] != .Empty
                    && self.Board[7*row+3+col] == self.Board[7*row+3+col+6]
                    && self.Board[7*row+3+col+6] == self.Board[7*row+3+col+12]
                    && self.Board[7*row+3+col+12] == self.Board[7*row+3+col+18]) {
                    connect.append(7*row+3+col)
                    connect.append(7*row+3+col+6)
                    connect.append(7*row+3+col+12)
                    connect.append(7*row+3+col+18)
                    return true
                }
            }
        }
        for row in 0...2 {
            for col in 0...6 {
                if (self.Board[7*row+col] != .Empty
                    && self.Board[7*row+col] == self.Board[7*row+col+7]
                    && self.Board[7*row+col+7] == self.Board[7*row+col+14]
                    && self.Board[7*row+col+14] == self.Board[7*row+col+21]) {
                    connect.append(7*row+col)
                    connect.append(7*row+col+7)
                    connect.append(7*row+col+14)
                    connect.append(7*row+col+21)
                    return true
                }
            }
        }
        for row in 0...5 {
            for col in 0...3 {
                if (self.Board[7*row+col+1] != .Empty
                    && self.Board[7*row+col] == self.Board[7*row+col+1]
                    && self.Board[7*row+col+1] == self.Board[7*row+col+2]
                    && self.Board[7*row+col+2] == self.Board[7*row+col+3]) {
                    connect.append(7*row+col)
                    connect.append(7*row+col+1)
                    connect.append(7*row+col+2)
                    connect.append(7*row+col+3)
                    return true
                }
            }
        }
        return false
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


