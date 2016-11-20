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
}


class GameScene: SKScene,GameSceneProtocol {
    
    let levelLabel = SKLabelNode(text: "Level")
    let titleLabel = SKLabelNode(text: "Sticky Tiles")
    let moveCountLabel = SKLabelNode(text: "Moves: 0")
    let homeButton = SKSpriteNode(imageNamed: "HomeG")
    let levelButton = SKSpriteNode(imageNamed: "GridG")
    let resetButton = SKSpriteNode(imageNamed: "RewindG")
    let musicButton = SKSpriteNode(imageNamed: "MusicOn")
    let soundButton = SKSpriteNode(imageNamed: "SoundOn")
    
    var touchCount:Int = 0
    
    var gameManager:GameManager?
    var gameModel: GameModel = GameModel.sharedInstance
    
    //For Win Dialog
    var winCoverFrame:SKShapeNode!
    var winFrame:SKShapeNode!
    let winHomeButton = SKSpriteNode(imageNamed: "HomeG")
    let winLevelButton = SKSpriteNode(imageNamed: "GridG")
    let winResetButton = SKSpriteNode(imageNamed: "RewindG")
    let winNextButton = SKSpriteNode(imageNamed: "FastForwardG")
    let winTitleLabel = SKLabelNode(text: "You Won!")
    
    override func didMove(to view: SKView) {
        
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
        
        GameEnagin.sharedInstance.LoadGame(level: gameModel.getCurrentLevel(), gameSceneProtocol:self)
        
        for index in 0...gameModel.GetTileCount()-1{
            addChild( gameModel.GetSpriteNode(index: index) )
            
        }

        titleLabel.position = CGPoint(x: size.width * 0.5, y: viewOffset.y + CGFloat(boardSize) + 1.5*CGFloat(cellSize) )
        titleLabel.fontSize = 36
        titleLabel.fontColor = SKColor.blue
        titleLabel.fontName = "Papyrus"
        addChild(titleLabel)
        
        
        var y = viewOffset.y - 1.5*CGFloat(cellSize)
        
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
        
        levelLabel.position = CGPoint(x: viewOffset.x + 2.0*CGFloat(boardPadding), y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(boardPadding) + 0.5*CGFloat(cellSize) )
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
        
        //For Win Dialog
        let winSize = view.bounds.size
        winCoverFrame = SKShapeNode(rect: CGRect(x: Int(-winSize.width*0.5), y: Int(-winSize.height*0.5), width: Int(winSize.width), height: Int(winSize.height)), cornerRadius: 0)
        winCoverFrame.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.0)
        winCoverFrame.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        //winCoverFrame.strokeColor = UIColor.darkGray
        //winCoverFrame.lineWidth = 5
        winCoverFrame.zPosition = 1
        
        
        winFrame = SKShapeNode(rect: CGRect(x: Int(-winSize.width*0.4), y: Int(-winSize.height*0.2), width: Int(winSize.width*0.8), height: Int(winSize.height*0.4)), cornerRadius: 10)
        winFrame.position = CGPoint(x: winSize.width/2.0, y: winSize.height/2.0)
        winFrame.fillColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.75)
        winFrame.strokeColor = UIColor.darkGray
        winFrame.lineWidth = 5
        winFrame.zPosition = 1
        
        
        y = winSize.height/2.0 - 1.0*CGFloat(cellSize)
        
        winHomeButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*2.0/10.0 , y: y)
        winHomeButton.zPosition = 1
        
        
        winLevelButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*4.0/10.0, y: y)
        winLevelButton.zPosition = 1
        
        
        winResetButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*6.0/10.0, y: y)
        winResetButton.zPosition = 1
        
        
        winNextButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize)*8.0/10.0, y: y)
        winNextButton.zPosition = 1
        
        
        winTitleLabel.position = CGPoint(x: size.width * 0.5, y: winSize.height/2.0 + 1.0*CGFloat(cellSize) )
        winTitleLabel.fontSize = 36
        winTitleLabel.fontColor = SKColor.blue
        winTitleLabel.fontName = "Papyrus"
        winTitleLabel.zPosition = 1
        

        
    }
    
    func showWinFrame(){
        addChild(winCoverFrame)
        addChild(winFrame)
        addChild(winHomeButton)
        addChild(winLevelButton)
        addChild(winResetButton)
        addChild(winNextButton)
        addChild(winTitleLabel)
    }
    
    func hideWinFrame(){
        winCoverFrame.removeFromParent()
        winFrame.removeFromParent()
        winHomeButton.removeFromParent()
        winLevelButton.removeFromParent()
        winResetButton.removeFromParent()
        winNextButton.removeFromParent()
        winTitleLabel.removeFromParent()
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
        
        if ( GameEnagin.sharedInstance.IsSolved() ){
            for i in 0 ... touchedNodes.count-1 {
                let touchedNode = touchedNodes[i]
                
                if ( touchedNode.isEqual(to: winHomeButton )){
                    print("Home button")
                    gameManager?.onHomeButtonPressed(moveCount: 0)
                    break
                }
                else if ( touchedNode.isEqual(to: winLevelButton )){
                    print("Level button")
                    gameManager?.onLevelButtonPressed(moveCount: 0)
                    break
                }
                else if ( touchedNode.isEqual(to: winResetButton )){
                    print("Reset button")
                    hideWinFrame()
                    gameModel.reloadGame()
                    levelLabel.text = "Level " + String(gameModel.getCurrentLevel()+1)
                    touchCount = 0
                    moveCountLabel.text = "Moves: \(touchCount)"
                    break
                }
                else if ( touchedNode.isEqual(to: winNextButton )){
                    hideWinFrame()
                    removeTiles()
                    gameModel.IncreaseCurrentLevel()
                    gameModel.loadGame(level: gameModel.getCurrentLevel())
                    addTiles()
                    levelLabel.text = "Level " + String(gameModel.getCurrentLevel()+1)
                    touchCount = 0
                    moveCountLabel.text = "Moves: \(touchCount)"
                    
                    break
                }
            }
        }
        else if ( touchedNodes.count > 0 ){
            let firstTouchedNode = touchedNodes[0]
            
            if ( firstTouchedNode.isEqual(to: homeButton )){
                print("Home button")
                gameManager?.onHomeButtonPressed(moveCount: touchCount)
            }
            else if ( firstTouchedNode.isEqual(to: levelButton )){
                print("Level button")
                gameManager?.onLevelButtonPressed(moveCount: touchCount)
            }
            else if ( firstTouchedNode.isEqual(to: resetButton )){
                print("Reset button")
                gameManager?.onResetButtonPressed(moveCount: touchCount)
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
                GameEnagin.sharedInstance.OnTouch(pos: touch.location(in: self))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        GameEnagin.sharedInstance.OnDrag(pos: touch.location(in: self))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if ( GameEnagin.sharedInstance.IsSolved() )
        {
            return
        }
        
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        
        if ( GameEnagin.sharedInstance.OnRelease(pos: touch.location(in: self)) )
        {
                touchCount += 1
                moveCountLabel.text = "Moves: \(touchCount)"
                gameModel.Tick()
            
            if ( ( gameModel.AreAdsAvailable() ) && ((touchCount%25) == 0 )){
                Chartboost.showInterstitial(CBLocationHomeScreen)
            }
        }
        
        if ( GameEnagin.sharedInstance.IsSolved() )
        {
            gameModel.SoundWin()
            gameManager?.onGameWon()
            showWinFrame()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        GameEnagin.sharedInstance.OnUpdate( currentTime: currentTime)
    }
    
    func onNewTile(tile:TileNode){
        tile.sprite!.zPosition = 1
        addChild(tile.sprite!)
    }
    
    func onAddChild(child: SKNode){
        addChild(child)
    }
}
