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
    func OnGameWon()
    func OnGameLost()
    func OnGameLoaded()
}


class GameScene: SKScene,GameSceneProtocol {
    
    let goalLabel = SKLabelNode(text: "Level: 0")
    let levelLabel = SKLabelNode(text: "Level: 0")
    let scoreLabel = SKLabelNode(text: "Score")
    let titleLabel = SKLabelNode(text: "Sticky Tiles")
    let moveCountLabel = SKLabelNode(text: "Moves: 0")
    let homeButton = SKSpriteNode(imageNamed: "HomeG")
    let levelButton = SKSpriteNode(imageNamed: "GridG")
    let resetButton = SKSpriteNode(imageNamed: "RewindG")
    let musicButton = SKSpriteNode(imageNamed: "MusicOn")
    let soundButton = SKSpriteNode(imageNamed: "SoundOn")
    let helpButton = SKSpriteNode(imageNamed: "HelpIcon")
    
    var gameManager:GameManager?
    var gameModel: GameModel = GameModel.sharedInstance
    
    private var popups: Popups?
        
    override func didMove(to view: SKView) {
        
        GameEngine.sharedInstance.SetParent(parent: self)

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
        
        titleLabel.position = CGPoint(x: size.width * 0.5, y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(cellSize) )
        titleLabel.fontSize = 36
        titleLabel.fontColor = Constants.fontColor
        titleLabel.fontName = Constants.fontName
        //addChild(titleLabel)
        
        
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
        
        
        moveCountLabel.position = CGPoint(x: viewOffset.x + CGFloat(boardSize), y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(boardPadding) + 0.5*CGFloat(cellSize) )
        moveCountLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        moveCountLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        moveCountLabel.fontSize = Constants.fontSize
        moveCountLabel.fontColor = Constants.fontColor
        moveCountLabel.fontName = Constants.fontName
        addChild(moveCountLabel)
        
        let boardMaxY = viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(boardPadding)
        let labelHeight = 0.75*CGFloat(cellSize)
        
        scoreLabel.position = CGPoint(x: viewOffset.x, y:  boardMaxY + 0.5*labelHeight )
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.fontSize = Constants.fontSize
        scoreLabel.fontColor = Constants.fontColor
        scoreLabel.fontName = Constants.fontName
        addChild(scoreLabel)
        
        
        goalLabel.position = CGPoint(x: viewOffset.x, y: boardMaxY + 1.5*labelHeight )
        goalLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        goalLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        goalLabel.fontSize = Constants.fontSize
        goalLabel.fontColor = Constants.fontColor
        goalLabel.fontName = Constants.fontName
        goalLabel.text = ""
        addChild(goalLabel)
        
        levelLabel.position = CGPoint(x: viewOffset.x, y: boardMaxY + 2.5*labelHeight )
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        levelLabel.fontSize = Constants.fontSize
        levelLabel.fontColor = Constants.fontColor
        levelLabel.fontName = Constants.fontName
        levelLabel.text = "Level " + String(gameModel.getCurrentLevel()+1)
        addChild(levelLabel)
        
        if ( !gameModel.IsMusicOn() ){
            musicButton.texture = SKTexture(imageNamed: "MusicOff")
        }
        
        if ( !gameModel.IsAudioOn() ){
            soundButton.texture = SKTexture(imageNamed: "SoundOff")
        }
        
        GameEngine.sharedInstance.LoadGame(level: gameModel.getCurrentLevel() )
    }
    
    func OnGameLoaded(){
        
        var title1 = ""
        var title2 = ""
        
        //check chocolates
        if gameModel.chGoal != 0 {
            title1 = "Remove \(gameModel.chGoal) chocolates"
        }
        else if gameModel.targetScore != 0 {
            title1 = "Remove \(gameModel.targetScore) fruits"
        }
        else if gameModel.targetApples != 0 {
            title1 = "Remove \(gameModel.targetApples) apples"
        }
        else if gameModel.targetSpecials != 0 {
            title1 = "Remove \(gameModel.targetSpecials) special fruits"
        }
        else if gameModel.targetStars != 0 {
            title1 = "Remove \(gameModel.targetStars) stars"
        }
        
        if gameModel.maxMoves != 0 {
            title2 = "In \(gameModel.maxMoves) moves"
        }
        
        popups?.OpenInfoPopup(title1: title1, title2: title2)
    }
    
    func OnGameWon(){
        gameModel.SoundWin()
        popups?.OpenPopup( type: Popups.PopupType.Win)
    }
    
    func OnGameLost(){
        gameModel.SoundWin() //TBD
        popups?.OpenPopup( type: Popups.PopupType.Lose)
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
            
            if popups?.GetPopupType() == Popups.PopupType.Info {
                popups?.ClosePopup()
            }
            else if let touchedButton = popups?.GetTouchedButton(nodes: touchedNodes) {
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
            else if ( firstTouchedNode.isEqual(to: helpButton )){
                popups?.OpenPopup(type: Popups.PopupType.Match3)
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
        
        //TBD
        //if ( GameEngine.sharedInstance.IsSolved() )
        //{
        //   return
        //}
        
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
        
        UpdateLabels()
    }
    
    func UpdateLabels() {
        if gameModel.maxMoves != 0{
            moveCountLabel.text = "Moves Left: \(gameModel.maxMoves - gameModel.GetMoveCount())"
        }
        else{
            moveCountLabel.text = "Moves: \(gameModel.GetMoveCount())"
        }
        
        scoreLabel.text = "Score: \(gameModel.GetScore())"
        levelLabel.text = "Level " + String(gameModel.getCurrentLevel()+1)
        
        //goal label
        //check chocolates
        if gameModel.chGoal != 0 {
            goalLabel.text = "Chololates: \(gameModel.chRemoved) / \(gameModel.chGoal)"
        }
        //check target apples
        else if gameModel.targetApples != 0 {
            goalLabel.text = "Apples: \(gameModel.applesRemoved) / \(gameModel.targetApples)"
        }
        //check target Special
        else if gameModel.targetSpecials != 0 {
            goalLabel.text = "Special Fruits: \(gameModel.specialsRemoved) / \(gameModel.targetSpecials)"
        }
        //check target stars
        else if gameModel.targetStars != 0 {
            goalLabel.text = "Stars: \(gameModel.starsRemoved) / \(gameModel.targetStars)"
        }
        else{
            goalLabel.text = ""
        }
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
