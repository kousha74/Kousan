//
//  PopUps.swift
//  Magictiles
//
//  Created by Kousha moaveninejad on 11/24/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import Foundation
import SpriteKit

class Popups{

    enum TouchedButton{
        case Home, Level, Reset, Next, None
    }
    
    //For Win Dialog
    private var winCoverFrame:SKShapeNode!
    private var winFrame:SKShapeNode!
    private let winHomeButton = SKSpriteNode(imageNamed: "HomeG")
    private let winLevelButton = SKSpriteNode(imageNamed: "GridG")
    private let winResetButton = SKSpriteNode(imageNamed: "RewindG")
    private let winNextButton = SKSpriteNode(imageNamed: "FastForwardG")
    private let winTitleLabel = SKLabelNode(text: "You Won!")
    
    private let gameModel:GameModel
    private let gameSceneProtocol:GameSceneProtocol
    
    private var isOpen = false
    private var sknodes = [SKNode]()
    
    private let popupSize = CGSize(width: 300, height: 300)
    
    required init( bounds: CGRect, gameSceneProtocol: GameSceneProtocol ) {
        
        gameModel = GameModel.sharedInstance
        self.gameSceneProtocol = gameSceneProtocol
        
        
        
        //For Win Dialog
        let winSize = bounds.size
        winCoverFrame = SKShapeNode(rect: CGRect(x: Int(-winSize.width*0.5), y: Int(-winSize.height*0.5), width: Int(winSize.width), height: Int(winSize.height)), cornerRadius: 0)
        winCoverFrame.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.0)
        winCoverFrame.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        //winCoverFrame.strokeColor = UIColor.darkGray
        //winCoverFrame.lineWidth = 5
        winCoverFrame.zPosition = Constants.popupZIndex
        sknodes.append(winCoverFrame)
        
        
        winFrame = SKShapeNode(rect: CGRect(x: Int(-popupSize.width*0.5), y: Int(-popupSize.height*0.5), width: Int(popupSize.width), height: Int(popupSize.height)), cornerRadius: 10)
        winFrame.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.0)
        winFrame.fillColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.75)
        winFrame.strokeColor = UIColor.darkGray
        winFrame.lineWidth = 5
        winFrame.zPosition = Constants.popupZIndex
        sknodes.append(winFrame)
        
        
        let minY = ( bounds.height - popupSize.height )/2.0
        let minX = ( bounds.width - popupSize.width )/2.0
        let buttonY = minY + Constants.cellSize
        
        winHomeButton.position = CGPoint(x: minX + popupSize.width*2.0/10.0 , y: buttonY)
        winHomeButton.zPosition = Constants.popupZIndex
        sknodes.append(winHomeButton)
        
        
        winLevelButton.position = CGPoint(x: minX + popupSize.width*4.0/10.0 , y: buttonY)
        winLevelButton.zPosition = Constants.popupZIndex
        sknodes.append(winLevelButton)
        
        
        winResetButton.position = CGPoint(x: minX + popupSize.width*6.0/10.0 , y: buttonY)
        winResetButton.zPosition = Constants.popupZIndex
        sknodes.append(winResetButton)
        
        
        winNextButton.position = CGPoint(x: minX + popupSize.width*8.0/10.0 , y: buttonY)
        winNextButton.zPosition = Constants.popupZIndex
        sknodes.append(winNextButton)
        
        
        winTitleLabel.position = CGPoint(x: bounds.size.width * 0.5, y: minY + popupSize.height - 2.0*Constants.cellSize )
        winTitleLabel.fontSize = 36
        winTitleLabel.fontColor = SKColor.blue
        winTitleLabel.fontName = "Papyrus"
        winTitleLabel.zPosition = Constants.popupZIndex
        sknodes.append(winTitleLabel)
        
        
    }
    
    func IsOpen()->Bool{
        return isOpen
    }
    
    func OpenPopup(){
        if !isOpen {
            isOpen = true
            for node in sknodes{
                gameSceneProtocol.onAddChild(child: node)
            }
        }
    }
    
    func ClosePopup(){
        if isOpen {
            isOpen = false
            for node in sknodes{
                node.removeFromParent()
            }
        }
    }
    
    func GetTouchedButton( nodes:[SKNode] )->TouchedButton{
        
        var touchedButton = TouchedButton.None
        
        for touchedNode in nodes {
            if ( touchedNode.isEqual(to: winHomeButton )){
                touchedButton = .Home
            }
            else if ( touchedNode.isEqual(to: winLevelButton )){
                touchedButton = .Level
            }
            else if ( touchedNode.isEqual(to: winResetButton )){
                touchedButton = .Reset
            }
            else if ( touchedNode.isEqual(to: winNextButton )){
                touchedButton = .Next
            }
        }
        
        return touchedButton
    }
}
