//
//  GameScene.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/22/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneProtocol{
    func onNewTile(tile:TileNode)
    func onAddChild(child: SKNode)
    func UpdateLabels()
}


class GameScene: SKScene,GameSceneProtocol {
    
    let levelLabel = SKLabelNode(text: "Level: 0")
    let scoreLabel = SKLabelNode(text: "Score")
    let titleLabel = SKLabelNode(text: "Sticky Tiles")
    let moveCountLabel = SKLabelNode(text: "Moves: 0")
    let homeButton = SKSpriteNode(imageNamed: "HomeG")
    let levelButton = SKSpriteNode(imageNamed: "GridG")
    let resetButton = SKSpriteNode(imageNamed: "RewindG")
    let musicButton = SKSpriteNode(imageNamed: "MusicOn")
    let soundButton = SKSpriteNode(imageNamed: "SoundOn")
    let helpButton = SKSpriteNode(imageNamed: "SoundOn")
    
    var gameManager:GameManager?
    var gameModel: GameModel = GameModel.sharedInstance
    
    private var popups: Popups?
        
    override func didMove(to view: SKView) {
        
        popups = Popups(bounds: view.bounds, gameSceneProtocol: self )
        
        backgroundColor = SKColor.white
        
        ///The game board
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        let boardPadding : Int = 5
        let cellSize = gameModel.GetCellSize()
        let shape = SKShapeNode(rect: CGRect(x: -boardPadding, y: -boardPadding, width: boardSize+2*boardPadding, height: boardSize+2*boardPadding), cornerRadius: 10)
        
        shape.position = CGPoint(x: viewOffset.x, y: viewOffset.y)
        shape.fillColor = UIColor.lightGray
        shape.strokeColor = UIColor.black
        shape.lineWidth = 2
        addChild(shape)
        
        //tbd dangerous assumption
        GameEngine.sharedInstance.SetParent(parent: self)
        GameEngine.sharedInstance.LoadGame(level: gameModel.getCurrentLevel() )
        
        titleLabel.position = CGPoint(x: size.width * 0.5, y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(cellSize) )
        titleLabel.fontSize = 36
        titleLabel.fontColor = SKColor.blue
        titleLabel.fontName = "Papyrus"
        addChild(titleLabel)
        
        
        let y = viewOffset.y - 1.5*CGFloat(cellSize)
        
        homeButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)/10.0 , y: y)
        addChild(homeButton)
        
        levelButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*3.0/10.0, y: y)
        addChild(levelButton)

        resetButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*5.0/10.0, y: y)
        addChild(resetButton)
        
        musicButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*7.0/10.0, y: y)
        addChild(musicButton)
        
        soundButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*9.0/10.0, y: y)
        addChild(soundButton)
        
        print("\(size.width)-----\(size.height)")
        
        helpButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize) - 0.5*CGFloat(cellSize), y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(cellSize) ) //tbd hard coded value
        addChild(helpButton)
        
        //Move count
        let moveCountShape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 3.0*CGFloat(cellSize), height: CGFloat(cellSize)), cornerRadius: 5)
        moveCountShape.position = CGPoint(x: viewOffset.x + 3.0*CGFloat(cellSize) + 1.0*CGFloat(boardPadding), y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(boardPadding) )
        moveCountShape.fillColor = UIColor.lightGray
        moveCountShape.strokeColor = UIColor.black
        moveCountShape.lineWidth = 1
        //addChild(moveCountShape)
        
        
        moveCountLabel.position = CGPoint(x: viewOffset.x + 4.5*CGFloat(cellSize), y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(boardPadding) + 0.5*CGFloat(cellSize) )
        moveCountLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        moveCountLabel.fontSize = 24
        moveCountLabel.fontColor = SKColor.blue
        moveCountLabel.fontName = "Papyrus"
        addChild(moveCountLabel)
        
        scoreLabel.position = CGPoint(x: viewOffset.x + 2.0*CGFloat(boardPadding), y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(boardPadding) + 0.5*CGFloat(cellSize) )
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = SKColor.blue
        scoreLabel.fontName = "Papyrus"
        addChild(scoreLabel)
        
        
        levelLabel.position = CGPoint(x: scoreLabel.frame.minX, y: scoreLabel.frame.maxY + 0.5*CGFloat(cellSize) )
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        levelLabel.fontSize = 24
        levelLabel.fontColor = SKColor.blue
        levelLabel.fontName = "Papyrus"
        levelLabel.text = "Level " + String(gameModel.getCurrentLevel()+1)
        addChild(levelLabel)
        
        if ( !gameModel.IsMusicOn() ){
            musicButton.texture = SKTexture(imageNamed: "MusicOff")
        }
        
        if ( !gameModel.IsAudioOn() ){
            soundButton.texture = SKTexture(imageNamed: "SoundOff")
        }        
    }
    
    func removeTiles()
    {
        if ( gameModel.GetTileCount() > 0 ) {
            for index in 0...gameModel.GetTileCount()-1{
                gameModel.GetSpriteNode(index: index).removeFromParent();
            }
        }
    }
    
    func addTiles()
    {
        if ( gameModel.GetTileCount() > 0 ) {
            for index in 0...gameModel.GetTileCount()-1{
                addChild( gameModel.GetSpriteNode(index: index) )
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        
        let touchedNodes = nodes(at: touch.location(in: self))
        
        if ( popups?.IsOpen() )!{
            
            if let touchedButton = popups?.GetTouchedButton(nodes: touchedNodes) {
                switch ( touchedButton ){
                    
                case .Home:
                    gameManager?.onHomeButtonPressed(moveCount: 0)
                    break
                    
                case .Level:
                    gameManager?.onLevelButtonPressed(moveCount: 0)
                    break
                    
                case .Reset:
                    popups?.ClosePopup()
                    GameEngine.sharedInstance.LoadGame(level: gameModel.getCurrentLevel() )
                    break
                    
                case .Next:
                    popups?.ClosePopup()
                    removeTiles() //TBD
                    gameModel.IncreaseCurrentLevel()
                    GameEngine.sharedInstance.LoadGame(level: gameModel.getCurrentLevel())
                    break
                    
                case .None:
                    break
                }
            }
        }
        else if ( touchedNodes.count > 0 ){
            let firstTouchedNode = touchedNodes[0]
            
            if ( firstTouchedNode.isEqual(to: homeButton )){
                print("Home button")
                gameManager?.onHomeButtonPressed(moveCount: gameModel.GetMoveCount())
            }
            else if ( firstTouchedNode.isEqual(to: levelButton )){
                print("Level button")
                gameManager?.onLevelButtonPressed(moveCount: gameModel.GetMoveCount())
            }
            else if ( firstTouchedNode.isEqual(to: resetButton )){
                print("Reset button")
                gameManager?.onResetButtonPressed(moveCount: gameModel.GetMoveCount())
            }
            else if ( firstTouchedNode.isEqual(to: soundButton )){
                print("Sound button")
                if ( gameModel.IsAudioOn() ){
                    gameModel.SetAudioOn(isSet: false )
                    soundButton.texture = SKTexture(imageNamed: "SoundOff")
                }
                else {
                    gameModel.SetAudioOn(isSet: true )
                    soundButton.texture = SKTexture(imageNamed: "SoundOn")
                }
                
            }
            else if ( firstTouchedNode.isEqual(to: musicButton )){
                if ( gameModel.IsMusicOn() ){
                    gameModel.SetMusicOn(isSet: false )
                    musicButton.texture = SKTexture(imageNamed: "MusicOff")
                }
                else {
                    gameModel.SetMusicOn(isSet: true )
                    musicButton.texture = SKTexture(imageNamed: "MusicOn")
                }
                
                print("Music button")
                
            }
            else
            {
                GameEngine.sharedInstance.OnTouch(pos: touch.location(in: self))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        GameEngine.sharedInstance.OnDrag(pos: touch.location(in: self))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if ( GameEngine.sharedInstance.IsSolved() )
        {
            return
        }
        
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        
        if ( GameEngine.sharedInstance.OnRelease(pos: touch.location(in: self)) )
        {
            
            if ( ( gameModel.AreAdsAvailable() ) && ((gameModel.GetMoveCount()%25) == 0 )){
                Chartboost.showInterstitial(CBLocationHomeScreen)
            }
        }
        
        if ( GameEngine.sharedInstance.IsSolved() )
        {
            gameModel.SoundWin()
            gameManager?.onGameWon()
            popups?.OpenPopup()
        }
        
        UpdateLabels()
    }
    
    func UpdateLabels() {
        moveCountLabel.text = "Moves: \(gameModel.GetMoveCount())"
        scoreLabel.text = "Score: \(gameModel.GetScore())"
        levelLabel.text = "Level " + String(gameModel.getCurrentLevel()+1)
    }
    
    override func update(_ currentTime: TimeInterval) {
        GameEngine.sharedInstance.OnUpdate( currentTime: currentTime)
    }
    
    func onNewTile(tile:TileNode){
        tile.sprite!.zPosition = 1
        addChild(tile.sprite!)
    }
    
    func onAddChild(child: SKNode){
        addChild(child)
    }
}
