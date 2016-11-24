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
    
    enum PopupType{
        case Win, Lose, Match3, Match4, Match5, Match6, Next, Prev, Close, None
    }
    
    //For Win Dialog
    private var winCoverFrame:SKShapeNode!
    private var winFrame:SKShapeNode!
    private let winHomeButton = SKSpriteNode(imageNamed: "HomeG")
    private let winLevelButton = SKSpriteNode(imageNamed: "GridG")
    private let winResetButton = SKSpriteNode(imageNamed: "RewindG")
    private let winNextButton = SKSpriteNode(imageNamed: "FastForwardG")
    private let winTitleLabel = SKLabelNode(text: "You Won!")
    private let closeButton = SKSpriteNode(imageNamed: "HomeG")
    private let nextButton = SKSpriteNode(imageNamed: "NextPage")
    private let prevButton = SKSpriteNode(imageNamed: "PrevPage")
    
    private let gameModel:GameModel
    private let gameSceneProtocol:GameSceneProtocol
    
    private var isOpen = false
    private var currentHelpPage = PopupType.Match3
    private var sknodes = [SKNode]()
    
    private let popupSize = CGSize(width: 300 - Constants.cellSize, height: 300)
    
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
        
        winHomeButton.position = CGPoint(x: minX + popupSize.width*1.4/10.0 , y: buttonY)
        winHomeButton.zPosition = Constants.popupZIndex
        sknodes.append(winHomeButton)
        
        prevButton.position = CGPoint(x: minX + popupSize.width*1.4/10.0 , y: buttonY)
        prevButton.zPosition = Constants.popupZIndex
        sknodes.append(prevButton)
        
        
        winLevelButton.position = CGPoint(x: minX + popupSize.width*3.8/10.0 , y: buttonY)
        winLevelButton.zPosition = Constants.popupZIndex
        sknodes.append(winLevelButton)
        
        
        winResetButton.position = CGPoint(x: minX + popupSize.width*6.2/10.0 , y: buttonY)
        winResetButton.zPosition = Constants.popupZIndex
        sknodes.append(winResetButton)
        
        
        winNextButton.position = CGPoint(x: minX + popupSize.width*8.6/10.0 , y: buttonY)
        winNextButton.zPosition = Constants.popupZIndex
        sknodes.append(winNextButton)
        
        nextButton.position = CGPoint(x: minX + popupSize.width*8.6/10.0 , y: buttonY)
        nextButton.zPosition = Constants.popupZIndex
        sknodes.append(nextButton)
        
        closeButton.position = CGPoint(x: minX + popupSize.width , y: minY + popupSize.height)
        closeButton.zPosition = Constants.popupZIndex
        sknodes.append(closeButton)
        
        
        winTitleLabel.position = CGPoint(x: bounds.size.width * 0.5, y: minY + popupSize.height - Constants.cellSize )
        winTitleLabel.fontSize = 24
        winTitleLabel.fontColor = SKColor.blue
        winTitleLabel.fontName = "Papyrus"
        winTitleLabel.zPosition = Constants.popupZIndex
        sknodes.append(winTitleLabel)
        
        //adding items and hide them
        for node in sknodes{
            node.isHidden = true
            gameSceneProtocol.onAddChild(child: node)
        }
        
        
        
    }
    
    func IsOpen()->Bool{
        return isOpen
    }
    
    func GetTileString( type: PopupType )->String{
        switch ( type ){
        case .Win:
            return "Nice job, You Won!"
            
        case .Lose:
            return "You Lost!, Try again"
        
        case .Match3:
            return "Match 3 fruits"
            
        case .Match4:
            return "Match 4 fruits"
            
        case .Match5:
            return "Match 5 fruits"
            
        default:
            return "Text missing!!!"
        }
        
    }
    
    func OpenPopup( type: PopupType ){
        if !isOpen {
            
            isOpen = true
            
            winTitleLabel.text = GetTileString(type: type)
            winCoverFrame.isHidden = false
            winFrame.isHidden = false
            winTitleLabel.isHidden = false
            
            switch ( type ){
            case .Win:
                winHomeButton.isHidden = false
                winLevelButton.isHidden = false
                winResetButton.isHidden = false
                winNextButton.isHidden = false
                break
                
            case .Lose:
                winHomeButton.isHidden = false
                winLevelButton.isHidden = false
                winResetButton.isHidden = false
                break
                
            case .Match3:
                closeButton.isHidden = false
                nextButton.isHidden = false
                prevButton.isHidden = false
                currentHelpPage = type
                break
                
            case .Match4:
                closeButton.isHidden = false
                nextButton.isHidden = false
                prevButton.isHidden = false
                currentHelpPage = type
                break
                
            default:
                break
            }
        }
    }
    
    func ClosePopup(){
        if isOpen {
            isOpen = false
            for node in sknodes{
                node.isHidden = true
            }
        }
    }
    
    func GetTouchedButton( nodes:[SKNode] )->TouchedButton{
        
        var touchedButton = TouchedButton.None
        
        for touchedNode in nodes {
            if ( touchedNode.isEqual(to: winHomeButton )){
                touchedButton = .Home
                break
            }
            else if ( touchedNode.isEqual(to: winLevelButton )){
                touchedButton = .Level
                break
            }
            else if ( touchedNode.isEqual(to: winResetButton )){
                touchedButton = .Reset
                break
            }
            else if ( touchedNode.isEqual(to: winNextButton )){
                touchedButton = .Next
                break
            }
            else if ( touchedNode.isEqual(to: nextButton )){
                onNextButton()
                break
            }
            else if ( touchedNode.isEqual(to: prevButton )){
                onPrevButton()
                break
            }
            else if ( touchedNode.isEqual(to: closeButton )){
                onCloseButton()
                break
            }
        }
        
        return touchedButton
    }
    
    func onNextButton(){
        switch ( currentHelpPage ){
        case .Match3:
            currentHelpPage = .Match4
            break
            
        case .Match4:
            currentHelpPage = .Match5
            break
            
        case .Match5:
            currentHelpPage = .Match3
            break
            
        default:
            break
        }

        winTitleLabel.text = GetTileString(type: currentHelpPage)
    }
    
    func onPrevButton(){
        switch ( currentHelpPage ){
        case .Match3:
            currentHelpPage = .Match5
            break
            
        case .Match4:
            currentHelpPage = .Match3
            break
            
        case .Match5:
            currentHelpPage = .Match4
            break
            
        default:
            break
        }
        
        winTitleLabel.text = GetTileString(type: currentHelpPage)
    }
    
    func onCloseButton(){
        ClosePopup()
    }
}
