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
        case Win, Lose, Match3, Match4, Match5, Match6, Next, Prev, Close, Info, None
    }
    
    //For Win Dialog
    private var winCoverFrame:SKShapeNode!
    private var winFrame:SKShapeNode!
    private let winHomeButton = SKSpriteNode(imageNamed: "HomeG")
    private let winLevelButton = SKSpriteNode(imageNamed: "GridG")
    private let winResetButton = SKSpriteNode(imageNamed: "RewindG")
    private let winNextButton = SKSpriteNode(imageNamed: "FastForwardG")
    private let closeButton = SKSpriteNode(imageNamed: "CancelIcon")
    private let nextButton = SKSpriteNode(imageNamed: "NextPage")
    private let prevButton = SKSpriteNode(imageNamed: "PrevPage")

    private let title1Label = SKLabelNode(text: "title1")
    private let title2Label = SKLabelNode(text: "title2")
    private let title3Label = SKLabelNode(text: "Tap to continue")
    
    private let gameModel:GameModel
    private let gameSceneProtocol:GameSceneProtocol
    
    private var isOpen = false
    private var popupType : PopupType = .Match3
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
        winFrame.fillColor = UIColor(red: 1.0, green: 1.0, blue: 0.8 , alpha: 0.75)
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
        
        
        title1Label.position = CGPoint(x: bounds.size.width * 0.5, y: minY + popupSize.height - Constants.cellSize )
        title1Label.fontSize = 24
        title1Label.fontColor = Constants.fontColor
        title1Label.fontName = Constants.fontName
        title1Label.zPosition = Constants.popupZIndex
        sknodes.append(title1Label)
        
        title2Label.position = CGPoint(x: bounds.size.width * 0.5, y: minY + popupSize.height - 2.0*Constants.cellSize )
        title2Label.fontSize = 24
        title2Label.fontColor = Constants.fontColor
        title2Label.fontName = Constants.fontName
        title2Label.zPosition = Constants.popupZIndex
        sknodes.append(title2Label)
        
        title3Label.position = CGPoint(x: bounds.size.width * 0.5, y: minY + popupSize.height - 3.0*Constants.cellSize )
        title3Label.fontSize = 24
        title3Label.fontColor = Constants.fontColor
        title3Label.fontName = Constants.fontName
        title3Label.zPosition = Constants.popupZIndex
        sknodes.append(title3Label)
        
        //adding items and hide them
        for node in sknodes{
            node.isHidden = true
            gameSceneProtocol.onAddChild(child: node)
        }
        
        
        
    }
    
    func GetPopupType()->PopupType{
        return popupType
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
    
    private func HideAll(){
        for node in sknodes{
            node.isHidden = true
        }
    }
    
    func OpenInfoPopup( title1: String, title2: String ){
        
        if !isOpen {
            
            isOpen = true
            
            popupType = .Info
            
            HideAll()
            
            title1Label.text = title1
            title1Label.isHidden = false
            
            title2Label.text = title2
            title2Label.isHidden = false
            
            title3Label.isHidden = false
            
            winCoverFrame.isHidden = false
            winFrame.isHidden = false
            title1Label.isHidden = false
        }
    }
    
    func OpenPopup( type: PopupType ){
        if !isOpen {
            
            isOpen = true
            
            popupType = type
            
            HideAll()
            title1Label.isHidden = false
            
            title1Label.text = GetTileString(type: type)
            winCoverFrame.isHidden = false
            winFrame.isHidden = false
            title1Label.isHidden = false
            
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
                break
                
            case .Match4:
                closeButton.isHidden = false
                nextButton.isHidden = false
                prevButton.isHidden = false
                break
                
            default:
                break
            }
        }
    }
    
    func ClosePopup(){
        if isOpen {
            isOpen = false
            HideAll()
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
        switch ( popupType ){
        case .Match3:
            popupType = .Match4
            break
            
        case .Match4:
            popupType = .Match5
            break
            
        case .Match5:
            popupType = .Match3
            break
            
        default:
            break
        }

        title1Label.text = GetTileString(type: popupType)
    }
    
    func onPrevButton(){
        switch ( popupType ){
        case .Match3:
            popupType = .Match5
            break
            
        case .Match4:
            popupType = .Match3
            break
            
        case .Match5:
            popupType = .Match4
            break
            
        default:
            break
        }
        
        title1Label.text = GetTileString(type: popupType)
    }
    
    func onCloseButton(){
        ClosePopup()
    }
}
