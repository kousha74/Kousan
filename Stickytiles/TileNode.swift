//
//  TileNode.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/29/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import UIKit
import SpriteKit

class TileNode {
    
    // MARK : constants
    static let IS_MOVING:Int = 0
    static let IS_VISITED:Int = 1
    static let IS_LOCKED:Int = 2
    static let DeleteMe:Int = 3 //TBD
    static let TBP:Int = 4 //to be processed
    var flags = [false,false,false,false,false]
    
    enum ClusterType {
        case None, Row, Col, Four, Five, Six
    }

    // MARK : member variables
    private var clusterType = ClusterType.None
    private var id:Int
    var pos:CGPoint
    var sprite : SKSpriteNode?
    
    init( x: Int, y: Int, id: Int, locked:Bool, cellSize: Int, viewOffset: CGPoint){
        
        self.id = id
        pos = CGPoint(x: x, y: y)
    
        if ( locked ){
            flags[ TileNode.IS_LOCKED] = true
        }
        
        sprite = SKSpriteNode(imageNamed: GetTileImage() )
        sprite?.position.x = viewOffset.x + (CGFloat(x)+CGFloat(0.5))*CGFloat(cellSize)
        sprite?.position.y = viewOffset.y + (CGFloat(y)+CGFloat(0.5))*CGFloat(cellSize)
    }
    
    //Resets the tile to be reused
    func Reset(){
        id = 0
        
        for i in 0...flags.count-1{
            flags[i] = false
        }
        
        clusterType = ClusterType.None
        
        sprite?.removeAllActions()
        sprite?.alpha = 1.0
    }
    
    func SetClusterType( type:ClusterType ){
        clusterType = type
        sprite?.texture = SKTexture(imageNamed:GetTileImage())
    }
    
    func GetClusterType()->ClusterType{
        return clusterType
    }
    
    func SetID(Id:Int){
        id = Id
        sprite?.texture = SKTexture(imageNamed:GetTileImage())
    }
    
    func GetID()->Int{
        return id
    }
    
    func GetRow()->Int{
        return Int(pos.y)
    }
    
    func GetCol()->Int{
        return Int(pos.x)
    }
    
    func SetRowAndCol( row:Int, col:Int, cellSize:Int, viewOffset: CGPoint ){
        pos.x = CGFloat(col)
        pos.y = CGFloat(row)
        sprite?.position.x = viewOffset.x + (CGFloat(col)+CGFloat(0.5))*CGFloat(cellSize)
        sprite?.position.y = viewOffset.y + (CGFloat(row)+CGFloat(0.5))*CGFloat(cellSize)
    }
    
    func GetTileImage()->String{
        
        switch clusterType {
        case .None:
            switch(id){
            case 1:
                return "Apple"
            case 2:
                return "Apricot"
            case 3:
                return "Cherry"
            case 4:
                return "Kiwi"
            case 5:
                return "Lemon"
            case 6:
                return "Orange"
            default:
                return "gray"
                
            }
            
        case .Row:
            switch(id){
            case 1:
                return "AppleR"
            case 2:
                return "ApricotR"
            case 3:
                return "CherryR"
            case 4:
                return "KiwiR"
            case 5:
                return "LemonR"
            case 6:
                return "OrangeR"
            default:
                return "gray"
            }
            
        case .Col:
            switch(id){
            case 1:
                return "AppleC"
            case 2:
                return "ApricotC"
            case 3:
                return "CherryC"
            case 4:
                return "KiwiC"
            case 5:
                return "LemonC"
            case 6:
                return "OrangeC"
            default:
                return "gray"
            }
            
        case .Four:
            switch(id){
            case 1:
                return "Apple4"
            case 2:
                return "Apricot4"
            case 3:
                return "Cherry4"
            case 4:
                return "Kiwi4"
            case 5:
                return "Lemon4"
            case 6:
                return "Orange4"
            default:
                return "gray"
            }
            
        default:
        
            switch(id){
            case 1:
                return "Apple"
            case 2:
                return "Apricot"
            case 3:
                return "Cherry"
            case 4:
                return "Kiwi"
            case 5:
                return "Lemon"
            case 6:
                return "Orange"
            default:
                return "gray"
            }
        }
        
  /*      if ( clusterType != .None ) {
            switch(id){
            case 1:
                return "redLock"
            case 2:
                return "greenLocked"
            case 3:
                return "blueLock"
            case 4:
                return "yellowLocked"
            case 5:
                return "cyanLocked"
            case 6:
                return "magentaLocked"
            default:
                return "grayLocked"
                
            }
        }
        else {
            switch(id){
            case 1:
                return "red"
            case 2:
                return "green"
            case 3:
                return "blue"
            case 4:
                return "yellow"
            case 5:
                return "cyan"
            case 6:
                return "magenta"
            default:
                return "gray"
                
            }
        }*/
    }
    
    func Occupies( pos: CGPoint )->Bool
    {
        return ( ( self.id != 0 ) && ( self.pos.x == pos.x ) && ( self.pos.y == pos.y ) )
    }
    
    func Moveto( delta_row: Int, delta_col: Int, cellSize: CGFloat, viewOffset: CGPoint )
    {
        self.pos.y = CGFloat(delta_row)
        self.pos.x = CGFloat(delta_col)
        
        let actionMove = SKAction.move(to:
            CGPoint(
                x: viewOffset.x + pos.x*cellSize + cellSize/2,
                y: viewOffset.y + pos.y*cellSize + cellSize/2),
            duration: TimeInterval(GameModel.delay))
        
        self.sprite?.run(actionMove)
    }
    
    func IsMoving()->Bool{
        return flags[TileNode.IS_MOVING]
    }
    
    func SetFlag( flag: Int, isSet:Bool){
        flags[ flag ] = isSet
    }
    
    func GetFlag( flag: Int )->Bool{
        return flags[ flag ]
    }
}
