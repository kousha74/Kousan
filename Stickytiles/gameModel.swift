//
//  GameModel.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/22/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import StoreKit

class GameSample{
    
    enum Goals:Int {
        case  chocolates, targetScore, maxMoves, targetApples, targetSpecials, targetStars, colorCount, baloonFrequency
    }

    var fruits = [[Int]]()
    var goals = [Int]()
    
    init( fruits: [[Int]], goals: [Int]) {
        self.fruits = fruits
        self.goals = goals
    }
}

class GameModel {
    
    private var currentLevel:Int = 0
    
    private var maxLevelCompleted:Int = -1
    
    static let maxLevel:Int = 7 //tbd
    
    static let delay = 0.25
    
    private var label : SKLabelNode?
    
    private var gameSamples : [GameSample]
    
    private var cellSize : Int = 50 // move to constants
    
    private var viewOffset = CGPoint(x:0, y:0)
    
    private var allTiles : [TileNode]
    
    private var gameTiles : [TileNode]
    
    private var userDefaults = UserDefaults()
    
    private var audioPlayer : AVAudioPlayer?
    private var audioPlayer2 : AVAudioPlayer?
    private var audioPlayer3 : AVAudioPlayer?
    private var audioPlayerWave : AVAudioPlayer?
    private var audioPlayerLaser : AVAudioPlayer?
    private var audioPlayerChime : AVAudioPlayer?
    
    // the minimum number of tiles on the board
    private let MIN_TILES = 12
    
    let boardSize : Int = 6
    
    var moveCount:Int = 0
    var score:Int = 0
    
    //To support goals
    var targetChocolates = 0
    var chAdded = 0
    var chRemoved = 0
    
    var targetScore = 0
    
    var maxMoves = 0
    
    var targetApples = 0
    var applesRemoved = 0
    
    var targetSpecials = 0
    var specialsRemoved = 0
    
    var targetStars = 0
    var starsRemoved = 0
    
    var colorCount = 0
    
    var baloonFrequency = 0
    
    
    //First levels with special target
    var firstLevelChocolate = -1
    var firstLevelBaloon = -1
    var firstLevelBlocked = -1
    var firstLevelSpecial = -1
    var firstLevelStar = -1
    
    func GetMoveCount()->Int{
        return moveCount
    }
    
    func ChangeMoveCount(delta:Int){
        moveCount += delta
    }
    
    func SetMoveCount( count: Int ){
        moveCount = count
    }
    
    func GetScore()->Int{
        return score
    }
    
    func ChangeScore( delta: Int ){
        score += delta
    }
    
    func SetScore( newScore: Int ){
        score = newScore
    }
    
    func OnProductPurchased( productID: String ) {
        if ( productID == GameProducts.removeAds ){
            userDefaults.set( 1, forKey: "removeAds")
        }
    }
    
    func IsProductPurchased( productID: String )->Bool{
        
        if ( productID == GameProducts.removeAds ){
            return ( userDefaults.integer(forKey: "removeAds") != 0 )
        }

        return false
    }
    
    func AreAdsAvailable()->Bool{
        return ( userDefaults.integer(forKey: "removeAds") == 0 ) && ( currentLevel > 20 ) //tbd change
    }
    
    class var sharedInstance: GameModel {
        struct Static {
            static let instance: GameModel = GameModel()
        }
        return Static.instance
    }
    
    func IsMusicOn()->Bool {
        return ( userDefaults.integer(forKey: "musicOn") == 0 )
    }
    
    func SetMusicOn( isSet:Bool ){
        if ( isSet ){
            userDefaults.set( 0, forKey: "musicOn")
            audioPlayer?.play()
        }
        else {
            userDefaults.set( 1, forKey: "musicOn")
            audioPlayer?.stop()
        }
    }
    
    func IsAudioOn()->Bool {
        return ( userDefaults.integer(forKey: "audioOn") == 0 )
    }
    
    func SetAudioOn( isSet:Bool ){
        if ( isSet ){
            userDefaults.set( 0, forKey: "audioOn")
        }
        else {
            userDefaults.set( 1, forKey: "audioOn")
        }
    }
    
    func SoundWin(){
        if ( IsAudioOn() ){
            audioPlayer3?.play()
        }
    }

    
    func Tick(){
        if ( IsAudioOn() ){
            audioPlayer2?.play()
        }
    }
    
    func SoundWave(){
        if ( IsAudioOn() ){
            audioPlayerWave?.play()
        }
    }
    
    func SoundLaser(){
        if ( IsAudioOn() ){
            audioPlayerLaser?.stop()
            audioPlayerLaser?.currentTime = 0.0
            audioPlayerLaser?.play()
        }
    }
    
    func SoundChime(){
        if ( IsAudioOn() ){
            audioPlayerChime?.play()
        }
    }
    
    func getCurrentLevel()->Int{
        return currentLevel
    }
    
    func setCurrentLevel( _currentLevel:Int ){
        currentLevel = _currentLevel
    }
    
    func getMaxLevelCompleted()->Int{
        return maxLevelCompleted
    }
    
    func OnGameWon()
    {
        if ( currentLevel > maxLevelCompleted ) {
            maxLevelCompleted = currentLevel
            userDefaults.set( (maxLevelCompleted + 1), forKey: "maxLevelCompleted")
        }
    }
    
    func IncreaseCurrentLevel()
    {
        if ( currentLevel < GameModel.maxLevel ) {
            currentLevel += 1
        }
    }

    func SetCellSize( deviceSize : CGSize )
    {
        let boardWidth : Int = cellSize*boardSize
        
        viewOffset.x = (deviceSize.width -  CGFloat(boardWidth))/2
        viewOffset.y = (deviceSize.height -  CGFloat(boardWidth))/2
    }

    func GetCellCenter(row:Int,col:Int)->CGPoint{
        return CGPoint(
            x:viewOffset.x + (CGFloat(col)+CGFloat(0.5))*CGFloat(cellSize),
            y:viewOffset.y + (CGFloat(row)+CGFloat(0.5))*CGFloat(cellSize)
            )
    }
    
    func RemoveTiles(){
        for tile in gameTiles{
            tile.sprite?.removeFromParent()
            allTiles.append(tile)
        }
        
        gameTiles.removeAll()        
    }
    
    func loadGame( level:Int)
    {
        RemoveTiles()
        moveCount = 0
        score = 0
        
        //Resetting goals
        targetChocolates = 0
        chAdded = 0
        chRemoved = 0
        targetScore = 0
        maxMoves = 0
        targetApples = 0
        applesRemoved = 0
        targetSpecials = 0
        specialsRemoved = 0
        targetStars = 0
        starsRemoved = 0
        
        colorCount = 0

        let gameSample = gameSamples[min(level, GameModel.maxLevel - 1)]
        
        for index in 0...(gameSample.fruits.count-1){
            
            if let tile = GetEmptyTile() {
            
                let gameItem = gameSample.fruits[ index ]
                
                tile.SetID(Id:gameItem[0])
                
                if gameItem[0] == TileNode.CHOLOLATE_ID {
                    chAdded += 1
                }
                
                tile.SetRowAndCol(row: gameItem[2], col: gameItem[1], cellSize: cellSize, viewOffset: viewOffset)
                
                gameTiles.append(tile)
                
                tile.sprite?.alpha = 1.0
            }
        }
        
        targetChocolates = gameSample.goals[ GameSample.Goals.chocolates.rawValue ]
        targetScore = gameSample.goals[ GameSample.Goals.targetScore.rawValue ]
        maxMoves = gameSample.goals[ GameSample.Goals.maxMoves.rawValue ]
        targetApples = gameSample.goals[ GameSample.Goals.targetApples.rawValue ]
        targetSpecials = gameSample.goals[ GameSample.Goals.targetSpecials.rawValue ]
        targetStars = gameSample.goals[ GameSample.Goals.targetStars.rawValue ]
        colorCount = gameSample.goals[ GameSample.Goals.colorCount.rawValue ]
        baloonFrequency = gameSample.goals[ GameSample.Goals.baloonFrequency.rawValue ]
    }
    
    //find the first tile with the given ID
    func GetID( id: Int )->TileNode?{
        for tile in gameTiles{
            if tile.GetID() == id{
                return tile
            }
        }
        
        return nil
    }
    
    func AddChocolate()->TileNode?{
        
        if chAdded < targetChocolates {
            if GetID(id: TileNode.CHOLOLATE_ID) == nil {
                
                //First find an empty tile
                if let tile = GetEmptyTile() {
                
                    if let emptyCell = FindEmptyCellForChocolate(){
                        
                        tile.SetID(Id: TileNode.CHOLOLATE_ID)
                        tile.SetRowAndCol(row: Int(emptyCell.y), col: Int(emptyCell.x), cellSize: cellSize, viewOffset: viewOffset)
                        gameTiles.append(tile)
                        chAdded += 1
                        return tile
                    }
                }
            }
        }
        
        return nil
    }
    
    func AddTiles()->[TileNode]{
        
        var newTiles = [TileNode]()
        
        var tilesToBeAdded = max( 1, MIN_TILES - gameTiles.count )
            
        //Check if chocolate should be added
        if let chTile = AddChocolate() {
            newTiles.append(chTile)
            tilesToBeAdded -= 1
        }
        
        
        if tilesToBeAdded > 0 {
            for _ in 1...tilesToBeAdded{
                //First find an empty tile
                if let tile = GetEmptyTile() {
                    if let emptyCell = FindEmptyCell(){
                        
                        tile.SetID(Id: GetRandomTileID() )
                        
                        tile.SetRowAndCol(row: Int(emptyCell.y), col: Int(emptyCell.x), cellSize: cellSize, viewOffset: viewOffset)
                        gameTiles.append(tile)
                        newTiles.append(tile)
                    }
                }
            }
        }
        
        return newTiles
    }
    
 /*   func AddTile( Id:Int, row:Int, col:Int)->TileNode?{
        
        if let tile = GetEmptyTile() {
            tile.SetID(Id: Id )
            tile.SetRowAndCol(row: row, col: col, cellSize: cellSize, viewOffset: viewOffset)
            gameTiles.append(tile)
            return tile
        }
        
        return nil
    }*/
    
    func GetRandomTileID()->Int{
        
        if baloonFrequency != 0 && arc4random_uniform(UInt32(baloonFrequency)) == 0 {
            return TileNode.BUBBLE_ID
        }
        else{
            return Int(arc4random_uniform(UInt32(colorCount))) + 1
        }
    }
    
    func AddTile(id: Int, pos:CGPoint)->TileNode?{
        //First find an empty tile
        if let tile = GetEmptyTile() {
            tile.SetID(Id: id)
            tile.SetRowAndCol(row: Int(pos.y), col: Int(pos.x), cellSize: cellSize, viewOffset: viewOffset)
            gameTiles.append(tile)
            return tile
        }
        
        return nil
    }

    
    func FindEmptyCell()->CGPoint?{
        var selectedEmptyCell = CGPoint(x: -1, y: -1)
        var emptyCell = CGPoint(x: -1, y: -1)
        var candidates : UInt32 = 0
        
        for row in 0...boardSize-1{
            for col in 0...boardSize-1{
                emptyCell.x = CGFloat(col)
                emptyCell.y = CGFloat(row)
                if GetTile(pos: emptyCell) == nil {
                    candidates += 1
                    if ( arc4random_uniform(candidates) == 0 ){
                        selectedEmptyCell = emptyCell
                    }
                    
                }
            }
        }
        
        return ( candidates>0 ) ? selectedEmptyCell :  nil
    }
    
    func FindEmptyCellForChocolate()->CGPoint?{
        var selectedEmptyCell = CGPoint(x: -1, y: -1)
        var emptyCell = CGPoint(x: -1, y: -1)
        var candidates : UInt32 = 0
        var tileFound = false
        
        for col in 0...boardSize-1{
            tileFound = false
            for row in 0...boardSize-1{
                emptyCell.x = CGFloat(col)
                emptyCell.y = CGFloat(row)
                
                if GetTile(pos: emptyCell) == nil {
                    if tileFound {
                        candidates += 1
                        if ( arc4random_uniform(candidates) == 0 ){
                            selectedEmptyCell = emptyCell
                        }
                    }
                    
                }
                else{
                    tileFound = true
                }
            }
        }
        
        return ( candidates>0 ) ? selectedEmptyCell :  nil
    }
    
    func GetEmptyTile()->TileNode?{
        if allTiles.count > 0 {
            
            let tile = allTiles[0]
            
            allTiles.remove(at: 0)
            
            tile.Reset()
            
            return tile
            
        }
        
        return nil
    }
        
    //tbd remove
    func GetTileCount()->Int{
        return gameTiles.count
    }
    
    func GetGameTiles()->[TileNode]{
        return gameTiles
    }
    
    func GetTileNode( index: Int )->TileNode{
        return gameTiles[index]
    }
    
    func GetSpriteNode( index: Int )->SKSpriteNode{
        return gameTiles[index].sprite!
    }
    
    func GetCellSize()->Int{
        return cellSize;
    }
    
    func GetViewOffset()->CGPoint{
        return viewOffset;
    }
    
    //given the logical position
    func IsValidPosition(pos:CGPoint)->Bool{
        return ( ( pos.x >= 0 ) && ( Int(pos.x) < boardSize ) && ( pos.y >= 0 ) && ( Int(pos.y) < boardSize ) )
    }
    
    func GetTiles()->[TileNode]{
        return gameTiles
    }
    
    //TBD: get row and col
    func GetTile( pos:CGPoint)->TileNode?{
        for tile in gameTiles {
            if ( tile.Occupies(pos: pos) )
            {
                return tile
            }
        }
        return nil
    }
    
    func GetTile( row:Int, col:Int)->TileNode?{
        return GetTile(pos: CGPoint(x:col, y:row))
    }
    
    func SetFlag( flag: Int, isSet:Bool){
        for tile in gameTiles {
            tile.SetFlag(flag: flag, isSet: isSet)
        }
    }
    
    //finds a tile with given flag set or reset
    func FindFlag( flag:Int, isSet:Bool)->TileNode?{
        for tile in gameTiles {
            if ( tile.GetFlag(flag: flag) == isSet ){
                return tile
            }
        }
        
        return nil
    }
    
    func FindFlags( flag:Int, isSet:Bool)->[TileNode]{
        
        var arr = [TileNode]()
        
        for tile in gameTiles {
            if ( tile.GetFlag(flag: flag) == isSet ){
                arr.append(tile)
            }
        }
        
        return arr
    }
    
    func FindSpecialTile()->TileNode?{
        for tile in gameTiles {
            if ( tile.GetClusterType() != TileNode.ClusterType.None ){
                return tile
            }
        }
        
        return nil
    }

    
    // mark every visited tile as moving
    func MarkVistedAsMoving()
    {
        for tile in gameTiles {
            if ( tile.GetFlag(flag: TileNode.IS_VISITED) )
            {
                tile.SetFlag(flag: TileNode.IS_MOVING, isSet: true)
            }
        }
    }
    
    func RemoveTile(tile:TileNode){
        
        //tbd bad loop
        for i in 0...gameTiles.count-1{
            if ( gameTiles[i] === tile ){
                
                if gameTiles[i].GetID() != TileNode.BLOCKER_ID && gameTiles[i].GetID() != TileNode.BUBBLE_ID{
                    ChangeScore(delta: 1)
                }
                
                switch gameTiles[i].GetID() {
                case TileNode.CHOLOLATE_ID:
                    chRemoved += 1
                    break
                    
                case TileNode.APPLE_ID:
                    applesRemoved += 1
                    break
                    
                case TileNode.STAR5_ID, TileNode.STAR7_ID:
                    starsRemoved += 1
                    break
                    
                default:
                    break;
                }
                
                switch gameTiles[i].GetClusterType(){
                case .Four, .Row, .Col:
                    specialsRemoved += 1
                    break
                    
                default:
                    break
                }
                
                gameTiles.remove(at: i)
                allTiles.append(tile)
                break
            }
        }
    }
    
    func IsFull()->Bool{
        return gameTiles.count == boardSize*boardSize
    }
    
    func IsLost()->Bool{
        
        if maxMoves <= moveCount && maxMoves != 0 {
            return true
        }
        
        if IsFull() {
            for tile in gameTiles{
                switch tile.GetID() {
                case TileNode.BUBBLE_ID, TileNode.STAR5_ID, TileNode.STAR7_ID:
                    return false
                    
                default:
                    break
                }
            }
            
            return true
        }
        
        return false
    }
    
    private func FindFirstLevels(){
        //To find first level of each scenario
        for i in 0...gameSamples.count - 1 {
            let gameSample = gameSamples[i]
            
            if ( firstLevelChocolate < 0 ){
                if gameSample.goals[ GameSample.Goals.chocolates.rawValue ] > 0 {
                    firstLevelChocolate = i
                }
            }
            
            if firstLevelSpecial < 0 {
                if gameSample.goals[ GameSample.Goals.targetSpecials.rawValue ] > 0 {
                    firstLevelSpecial = i
                }
            }
            
            if firstLevelStar < 0 {
                if gameSample.goals[ GameSample.Goals.targetStars.rawValue ] > 0 {
                    firstLevelStar = i
                }
                
            }
            
            if firstLevelBaloon < 0 {
                if gameSample.goals[ GameSample.Goals.baloonFrequency.rawValue ] > 0 {
                    firstLevelBaloon = i
                }
            }
            
            if firstLevelBlocked < 0 {
                for fruit in gameSample.fruits {
                    if fruit[0] == TileNode.BLOCKED_ID {
                        firstLevelBlocked = i
                        break
                    }
                }
            }
        }
    }

        
    private init() {
        
        maxLevelCompleted = userDefaults.integer(forKey: "maxLevelCompleted") - 1
        
        // For debugging only
        //maxLevelCompleted = 49

        
        let soundURL = Bundle.main.url(forResource: "bgMusic", withExtension: "wav")
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayer?.numberOfLoops = -1

            if ( userDefaults.integer(forKey: "musicOn") == 0 ) {
                audioPlayer?.play()
            }

        } catch {
            print("NO AUDIO PLAYER")
        }
        
        let soundURL2 = Bundle.main.url(forResource: "tick", withExtension: "wav")
        do {
            try audioPlayer2 = AVAudioPlayer(contentsOf: soundURL2!)
            audioPlayer2?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        let soundURL3 = Bundle.main.url(forResource: "win", withExtension: "wav")
        do {
            try audioPlayer3 = AVAudioPlayer(contentsOf: soundURL3!)
            audioPlayer3?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        let soundURL4 = Bundle.main.url(forResource: "spinsinewave", withExtension: "wav")
        do {
            try audioPlayerWave = AVAudioPlayer(contentsOf: soundURL4!)
            audioPlayerWave?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        let soundURL5 = Bundle.main.url(forResource: "laser", withExtension: "wav")
        do {
            try audioPlayerLaser = AVAudioPlayer(contentsOf: soundURL5!)
            audioPlayerLaser?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        let soundURL6 = Bundle.main.url(forResource: "chime", withExtension: "mp3")
        do {
            try audioPlayerChime = AVAudioPlayer(contentsOf: soundURL6!)
            audioPlayerChime?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        allTiles = [TileNode]()
        
        for _ in 1...boardSize*boardSize{

            let Tile = TileNode(x: 0, y: 0, id: 0, locked: false, cellSize: cellSize, viewOffset: viewOffset)
            
            allTiles.append( Tile )
        }
        
        gameTiles = [TileNode]()
        
        gameSamples = [GameSample]()
        
            //fruits [id,x,y]
            //goals [Chcolate, targetScore, maxMoves, targetApples, targetSpecial, targetStars, colorCount, baloon frequency]

            gameSamples.append( GameSample( fruits:[
                [1,0,0],
                [1,1,1],
                [2,2,0]
                ],
                goals: [0,40,0,0,0,0,6,0]
                ) )
        
        gameSamples.append( GameSample( fruits:[
            [TileNode.CHOLOLATE_ID,0,5]
            ],
                                        goals: [3,0,50,0,0,0,4,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [1,0,5]
            ],
                                        goals: [0,0,50,10,0,0,4,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [1,0,5]
            ],
                                        goals: [0,0,50,0,3,0,4,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [3,0,0],
            [3,1,1],
            [1,2,0],
            [1,3,2],
            [1,4,0],
            [1,5,2],
            [4,0,1],
            [4,1,0],
            [2,2,1],
            [2,3,0],
            [2,4,1],
            [2,5,0]
            ],
                                        goals: [0,0,40,0,0,1,4,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [TileNode.CHOLOLATE_ID,0,5]
            ,[TileNode.BLOCKED_ID,3,3]
            ],
                                        goals: [3,0,50,0,0,0,4,10]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [1,0,5]
            ,[TileNode.BLOCKED_ID,3,3]
            ],
                                        goals: [0,0,50,10,0,0,4,10]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [1,0,5]
            ,[TileNode.BLOCKED_ID,3,3]
            ],
                                        goals: [0,0,50,0,3,0,4,10]
        ) )
        
        FindFirstLevels()
        
            print ("There are \(gameSamples.count) samples")
        
    }
}
