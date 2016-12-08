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
    
    init(){
        
        id = 0
        pos = CGPoint(x: 0, y: 0)
            
        sprite = SKSpriteNode(imageNamed: "Apple" )
        sprite?.position.x = 0.0
        sprite?.position.y = 0.0
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
        sprite?.removeAllChildren()
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
                break
            case TileNode.STAR5_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Star5"))
                break
            case TileNode.STAR7_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Star7"))
                break
            case TileNode.CHOLOLATE_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "chocolate"))
                break
            case TileNode.BLOCKER_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "blocker"))
                break
            case TileNode.BLOCKED_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Blocked"))
                break
            case TileNode.QUESTION_ID:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "QuestionMark"))
                break
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "QuestionMark"))
                break
                
            }
        }
        else{
        
            switch(id){
            case 1:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
                break
            case 2:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apricot"))
                break
            case 3:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Cherry"))
                break
            case 4:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Kiwi"))
                break
            case 5:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Lemon"))
                break
            case 6:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Orange"))
                break
            default:
                sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
                break
                
            }
        }
                    
        switch clusterType {
        case .None:
            break
        case .Row:
            let arrowSprite = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "ArrowR")))
            arrowSprite.position = CGPoint(x: 0, y: 0)
            arrowSprite.zPosition = Constants.arrowZIndex
            sprite?.addChild(arrowSprite)
            print("Marked as arrow")
            break
        case .Col:
            let arrowSprite = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "ArrowC")))
            arrowSprite.position = CGPoint(x: 0, y: 0)
            arrowSprite.zPosition = Constants.arrowZIndex
            sprite?.addChild(arrowSprite)
            break
        case .Four:
            let arrowSprite = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Arrow4")))
            arrowSprite.position = CGPoint(x: 0, y: 0)
            arrowSprite.zPosition = Constants.arrowZIndex
            sprite?.addChild(arrowSprite)
            break
        default:
            break
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
