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
    static let APPLE_ID = 1
    static let BUBBLE_ID = 10
    static let STAR5_ID = 11
    static let STAR7_ID = 12
    static let CHOLOLATE_ID = 13
    static let BLOCKER_ID = 14
    static let BLOCKED_ID = 15
    static let QUESTION_ID = 16
    
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
    
    init( x: Int, y: Int, id: Int, cellSize: Int, viewOffset: CGPoint){
        
        self.id = id
        pos = CGPoint(x: x, y: y)
            
        sprite = SKSpriteNode(imageNamed: "Apple" )
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
        
        SetTileImage()
    }
    
    func GetClusterType()->ClusterType{
        return clusterType
    }
    
    func SetID(Id:Int){
        id = Id
        SetTileImage()
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
    
    func IsFruit()->Bool{
        return id < TileNode.BUBBLE_ID
    }
    
    func SetTileImage(){
        
        //special tiles
        if !IsFruit() {
            switch(id){
            case TileNode.BUBBLE_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Balloon"))
                return
            case TileNode.STAR5_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Star5"))
                return
            case TileNode.STAR7_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Star7"))
                return
            case TileNode.CHOLOLATE_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "chocolate"))
                return
            case TileNode.BLOCKER_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "blocker"))
                return
            case TileNode.BLOCKED_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Blocked"))
                return
            case TileNode.QUESTION_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "QuestionMark"))
                return
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "QuestionMark"))
                return
                
            }
        }
        
        switch clusterType {
        case .None:
            switch(id){
            case 1:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
                return
            case 2:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apricot"))
                return
            case 3:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Cherry"))
                return
            case 4:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Kiwi"))
                return
            case 5:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Lemon"))
                return
            case 6:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Orange"))
                return
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
                return
                
            }
            
        case .Row:
            switch(id){
            case 1:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "AppleR"))
                return
            case 2:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "ApricotR"))
                return
            case 3:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "CherryR"))
                return
            case 4:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "KiwiR"))
                return
            case 5:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "LemonR"))
                return
            case 6:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "OrangeR"))
                return
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "AppleR"))
                return
                
            }
            
        case .Col:
            switch(id){
            case 1:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "AppleC"))
                return
            case 2:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "ApricotC"))
                return
            case 3:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "CherryC"))
                return
            case 4:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "KiwiC"))
                return
            case 5:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "LemonC"))
                return
            case 6:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "OrangeC"))
                return
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "AppleC"))
                return
                
            }
            
        case .Four:
            switch(id){
            case 1:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple4"))
                return
            case 2:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apricot4"))
                return
            case 3:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Cherry4"))
                return
            case 4:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Kiwi4"))
                return
            case 5:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Lemon4"))
                return
            case 6:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Orange4"))
                return
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple4"))
                return
                
            }
            
        default:
            switch(id){
            case 1:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
                return
            case 2:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apricot"))
                return
            case 3:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Cherry"))
                return
            case 4:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Kiwi"))
                return
            case 5:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Lemon"))
                return
            case 6:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Orange"))
                return
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
                return
                
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
