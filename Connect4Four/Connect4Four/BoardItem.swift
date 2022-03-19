//
//  BoardItem.swift
//  Connect4Four
//
//  Created by User15 on 2022/3/18.
//

import Foundation
import UIKit

enum Tile {
    case Red
    case Yellow
    case Empty
}

struct BoardItem {
    var indexPath: IndexPath!
    var tile: Tile!
    
    func yellowTile() -> Bool {
        return tile == Tile.Yellow
    }
    
    func redTile() -> Bool {
        return tile == Tile.Red
    }
    
    func emptyTile() -> Bool {
        return tile == Tile.Empty
    }
    
    func tileColor() -> UIColor {
        if redTile() {
            return .red
        }
        if yellowTile() {
            return .yellow
        }
        return .white
    }
}
