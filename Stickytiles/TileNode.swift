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
    static let BUBBLE_ID = 10
    static let STAR5_ID = 11
    static let STAR7_ID = 12
    static let CHOLOLATE_ID = 13
    static let BLOCKER_ID = 14
    static let BLOCKED_ID = 15
    
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
    
    func CanBeRemoved()->Bool{
        return id != TileNode.BLOCKED_ID && id != TileNode.BLOCKER_ID && id != TileNode.CHOLOLATE_ID && !GetFlag(flag: TileNode.IS_LOCKED)
    }
    
    func CanMove()->Bool{
        return id != TileNode.BLOCKED_ID && id != TileNode.BLOCKER_ID
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
        
        switch ( clusterType ){
        case .Five:
            id = TileNode.STAR5_ID
            break
            
        case .Six:
            id = TileNode.STAR7_ID
            break
            
        default:
            break
        }
        
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
        
        //special tiles
        if ( id >= TileNode.BUBBLE_ID ) {
            switch(id){
            case TileNode.BUBBLE_ID:
                return "Balloon"
            case TileNode.STAR5_ID:
                return "Star5"
            case TileNode.STAR7_ID:
                return "Star7"
            case TileNode.CHOLOLATE_ID:
                return "chocolate"
            case TileNode.BLOCKER_ID:
                return "texture1"
            case TileNode.BLOCKED_ID:
                return "Blocked"
            default:
                return "gray"
                
            }
        }
        
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
        
        if isSet && flag == TileNode.TBP {
            let scaleUp = SKAction.scale(to: 1.25, duration: GameModel.delay/2.0)
            let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay/2.0)
            self.sprite?.run(SKAction.repeatForever(SKAction.sequence([scaleUp,scaleDown])))
        }
    }
    
    func GetFlag( flag: Int )->Bool{
        return flags[ flag ]
    }
}
