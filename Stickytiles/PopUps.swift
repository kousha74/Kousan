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
    
    enum PopupType:Int{
        case Win, Lose, Match3, Match4, Match5, Match6, Row, Col, Four, Yellow, Green, Blocker, Blocked, Baloon, Question, Chocolate, Next, Prev, Close, Info, None
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
    
    private let match3Image = SKSpriteNode(imageNamed: "Match3")
    private let match4Image = SKSpriteNode(imageNamed: "Match4")
    private let match5Image = SKSpriteNode(imageNamed: "Match5")
    private let match6Image = SKSpriteNode(imageNamed: "Match6")

    private let title1Label = SKLabelNode(text: "title1")
    private let title2Label = SKLabelNode(text: "title2")
    private let title3Label = SKLabelNode(text: "Tap to continue")
    
    private let gameModel:GameModel
    private let gameSceneProtocol:GameSceneProtocol
    
    private var isOpen = false
    private var popupType : PopupType = .Match3
    private var sknodes = [SKNode]()
    
    private let popupSize = CGSize(width: 300 - Constants.cellSize, height: 400)
    
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
        
        
        match3Image.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.25)
        match3Image.zPosition = Constants.popupZIndex
        sknodes.append(match3Image)
        
        match4Image.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.25)
        match4Image.zPosition = Constants.popupZIndex
        sknodes.append(match4Image)
        
        match5Image.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.25)
        match5Image.zPosition = Constants.popupZIndex
        sknodes.append(match5Image)
        
        match6Image.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.25)
        match6Image.zPosition = Constants.popupZIndex
        sknodes.append(match6Image)
        

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
        
        title2Label.position = CGPoint(x: bounds.size.width * 0.5, y: minY + popupSize.height - 1.75*Constants.cellSize )
        title2Label.fontSize = 24
        title2Label.fontColor = Constants.fontColor
        title2Label.fontName = Constants.fontName
        title2Label.zPosition = Constants.popupZIndex
        sknodes.append(title2Label)
        
        title3Label.position = CGPoint(x: bounds.size.width * 0.5, y: minY + popupSize.height - 2.5*Constants.cellSize )
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
    
    func UpdateWidgets(){
        
        HideAll()
        title1Label.isHidden = false
        
        winCoverFrame.isHidden = false
        winFrame.isHidden = false
        title1Label.isHidden = false
        
        if popupType.rawValue >= PopupType.Match3.rawValue && popupType.rawValue <= PopupType.Chocolate.rawValue {
            closeButton.isHidden = false
            nextButton.isHidden = false
            prevButton.isHidden = false
        }

        switch ( popupType ){
        case .Win:
            title1Label.text = "Nice job, You Won!"
            winHomeButton.isHidden = false
            winLevelButton.isHidden = false
            winResetButton.isHidden = false
            winNextButton.isHidden = false
            break
            
        case .Lose:
            title1Label.text = "You Lost!, Try again"
            winHomeButton.isHidden = false
            winLevelButton.isHidden = false
            winResetButton.isHidden = false
            break
        
        case .Match3:
            title1Label.text = "Match 3 fruits"
            title2Label.text = "to remove them"
            title2Label.isHidden = false
            match3Image.isHidden = false
            break
            
        case .Match4:
            title1Label.text = "Match 4 fruits"
            title2Label.text = "create a special fruit"
            title2Label.isHidden = false
            match4Image.isHidden = false
            break
            
        case .Match5:
            title1Label.text = "Match 5 fruits"
            title2Label.text = "create a yellow star"
            title2Label.isHidden = false
            match5Image.isHidden = false
            break
            
        case .Match6:
            title1Label.text = "Match 6 fruits"
            title2Label.text = "create a green star"
            title2Label.isHidden = false
            match6Image.isHidden = false
            break

        case .Row:
            title1Label.text = "Remove row fruit"
            title2Label.text = "to remove a row"
            title2Label.isHidden = false
            break
            
        case .Col:
            title1Label.text = "Remove column fruit"
            title2Label.text = "to remove a column"
            title2Label.isHidden = false
            break
            
        case .Four:
            title1Label.text = "Remove power fruit"
            title2Label.text = "To remove all fruits"
            title2Label.isHidden = false
            title3Label.text = "of the same type"
            title3Label.isHidden = false
            break
            
        case .Yellow:
            title1Label.text = "Tap yellow star"
            title2Label.text = "to remove row,"
            title2Label.isHidden = false
            title3Label.text = "and column"
            title3Label.isHidden = false
            break
            
        case .Green:
            title1Label.text = "Tap green star"
            title2Label.text = "to remove row,"
            title2Label.isHidden = false
            title3Label.text = "column, and diagonally"
            title3Label.isHidden = false
            break
            
        case .Blocker:
            title1Label.text = "Tap empty space"
            title2Label.text = "to create a"
            title2Label.isHidden = false
            title3Label.text = "temporary blocker"
            title3Label.isHidden = false
            break
            
        case .Blocked:
            title1Label.text = "Blockers don't move"
            break
            
        case .Baloon:
            title1Label.text = "Tap a ballon"
            title2Label.text = "to remove it"
            title2Label.isHidden = false
            break
            
        case .Question:
            title1Label.text = "Remove a neighboring"
            title2Label.text = "fruit to reveal"
            title2Label.isHidden = false
            title3Label.text = "the fruit"
            title3Label.isHidden = false
            break
            
        case .Chocolate:
            title1Label.text = "Bring chocolate down"
            title2Label.text = "to remove it"
            title2Label.isHidden = false
            break
            
            
        default:
            title1Label.text = "Text missing!!!"
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
            
            UpdateWidgets()
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
        
        if popupType == .Chocolate{
            popupType = .Match3
        }
        else{
            popupType = PopupType( rawValue: popupType.rawValue + 1)!
        }

        UpdateWidgets()
    }
    
    func onPrevButton(){
        if popupType == .Match3{
            popupType = .Chocolate
        }
        else{
            popupType = PopupType( rawValue: popupType.rawValue - 1)!
        }
        
        UpdateWidgets()
    }
    
    func onCloseButton(){
        ClosePopup()
    }
}
