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
    func OnToast( msg:String )
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
    let handIcon = SKSpriteNode(imageNamed: "hand")
    
    var gameManager:GameManager?
    var gameModel: GameModel = GameModel.sharedInstance
    
    private var popups: Popups?
    
    private var demoState : Popups.PopupType = Popups.PopupType.None
    
    override func didMove(to view: SKView) {
        
        GameEngine.sharedInstance.SetParent(parent: self)

        popups = Popups(bounds: view.bounds, gameSceneProtocol: self )
        
        backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.95, alpha: 1.0)
        
        ///The game board
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        let boardPadding : Int = 5
        let cellSize = gameModel.GetCellSize()
        let shape = SKShapeNode(rect: CGRect(x: -boardPadding, y: -boardPadding, width: boardSize+2*boardPadding, height: boardSize+2*boardPadding), cornerRadius: 10)
        
        shape.position = CGPoint(x: viewOffset.x, y: viewOffset.y)
        shape.fillColor = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
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
        
        helpButton.position = CGPoint(x: viewOffset.x + CGFloat(boardSize) - 0.5*CGFloat(cellSize), y: viewOffset.y + CGFloat(boardSize) + 2.0*CGFloat(cellSize) ) 
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
        
        if !ShowDemo() {
            GameEngine.sharedInstance.LoadGame(level: gameModel.getCurrentLevel() )
        }
    }
    
    func OnToast( msg:String){
      /*  let msgLabel = SKLabelNode(text: msg)
        msgLabel.position = CGPoint(x: size.width/2.0 + CGFloat(arc4random()%100) - 50.0, y: gameModel.GetViewOffset().y + CGFloat(arc4random()%100) )
        msgLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        msgLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        msgLabel.fontSize = 36
        msgLabel.fontColor = Constants.fontColor
        msgLabel.fontName = Constants.fontName
        msgLabel.zPosition = Constants.popupZIndex
        addChild(msgLabel)
        
        let actionMove = SKAction.moveBy(x: 0.0, y: CGFloat(gameModel.boardSize*(gameModel.GetCellSize()-1)), duration: 1.5)
        
        msgLabel.run(SKAction.sequence([actionMove,SKAction.removeFromParent()]))*/
    }
    
    func ShowDemo()->Bool{
        
        if gameModel.getCurrentLevel() == 0 {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .push
            popups?.OpenPopup(type: demoState, isDemo:true)
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelChocolate {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Chocolate
            popups?.OpenPopup(type: demoState, isDemo:true)
            
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelSpecial {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Match4
            popups?.OpenPopup(type: demoState, isDemo:true)
            
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelStar {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Match5
            popups?.OpenPopup(type: demoState, isDemo:true)
            
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelBomb {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Bomb
            popups?.OpenPopup(type: demoState, isDemo:true)
            
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelBasket {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .FruitBasket
            popups?.OpenPopup(type: demoState, isDemo:true)
            
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelSaw {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Saw
            popups?.OpenPopup(type: demoState, isDemo:true)
            
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelBlocked {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Blocked
            popups?.OpenPopup(type: demoState, isDemo:true)
        }
        else if gameModel.getCurrentLevel() == gameModel.firstLevelQuestion {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Question
            popups?.OpenPopup(type: demoState, isDemo:true)
        }
        else if gameModel.getCurrentLevel() == gameModel.firstCovered {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Covered
            popups?.OpenPopup(type: demoState, isDemo:true)
        }
        else if  arc4random()%4 == 0 && !GameModel.blokerUsed {
            GameEngine.sharedInstance.isDemo = true
            gameModel.RemoveTiles()
            demoState = .Blocker
            popups?.OpenPopup(type: demoState, isDemo:true)
            
        }

        
        return (popups?.IsOpen())!
    }
    
    func OnGameLoaded(){
        
        var title1 = ""
        var title2 = ""
        
        //check chocolates
        if gameModel.targetChocolates != 0 {
            title1 = "Remove \(gameModel.targetChocolates) ice creams"
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
        else{
            title1 = "Remove all covers"
        }
        
        
        if gameModel.maxMoves != 0 {
            title2 = "In \(gameModel.maxMoves) moves"
        }
        
        popups?.OpenInfoPopup(title1: title1, title2: title2)
    }
    
    func OnGameWon(){
        gameModel.SoundWin()
        popups?.OpenPopup( type: Popups.PopupType.Win, isDemo: false)
    }
    
    func OnGameLost(){
        gameModel.SoundLose()
        popups?.OpenPopup( type: Popups.PopupType.Lose, isDemo:false, covered: gameModel.GetCoveredTileCount() )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        
        let touchedNodes = nodes(at: touch.location(in: self))
        
        if ( popups?.IsOpen() )!{
            
            if demoState != .None {
                popups?.ClosePopup()
                OnDemoPopupClosed()
            }
            else if popups?.GetPopupType() == Popups.PopupType.Info {
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
                    gameModel.IncreaseCurrentLevel()
                    
                    if !ShowDemo() {
                        GameEngine.sharedInstance.LoadGame(level: gameModel.getCurrentLevel())
                    }
                    break
                    
                case .None:
                    break
                }
            }
        }
        else if ( touchedNodes.count > 0 ) && demoState == .None {
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
                popups?.OpenPopup(type: Popups.PopupType.Match3, isDemo:false)
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
        
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
            return
        }
        
        GameEngine.sharedInstance.OnRelease(pos: touch.location(in: self)) 
        
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
        if gameModel.targetChocolates != 0 {
            goalLabel.text = "Ice Creams: \(gameModel.chRemoved) / \(gameModel.targetChocolates)"
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
        //check target score
        else if gameModel.targetScore != 0 {
            goalLabel.text = "Target Score: \(gameModel.targetScore)"
        }
        else{
            let coverCount = gameModel.GetCoveredTileCount()
            
            if coverCount > 0 {
                goalLabel.text = "Covers Left: \(coverCount)"
            }
            else{
                goalLabel.text = ""
            }
            
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
    
    func OnDemoPopupClosed(){
        switch demoState {
        case .push:
            ShowPushDemo()
            break
        case .Match3:
            ShowMatchDemo()
            break
        case .Blocker:
            ShowBlockerDemo()
            break
        case .Chocolate:
            ShowChocolateDemo()
            break
        case .Match4:
            ShowMatch4Demo()
            break
        case .Match5:
            ShowMatch5Demo()
            break
        case .Question:
            ShowQuestionDemo()
            break
        case .Covered:
            ShowCoverhDemo()
            break
        default:
            demoState = .None
            GameEngine.sharedInstance.isDemo = false
            GameEngine.sharedInstance.LoadGame(level: gameModel.getCurrentLevel() )
            
            break
        }
    }
    
    func ShowPushDemo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + CGFloat( boardSize/2) , y: viewOffset.y + CGFloat(boardSize/2) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        gameEngine.AddTile(id: 1, pos: CGPoint(x: 2, y: 2))
        gameEngine.AddTile(id: 1, pos: CGPoint(x: 2, y: 3))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 2))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 5))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 4, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 4, y: 2))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 5, y: 1))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 3))
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.move(to: pos, duration: 2.0)
        pos.x += 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove2 = SKAction.move(to: pos, duration: 2.0)
        let actionWait = SKAction.wait(forDuration: 1.5)
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        let actionDone = SKAction.run {
            self.demoState = .Match3
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPush1 = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        let actionPush2 = SKAction.run {
            gameEngine.m_direction = .Right
            gameEngine.PushAgainstTheWall()
        }
        
        handIcon.run( SKAction.sequence([actionTick,actionMove1,actionTick,actionPush1,actionWait,actionTick,actionMove2,actionTick,actionPush2,actionWait,actionDone]))
    }
    
    func ShowMatchDemo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + CGFloat( boardSize/2) , y: viewOffset.y + CGFloat(boardSize/2) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        let tile1 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 2))
        let tile2 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 3))
        let tile3 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 1, y: 4))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 4))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 4, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 4, y: 2))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 5, y: 1))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 3))
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.move(to: pos, duration: 2.0)
        pos.x += 2.0*CGFloat(gameModel.GetCellSize())
        let actionWait = SKAction.wait(forDuration: 1.5)
        
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        
        let actionWave = SKAction.run {
            self.gameModel.SoundWave()
        }
        
        let actionDone = SKAction.run {
            self.demoState = .Blocker
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPush1 = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        let scaleUp = SKAction.scale(to: 1.15, duration: GameModel.delay)
        let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay)
        let actionRepeat = SKAction.repeat(SKAction.sequence([scaleUp,scaleDown]), count: 4)
        let actionRepeat2 = SKAction.run {
            tile1?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent(), actionWave]))
            tile2?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile3?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
        }

        handIcon.run( SKAction.sequence([actionTick,actionMove1,actionTick,actionPush1,actionWait,actionRepeat2,actionWait,actionWait,actionDone]))
    }

    func ShowBlockerDemo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + 3.5*CGFloat(gameModel.GetCellSize()) , y: viewOffset.y + 2.0*CGFloat(gameModel.GetCellSize()) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        gameEngine.AddTile(id: 1, pos: CGPoint(x: 2, y: 2))
        gameEngine.AddTile(id: 1, pos: CGPoint(x: 2, y: 3))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 5, y: 2))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 5))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 4, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 4, y: 2))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 5, y: 1))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 3))
        
        let actionAddBlocker = SKAction.run {
            gameEngine.AddTile(id: TileNode.BLOCKER_ID, pos: CGPoint(x: 3, y: 2))
        }
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.moveTo(x: viewOffset.x + CGFloat(gameModel.GetCellSize())/2.0 , duration: 2.0)
        let actionWait = SKAction.wait(forDuration: 1.5)
        
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        
        
        let actionDone = SKAction.run {
            self.demoState = .Enjoy
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPush1 = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        handIcon.run( SKAction.sequence([actionWait,actionTick,actionAddBlocker, actionWait, actionMove1,actionTick,actionPush1,actionWait, actionDone]))
    }

    func ShowChocolateDemo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + 3.5*CGFloat(gameModel.GetCellSize()) , y: viewOffset.y + 2.0*CGFloat(gameModel.GetCellSize()) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        let tile1 = gameEngine.AddTile2(id: TileNode.CHOLOLATE_ID, pos: CGPoint(x: 3, y: 3))
        gameEngine.AddTile(id: 1, pos: CGPoint(x: 1, y: 3))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 2, y: 1))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 2, y: 3))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 3, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 3, y: 1))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 4, y: 4))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 5))
        
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.moveTo(x: viewOffset.x + CGFloat(gameModel.GetCellSize())/2.0 , duration: 2.0)
        let actionMove2 = SKAction.moveTo(y: viewOffset.y - CGFloat(gameModel.GetCellSize())/2.0 , duration: 2.0)
        let actionWait = SKAction.wait(forDuration: 1.5)
        
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        
        
        let actionDone = SKAction.run {
            self.demoState = .Enjoy
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPushLeft = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        let actionPushDown = SKAction.run {
            gameEngine.m_direction = .Down
            gameEngine.PushAgainstTheWall()
        }
        
        let actionWave = SKAction.run {
            self.gameModel.SoundWave()
        }
        
        let scaleUp = SKAction.scale(to: 1.15, duration: GameModel.delay)
        let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay)
        let actionRepeat = SKAction.repeat(SKAction.sequence([scaleUp,scaleDown]), count: 4)
        let actionRepeat2 = SKAction.run {
            tile1?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent(), actionWave]))
        }

        
        handIcon.run( SKAction.sequence([
            actionTick,
            actionMove1,
            actionTick,
            actionPushLeft,
            actionWait,
            actionTick,
            actionMove2,
            actionTick,
            actionPushDown,
            actionWait,
            actionRepeat2,
            actionWait,
            actionWait,
            actionDone]))
    }

    func ShowMatch4Demo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + CGFloat( boardSize/2) , y: viewOffset.y + CGFloat(boardSize/2) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        let tile1 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 2))
        let tile2 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 3))
        let tile3 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 1, y: 4))
        let tile4 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 3, y: 3))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 4))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 4, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 4, y: 2))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 5, y: 1))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 3))
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.move(to: pos, duration: 2.0)
        pos.x += 2.0*CGFloat(gameModel.GetCellSize())
        let actionWait = SKAction.wait(forDuration: 1.5)
        
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        
        let actionChime = SKAction.run {
            self.gameModel.SoundChime()
            tile1?.SetClusterType(type: TileNode.ClusterType.Four)
        }
        
        let actionDone = SKAction.run {
            self.demoState = .Enjoy
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPush1 = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        let scaleUp = SKAction.scale(to: 1.15, duration: GameModel.delay)
        let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay)
        let actionRepeat = SKAction.repeat(SKAction.sequence([scaleUp,scaleDown]), count: 4)
        let actionRepeat2 = SKAction.run {
            tile1?.sprite?.run(SKAction.sequence([actionRepeat,actionChime]))
            tile2?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile3?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile4?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
        }
        
        handIcon.run( SKAction.sequence([actionTick,actionMove1,actionTick,actionPush1,actionWait,actionRepeat2,actionWait,actionWait,actionDone]))
    }

    func ShowMatch5Demo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + CGFloat( boardSize/2) , y: viewOffset.y + CGFloat(boardSize/2) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        let tile1 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 2))
        let tile2 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 3))
        let tile3 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 1, y: 4))
        let tile4 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 3, y: 3))
        let tile5 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 4, y: 3))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 4))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 4, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 4, y: 2))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 5, y: 1))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 3))
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.move(to: pos, duration: 2.0)
        pos.x += 2.0*CGFloat(gameModel.GetCellSize())
        let actionWait = SKAction.wait(forDuration: 1.5)
        
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        
        let actionChime = SKAction.run {
            self.gameModel.SoundChime()
            tile1?.SetClusterType(type: TileNode.ClusterType.Five)
        }
        
        let actionDone = SKAction.run {
            self.demoState = .Yellow
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPush1 = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        let scaleUp = SKAction.scale(to: 1.15, duration: GameModel.delay)
        let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay)
        let actionRepeat = SKAction.repeat(SKAction.sequence([scaleUp,scaleDown]), count: 4)
        let actionRepeat2 = SKAction.run {
            tile1?.sprite?.run(SKAction.sequence([actionRepeat,actionChime]))
            tile2?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile3?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile4?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile5?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
        }
        
        handIcon.run( SKAction.sequence([actionTick,actionMove1,actionTick,actionPush1,actionWait,actionRepeat2,actionWait,actionWait,actionDone]))
    }

    func ShowQuestionDemo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + CGFloat( boardSize/2) , y: viewOffset.y + CGFloat(boardSize/2) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        let tile1 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 2))
        let tile2 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 3))
        let tile3 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 1, y: 4))
        let tileQ = gameEngine.AddTile2(id: TileNode.QUESTION_ID, pos: CGPoint(x: 3, y: 3))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 4))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 4, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 4, y: 2))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 5, y: 1))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 3))
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.move(to: pos, duration: 2.0)
        pos.x += 2.0*CGFloat(gameModel.GetCellSize())
        let actionWait = SKAction.wait(forDuration: 1.5)
        
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        
        let actionChime = SKAction.run {
            self.gameModel.SoundChime()
        }
        
        let actionChime2 = SKAction.run {
            self.gameModel.SoundChime()
            tileQ?.SetID(Id: 3)
        }
        
        let actionDone = SKAction.run {
            self.demoState = .Enjoy
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPush1 = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        let scaleUp = SKAction.scale(to: 1.15, duration: GameModel.delay)
        let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay)
        let actionRepeat = SKAction.repeat(SKAction.sequence([scaleUp,scaleDown]), count: 4)
        let actionRepeat2 = SKAction.run {
            tile1?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent(),actionChime]))
            tile2?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile3?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
        }
        
        let actionRepeat3 = SKAction.run {
            tileQ?.sprite?.run(SKAction.sequence([actionRepeat,actionChime2]))
        }
        
        handIcon.run( SKAction.sequence([actionTick,actionMove1,actionTick,actionPush1,actionWait,actionRepeat2,actionWait,actionWait,actionRepeat3,actionWait,actionWait,actionDone]))
    }
    
    func ShowCoverhDemo(){
        
        let gameEngine = GameEngine.sharedInstance
        
        let boardSize : Int = gameModel.GetCellSize()*gameModel.boardSize
        let viewOffset = gameModel.GetViewOffset()
        var pos = CGPoint(x: viewOffset.x + CGFloat( boardSize/2) , y: viewOffset.y + CGFloat(boardSize/2) )
        handIcon.position = pos
        handIcon.zPosition = 10.0
        addChild(handIcon)
        
        //Adding tiles
        gameModel.RemoveTiles()
        let tile0 = gameEngine.AddTile2(id: 3, pos: CGPoint(x: 0, y: 5))
        
        if tile0 != nil {
            tile0?.SetCoverCount(cover: 1)
        }
        
        let tile1 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 2))
        let tile2 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 2, y: 3))
        let tile3 = gameEngine.AddTile2(id: 1, pos: CGPoint(x: 1, y: 4))
        gameEngine.AddTile(id: 2, pos: CGPoint(x: 3, y: 4))
        gameEngine.AddTile(id: 3, pos: CGPoint(x: 4, y: 0))
        gameEngine.AddTile(id: 4, pos: CGPoint(x: 4, y: 2))
        gameEngine.AddTile(id: 5, pos: CGPoint(x: 5, y: 1))
        gameEngine.AddTile(id: 6, pos: CGPoint(x: 5, y: 3))
        
        pos.x -= 2.0*CGFloat(gameModel.GetCellSize())
        let actionMove1 = SKAction.move(to: pos, duration: 2.0)
        pos.x += 2.0*CGFloat(gameModel.GetCellSize())
        let actionWait = SKAction.wait(forDuration: 1.5)
        
        let actionTick = SKAction.run {
            self.gameModel.Tick()
        }
        
        let actionWave = SKAction.run {
            self.gameModel.SoundWave()
            if (tile0?.RemoveCoverB())! {
                self.gameModel.SoundGlass()
            }
        }
        
        let actionDone = SKAction.run {
            self.demoState = .Enjoy
            self.handIcon.removeFromParent()
            self.popups?.OpenPopup(type: self.demoState, isDemo:true )
        }
        
        let actionPush1 = SKAction.run {
            gameEngine.m_direction = .Left
            gameEngine.PushAgainstTheWall()
        }
        
        let scaleUp = SKAction.scale(to: 1.15, duration: GameModel.delay)
        let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay)
        let actionRepeat = SKAction.repeat(SKAction.sequence([scaleUp,scaleDown]), count: 4)
        let actionRepeat2 = SKAction.run {
            tile1?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent(), actionWave]))
            tile2?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
            tile3?.sprite?.run(SKAction.sequence([actionRepeat,SKAction.removeFromParent()]))
        }
        
        handIcon.run( SKAction.sequence([actionTick,actionMove1,actionTick,actionPush1,actionWait,actionRepeat2,actionWait,actionWait,actionDone]))
    }
}
