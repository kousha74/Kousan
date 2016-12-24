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
        case  chocolates, targetScore, maxMoves, targetApples, targetSpecials, targetStars, colorCount, BasketFrequency
    }

    var fruits = [[Int]]()
    var goals = [Int]()
    
    init( fruits: [[Int]], goals: [Int]) {
        self.fruits = fruits
        self.goals = goals
    }
}

class GameModel {
    
    // TBD duplicate
    static let APPLE_ID = 1
    static let BUBBLE_ID = 10
    static let STAR5_ID = 11
    static let STAR7_ID = 12
    static let CHOLOLATE_ID = 13
    static let BLOCKER_ID = 14
    static let BLOCKED_ID = 15
    static let QUESTION_ID = 16
    static let FRUIT_BASKET_ID = 17
    static let HAND_SAW_ID = 18
    static let BOMB_ID = 19
    static let EDGE_ID = 100

    private var currentLevel:Int = 0
    
    private var maxLevelCompleted:Int = -1
    
    static let maxLevel:Int = 149 //tbd
    
    static let delay = 0.25
    
    private var label : SKLabelNode?
    
    private var gameSamples : [GameSample]
    
    private var cellSize : Int = 50 // move to constants
    
    private var viewOffset = CGPoint(x:0, y:0)
    
    private var allTiles : [TileNode]
    
    private var gameTiles : [TileNode]
    
    private var allEdges : [EdgeNode]
    private var gameEdges : [EdgeNode]
    
    private var userDefaults = UserDefaults()
    
    private var musicPlayer : AVAudioPlayer?
    private var audioPlayer2 : AVAudioPlayer?
    private var audioPlayerWin : AVAudioPlayer?
    private var audioPlayerWave : AVAudioPlayer?
    private var audioPlayerLaser : AVAudioPlayer?
    private var audioPlayerChime : AVAudioPlayer?
    private var audioPlayerLose : AVAudioPlayer?
    private var audioPlayerGlass : AVAudioPlayer?
    private var audioPlayerWoodCut : AVAudioPlayer?
    private var audioPlayerExplosion : AVAudioPlayer?
    
    static var blokerUsed = false
    
    // the minimum number of tiles on the board
    let MIN_TILES = 12
    
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
    var fruitBasketFrequency = 0
    
    
    //First levels with special target
    var firstLevelChocolate = -1
    var firstLevelBomb = maxLevel + 1
    var firstLevelBlocked = maxLevel + 1
    var firstLevelSpecial = -1
    var firstLevelStar = -1
    var firstLevelQuestion = -1
    var firstCovered = -1
    var firstLevelBasket = maxLevel + 1
    var firstLevelSaw = maxLevel + 1
    
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
        return ( userDefaults.integer(forKey: "removeAds") == 0 ) && ( currentLevel > 3 )
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
            musicPlayer?.play()
        }
        else {
            userDefaults.set( 1, forKey: "musicOn")
            musicPlayer?.stop()
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
            audioPlayerWin?.play()
        }
    }
    
    func SoundWoodCut( play: Bool){
        if play {
            if ( IsAudioOn() ){
                audioPlayerWoodCut?.play()
            }
        }
        else{
            audioPlayerWoodCut?.stop()
        }
    }
    
    func SoundExplosion(){
        if ( IsAudioOn() ){
            audioPlayerExplosion?.stop()
            audioPlayerExplosion?.currentTime = 0.0
            audioPlayerExplosion?.play()
        }
    }
    
    func SoundLose(){
        if ( IsAudioOn() ){
            audioPlayerLose?.play()
        }
    }
    
    
    func Tick(){
        if ( IsAudioOn() ){
            audioPlayer2?.play()
        }
    }
    
    func SoundGlass(){
        if ( IsAudioOn() ){
            audioPlayerGlass?.play()
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
        
        for edge in gameEdges{
            edge.sprite.removeFromParent()
            allEdges.append(edge)
        }
        
        gameEdges.removeAll()
    }
    
    func FindEdge( pos:CGPoint, isHorizontal:Bool )->Bool{
        for edge in gameEdges{
            if edge.pos.x == pos.x && edge.pos.y == pos.y && edge.isHorizontal == isHorizontal {
                return true
            }
        }
        return false
    }
    
    //finds the first row that's full
    func FindFullRow()->Int{
        
        for row in (0...boardSize-1).reversed(){
            var isFull = true
            for col in 0...boardSize-1{
                if GetTile(row: row, col: col) == nil {
                    isFull = false
                    break
                }
            }
            
            if isFull {
                return row
            }
        }
        
        return -1
    }
    
    func IsRowFull( row:Int )->Bool{
        var isFull = true
        
        for col in 0...boardSize-1{
            if GetTile(row: row, col: col) == nil {
                isFull = false
                break
            }
        }
            
        return isFull
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

        let gameSample = gameSamples[min(level, GameModel.maxLevel)]
        
        for index in 0...(gameSample.fruits.count-1){
            
            let gameItem = gameSample.fruits[ index ]
            
            if gameItem[0] == GameModel.EDGE_ID {
                if let edge = GetEmptyEdge( isHorizontal: gameItem[3] == 0 ) {
                    edge.pos.x = CGFloat(gameItem[1])
                    edge.pos.y = CGFloat(gameItem[2])
                    
                    if edge.isHorizontal {
                        edge.sprite.position.x = viewOffset.x + (edge.pos.x+CGFloat(0.5))*CGFloat(cellSize)
                        edge.sprite.position.y = viewOffset.y + (edge.pos.y + 1.0)*CGFloat(cellSize)
                    }
                    else {
                        edge.sprite.position.x = viewOffset.x + (edge.pos.x + 1.0)*CGFloat(cellSize)
                        edge.sprite.position.y = viewOffset.y + (edge.pos.y+CGFloat(0.5))*CGFloat(cellSize)
                    }
                    gameEdges.append(edge)
                }
            }
            else if let tile = GetEmptyTile() {
                //the cover count is optional at index 3
                if ( level >= 45 ) && ( level<=64) {
                    //for these levels cover is always 2 TBD big time
                    if gameItem.count > 3 && gameItem[3] > 0 {
                        tile.SetID(Id:gameItem[0], covers: 2 )
                    }
                    else{
                        tile.SetID(Id:gameItem[0], covers: 0 )
                    }
                }
                else
                {
                    tile.SetID(Id:gameItem[0], covers: ( gameItem.count > 3 ) ? gameItem[3] : 0 )
                }
                
                if gameItem[0] == GameModel.CHOLOLATE_ID {
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
        fruitBasketFrequency = gameSample.goals[ GameSample.Goals.BasketFrequency.rawValue ]
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
    
    func GetCoveredTileCount()->Int{
        var coveredTiles = 0
        
        for tile in gameTiles{
            if tile.GetCoverCount() > 0{
                coveredTiles += 1
            }
        }
        
        return coveredTiles
    }
    
    func AddTiles()->[TileNode]{
        
        var newTiles = [TileNode]()
        
        //Check if chocolate should be added
        if chAdded < targetChocolates {
            // if there's no chocolate
            if GetID(id: GameModel.CHOLOLATE_ID) == nil {
                
                var fullRow = FindFullRow()
                
                // we don't have a full row, so we build it
                if fullRow < 0 || fullRow >= boardSize-1 {
                    //we need to fill up the first row
                    for col in 0...boardSize-1{
                        if GetTile(row: 0, col: col) == nil {
                            if let tile = AddTile(id: GetRandomTileID(), pos: CGPoint(x: col, y: 0)) {
                                newTiles.append( tile )
                            }
                        }
                    }
                    fullRow = 0
                }
                
                
                if let emptyCell = FindEmptyCellForChocolate( minRow : fullRow + 1){
                    
                    if let tile = AddTile(id: GameModel.CHOLOLATE_ID, pos: emptyCell ) {
                        chAdded += 1
                        newTiles.append(tile)
                    }
                }
            }
        }
        
        let tilesToBeAdded = max( 1, MIN_TILES - gameTiles.count )
        
        if tilesToBeAdded > 0 {
            for _ in 1...tilesToBeAdded{
                if let emptyCell = FindEmptyCell(){
                    if let tile = AddTile(id: GetRandomTileID(), pos: emptyCell ) {
                        newTiles.append(tile)
                    }
                }
            }
        }
        
        return newTiles
    }
        
    func GetRandomTileID()->Int{
        
        //per 5 moves, the frequency decreases
        if fruitBasketFrequency != 0 && arc4random_uniform(UInt32(fruitBasketFrequency+moveCount/5)) == 0 {
            return GameModel.FRUIT_BASKET_ID
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
    
    func FindEmptyCellForChocolate(minRow:Int)->CGPoint?{
        var emptyCell = CGPoint(x: -1, y: -1)
        var emptyCellFound = false
        
        for row in (minRow...boardSize-1).reversed() {
            
            if !IsRowFull(row: row) {
                emptyCell.y = CGFloat(row)
                while (!emptyCellFound){
                    emptyCell.x = CGFloat(arc4random_uniform(UInt32(boardSize)))
                    if GetTile(pos: emptyCell) == nil {
                        emptyCellFound = true
                    }
                }
                
                return emptyCell
            }
        }
        
        return nil
    }
    
    func GetEmptyEdge( isHorizontal:Bool )->EdgeNode?{
        if allEdges.count > 0 {
            
            for i in 0...allEdges.count-1 {
                
                let edge = allEdges[i]
                
                if edge.isHorizontal == isHorizontal {
            
                    allEdges.remove(at: i)
            
                    return edge
                }
            }
            
        }
        
        return nil
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
    
    func GetEdges()->[EdgeNode]{
        return gameEdges
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
    
    func GetBamboo( row:Int, col:Int, isHorizontal:Bool)->EdgeNode?{
        for bamboo in gameEdges{
            if Int(bamboo.pos.x) == col && Int(bamboo.pos.y) == row && bamboo.isHorizontal == isHorizontal {
                return bamboo
            }
        }
        
        return nil
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
    
    //finds a tile with given flag set or reset
    func FindCoveredTile()->TileNode?{
        for tile in gameTiles {
            if ( tile.GetCoverCount() > 0 ){
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
                
                if gameTiles[i].GetID() != GameModel.BLOCKER_ID && gameTiles[i].GetID() != GameModel.BUBBLE_ID{
                    ChangeScore(delta: 1)
                }
                
                switch gameTiles[i].GetID() {
                case GameModel.CHOLOLATE_ID:
                    chRemoved += 1
                    break
                
                case GameModel.APPLE_ID:
                    applesRemoved += 1
                    break
                    
                case GameModel.STAR5_ID, GameModel.STAR7_ID:
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
    
    func RemoveBamboo( row:Int, col:Int, isHorizontal:Bool){
        if gameEdges.count > 0 {
            for i in 0...gameEdges.count-1{
                let bamboo = gameEdges[i]
                if Int(bamboo.pos.x) == col && Int(bamboo.pos.y) == row && bamboo.isHorizontal == isHorizontal {
                    gameEdges.remove(at: i)
                    allEdges.append(bamboo)
                    bamboo.sprite.removeFromParent()
                    print("Bamboo removed .......")
                    break
                }
            }
        }
    }
    
    func RemoveBamboo( bamboo:EdgeNode ){
        RemoveBamboo(row: bamboo.GetRow(), col: bamboo.GetCol(), isHorizontal: bamboo.isHorizontal)
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
                case GameModel.BUBBLE_ID, GameModel.STAR5_ID, GameModel.STAR7_ID, GameModel.FRUIT_BASKET_ID,GameModel.BOMB_ID:
                    if tile.GetCoverCount() == 0 {
                        return false
                    }
                    
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
            
            
            if gameSample.goals[ GameSample.Goals.BasketFrequency.rawValue ] > 0 {
                if i < firstLevelBasket {
                    firstLevelBasket = i
                }
            }
            
            for fruit in gameSample.fruits {
                if fruit[0] == GameModel.BLOCKED_ID {
                    if i < firstLevelBlocked {
                        firstLevelBlocked = i
                    }
                }
                else if fruit[0] == GameModel.BOMB_ID {
                    if i < firstLevelBomb {
                        firstLevelBomb = i
                    }
                }
                else if fruit[0] == GameModel.FRUIT_BASKET_ID {
                    if i < firstLevelBasket {
                        firstLevelBasket = i
                    }
                }
                else if fruit[0] == GameModel.HAND_SAW_ID {
                    if i < firstLevelSaw {
                        firstLevelSaw = i
                    }
                }
            }
            
            if firstLevelQuestion < 0 {
                for fruit in gameSample.fruits {
                    if fruit[0] == GameModel.QUESTION_ID {
                        firstLevelQuestion = i
                        break
                    }
                }
            }
            
            if firstCovered < 0 {
                for fruit in gameSample.fruits {
                    if fruit.count > 3 && fruit[3] != 0 && (fruit[0] != GameModel.EDGE_ID) {
                        firstCovered = i
                        break
                    }
                }
            }
            
        }
    }

        
    private init() {
        
        maxLevelCompleted = userDefaults.integer(forKey: "maxLevelCompleted") - 1
        
        // For debugging only
        maxLevelCompleted = 149

        
        var soundURL = Bundle.main.url(forResource: "bgMusic", withExtension: "wav")
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: soundURL!)
            musicPlayer?.numberOfLoops = -1

            if ( userDefaults.integer(forKey: "musicOn") == 0 ) {
                musicPlayer?.play()
            }

        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "tick", withExtension: "wav")
        do {
            try audioPlayer2 = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayer2?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "win", withExtension: "wav")
        do {
            try audioPlayerWin = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerWin?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "spinsinewave", withExtension: "wav")
        do {
            try audioPlayerWave = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerWave?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "laser", withExtension: "wav")
        do {
            try audioPlayerLaser = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerLaser?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "chime", withExtension: "mp3")
        do {
            try audioPlayerChime = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerChime?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")

        }
        
        soundURL = Bundle.main.url(forResource: "lose", withExtension: "wav")
        do {
            try audioPlayerLose = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerLose?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "breaking-glass", withExtension: "wav")
        do {
            try audioPlayerGlass = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerGlass?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "WoodCut", withExtension: "wav")
        do {
            try audioPlayerWoodCut = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerWoodCut?.numberOfLoops = -1
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        soundURL = Bundle.main.url(forResource: "Explosion", withExtension: "wav")
        do {
            try audioPlayerExplosion = AVAudioPlayer(contentsOf: soundURL!)
            audioPlayerExplosion?.numberOfLoops = 0
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        
        allTiles = [TileNode]()
        allEdges = [EdgeNode]()
        
        for _ in 1...boardSize*boardSize{

            let Tile = TileNode()
            
            allTiles.append( Tile )
            
            let Edge1 = EdgeNode(isHorizontal: true)
            allEdges.append(Edge1)
            
            let Edge2 = EdgeNode(isHorizontal: false)
            allEdges.append(Edge2)
            
        }
        
        gameTiles = [TileNode]()
        gameEdges = [EdgeNode]()
        
        gameSamples = [GameSample]()
        
            //fruits [id,x,y]
            //goals [Chcolate, targetScore, maxMoves, targetApples, targetSpecial, targetStars, colorCount, baloon frequency]
        /*
        //Level 1
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [1,1,1],
            [1,0,2],
            [1,1,3],
            [1,0,4],
            [1,1,5],
            [2,0,1],
            [2,1,0],
            [2,0,3],
            [2,1,2],
            [2,0,5],
            [2,1,4]
            ],
                                        goals: [0,40,0,0,0,0,4,0]
        ) )
        
        // Level 2
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [1,1,1],
            [1,2,0],
            [1,3,1],
            [1,4,0],
            [1,5,1],
            [2,0,1],
            [2,1,0],
            [2,2,1],
            [2,3,0],
            [2,4,1],
            [2,5,0]
            ],
                                        goals: [0,50,50,0,0,0,4,0]
        ) )
        
        //level 3
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1],
            [3,2,0],
            [4,3,1],
            [5,4,0],
            [6,5,1],
            [6,0,1],
            [5,1,0],
            [4,2,1],
            [3,3,0],
            [2,4,1],
            [1,5,0]
            ],
                                        goals: [0,50,100,0,0,0,6,0]
        ) )
        
        //Level 4
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1],
            [3,2,0],
            [4,3,1],
            [1,4,0],
            [2,5,1],
            [3,0,1],
            [4,1,0],
            [4,2,1],
            [3,3,0],
            [2,4,1],
            [1,5,0]
            ],
                                        goals: [0,0,50,10,0,0,4,0]
        ) )
        
        
        //Level 5
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1],
            [3,2,0],
            [4,3,1],
            [1,4,0],
            [2,5,1],
            [GameModel.CHOLOLATE_ID,0,5]
            ],
                                        goals: [3,0,50,0,0,0,4,0]
        ) )
        
        //Level 6
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1],
            [3,2,0],
            [4,3,1],
            [1,4,0],
            [2,5,1],
            [3,0,1],
            [4,1,0],
            [4,2,1],
            [3,3,0],
            [2,4,1],
            [1,5,0]
            ],
                                        goals: [0,0,60,15,0,0,4,0]
        ) )
        
        
        //Level 7
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1],
            [3,2,0],
            [4,3,1],
            [1,4,0],
            [2,5,1],
            [GameModel.CHOLOLATE_ID,0,5]
            ],
                                        goals: [5,0,60,0,0,0,4,0]
        ) )
        
        
        //level 8
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1],
            [3,2,0],
            [4,3,1],
            [1,4,0],
            [2,5,1],
            [3,0,1],
            [4,1,0],
            [4,2,1],
            [3,3,0],
            [2,4,1],
            [1,5,0]
            ],
                                        goals: [0,60,50,0,0,0,4,0]
        ) )
        
        //goals [Chcolate, targetScore, maxMoves, targetApples, targetSpecial, targetStars, colorCount, baloon frequency]
        //level 9
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,2],
            [GameModel.BLOCKED_ID,1,2],
            [GameModel.BLOCKED_ID,4,2],
            [GameModel.BLOCKED_ID,5,2]
            ],
                                        goals: [0,40,50,0,0,0,4,0]
        ) )
        
        //level 10
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,1],
            [GameModel.BLOCKED_ID,1,2],
            [GameModel.BLOCKED_ID,2,3],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.CHOLOLATE_ID,0,2]
            ],
                                        goals: [2,0,50,0,0,0,4,0]
        ) )
        
        //level 11
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1]
            ],
                                        goals: [0,0,50,0,2,0,4,0]
        ) )
        
        //level 12
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,1],
            [GameModel.BLOCKED_ID,1,2],
            [GameModel.BLOCKED_ID,2,3],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.CHOLOLATE_ID,0,2],
            [1,0,3],
            [2,1,3],
            [1,0,4],
            [2,1,4],
            [3,2,4],
            ],
                                        goals: [2,0,50,0,0,0,4,0]
        ) )
        
        //level 13
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,2],
            [GameModel.BLOCKED_ID,0,3],
            [GameModel.BLOCKED_ID,5,2],
            [GameModel.BLOCKED_ID,5,3]
            ],
                                        goals: [0,0,50,0,2,0,4,0]
        ) )
        
        
        //level 14
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,1],
            [GameModel.BLOCKED_ID,1,2],
            [GameModel.BLOCKED_ID,2,3],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,2],
            [1,0,3],
            [2,1,3],
            [1,0,4],
            [4,1,4],
            [3,2,4],
            [3,0,5],
            [2,1,5],
            [1,2,5],
            [4,3,5]
            ],
                                        goals: [2,0,50,0,0,0,4,0]
        ) )
        
        
        //level 15
        gameSamples.append( GameSample( fruits:[
            [1,0,0],
            [2,1,1]
            ],
                                        goals: [0,0,50,0,2,0,6,0]
        ) )
        
        
        //goals [Chcolate, targetScore, maxMoves, targetApples, targetSpecial, targetStars, colorCount, baloon frequency]
        
        //level 16
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [1,1,1],
            [1,2,1],
            [2,3,1],
            [3,4,1],
            [4,5,1]
            ],
                                        goals: [0,0,100,0,0,0,4,0]
        ) )
        
        //Level 17
        gameSamples.append( GameSample( fruits:[
            [GameModel.STAR5_ID,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [GameModel.STAR5_ID,0,3,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3],
            [2,2,3]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //Level 18
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [1,0,3,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3],
            [2,2,3]
            ],
                                        goals: [0,0,100,0,0,0,4,0]
            
        ) )
        
        //Level 19
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //Level 20
        gameSamples.append( GameSample( fruits:[
            [1,1,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.CHOLOLATE_ID,0,5]
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        
        //Level 21
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5],
            [2,2,5],
            [3,3,5],
            [3,4,5]
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        
        //Level 22
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [1,0,0],
            [2,1,0],
            [GameModel.STAR5_ID,2,0],
            [3,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5],
            [2,3,5],
            [2,0,1],
            [3,1,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //level 23
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,0,2,2],
            [3,0,4,1],
            [4,2,0,2],
            [5,2,2,1],
            [1,2,4,2],
            [1,4,0,1],
            [1,4,2,2],
            [1,4,4,1]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //Level 24
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [1,0,0],
            [2,1,0],
            [GameModel.STAR5_ID,2,0],
            [3,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5,1],
            [2,3,5,1],
            [2,0,1],
            [3,1,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //Level 25
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [GameModel.BLOCKED_ID,0,1],
            [2,0,2,1],
            [GameModel.BLOCKED_ID,0,3],
            [2,0,4,1],
            [GameModel.BLOCKED_ID,0,5],
            [1,5,0,1],
            [GameModel.BLOCKED_ID,5,1],
            [2,5,2,1],
            [GameModel.BLOCKED_ID,5,3],
            [2,5,4,1],
            [GameModel.BLOCKED_ID,5,5],
            [3,1,1],
            [4,2,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 26
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [1,0,0],
            [2,1,0],
            [GameModel.STAR5_ID,2,0],
            [3,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5,1],
            [2,3,5,1],
            [2,2,4,1],
            [3,3,4,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        
        //Level 27
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            
            [GameModel.BLOCKED_ID,0,1],
            [2,0,0,1],
            [GameModel.BLOCKED_ID,1,0],
            [GameModel.BLOCKED_ID,5,1],
            [3,5,0,1],
            [GameModel.BLOCKED_ID,4,0],
            
            [GameModel.STAR5_ID,2,2],
            [GameModel.STAR5_ID,3,2],
            
            [1,2,0],
            [1,3,0],
            [2,2,5],
            [2,3,5],
            
            
            [3,0,2],
            [3,0,3],
            [4,5,2],
            [4,5,3]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //Level 28
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [GameModel.STAR5_ID,0,0],
            [1,1,0],
            [2,2,0],
            [3,0,1],
            [4,1,1],
            [5,0,2]
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        
        //Level 29
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [1,2,5,1],
            [2,3,5,1],
            [2,4,5,1],
            [3,5,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            [5,2,4,1],
            [5,3,4,1],
            [1,4,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            [5,2,3,1],
            [5,3,3,1],
            
            [1,1,0],
            [2,2,0],
            [2,0,1],
            [4,1,1],
            [1,0,2]
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        //Level 30
        gameSamples.append( GameSample( fruits:[
            [GameModel.STAR5_ID,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3],
            [2,2,3]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 31
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [1,0,3,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3,1],
            [2,2,3,1],
            [2,3,3,1],
            [2,4,3,1],
            [1,2,2,1],
            [1,3,2,1]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
            
        ) )
        
        //Level 32
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,1,5,1],
            [GameModel.BLOCKED_ID,1,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [1,4,5,1],
            [GameModel.BLOCKED_ID,4,4]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 33
        gameSamples.append( GameSample( fruits:[
            [1,1,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.BLOCKED_ID,1,4],
            [1,2,5,1],
            [2,3,5,1],
            [2,2,4,1]
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 34
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5],
            [2,2,5],
            [3,3,5],
            [3,4,5],
            [4,5,5,1],
            [1,5,4],
            [1,5,3]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 35
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,4,4],
            [2,1,5,1],
            [2,4,5,1],
            [1,0,0],
            [2,1,0],
            [GameModel.STAR5_ID,2,0],
            [3,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5],
            [2,3,5],
            [2,0,1],
            [3,1,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 36
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [1,0,0],
            [2,1,0],
            [GameModel.STAR5_ID,2,0],
            [3,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5,1],
            [2,3,5,1],
            [2,2,4,1],
            [3,3,4,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 37
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [4,1,4,1],
            [4,2,4,1],
            [4,3,4,1],
            [4,4,4,1],
            [4,2,5,1],
            [4,3,5,1],
            [GameModel.STAR5_ID,2,0]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 38
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            
            [GameModel.BLOCKED_ID,0,1],
            [2,0,0,1],
            [GameModel.BLOCKED_ID,1,0],
            [GameModel.BLOCKED_ID,5,1],
            [3,5,0,1],
            [GameModel.BLOCKED_ID,4,0],
            
            [GameModel.STAR5_ID,2,2],
            [GameModel.STAR5_ID,3,2],
            
            [1,2,0,1],
            [1,3,0,1],
            [2,2,5,1],
            [2,3,5,1],
            
            
            [3,0,2,1],
            [3,0,3,1],
            [4,5,2,1],
            [4,5,3,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 39
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [GameModel.STAR5_ID,0,0],
            [1,5,5,1],
            [3,0,1],
            [4,1,1],
            [5,0,2]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 40
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [1,2,5,1],
            [2,3,5,1],
            [2,4,5,1],
            [3,5,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            [5,2,4,1],
            [5,3,4,1],
            [1,4,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            [5,2,3,1],
            [5,3,3,1],
            
            [1,0,2,1],
            [1,1,2,1],
            [5,2,2,1],
            
            [1,0,1,1],
            [1,1,1,1],
            
            [4,0,0,1],
            
            [GameModel.STAR5_ID,3,2]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 41
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            
            
            [1,0,0],
            [1,1,0],
            [4,2,0],
            [5,3,0],
            [2,0,1],
            [3,1,1],
            [1,2,1],
            [1,3,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 42
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [2,2,0,1],
            [3,3,0,1],
            [4,4,0,1],
            [5,5,0,1],
            [1,0,5,1],
            [2,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [4,4,5,1],
            [5,5,5,1],
            [2,0,1,1],
            [3,0,2,1],
            [3,0,3,1],
            [2,0,4,1],
            [2,5,1,1],
            [3,5,2,1],
            [3,5,3,1],
            [2,5,4,1],
            [3,1,1,1],
            [5,1,4,1],
            [2,4,1,1],
            [2,4,4,1],
            [3,2,2],
            [3,3,3]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 43
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            
            [GameModel.BLOCKED_ID,0,2],
            [GameModel.BLOCKED_ID,1,2],
            
            [1,2,5,1],
            [4,2,4,1],
            [1,2,3,1],
            [GameModel.BLOCKED_ID,2,2],
            [1,0,0]
            
            
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        //Level 44
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            
            [GameModel.BLOCKED_ID,0,2],
            [GameModel.BLOCKED_ID,1,2],
            
            [GameModel.CHOLOLATE_ID,5,5],
            [1,4,5,1],
            
            [4,5,4,1],
            [4,4,4,1],
            
            [1,5,3,1],
            [1,4,3,1],
            
            [GameModel.BLOCKED_ID,5,2],
            [GameModel.BLOCKED_ID,4,2],
            
            [1,1,0],
            [1,1,1]
            
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        //Level 45
        gameSamples.append( GameSample( fruits:[
            
            
            [1,0,2,1],
            [1,1,2,1],
            [1,2,2,1],
            [2,3,2,1],
            [2,4,2,1],
            [2,5,2,1],
            [1,0,3,1],
            [1,1,3,1],
            [1,2,3,1],
            [2,3,3,1],
            [2,4,3,1],
            [2,5,3,1],
            
            
            [1,1,0],
            [1,1,1]
            
            
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        
        //Level 46
        gameSamples.append( GameSample( fruits:[
            [GameModel.STAR5_ID,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [GameModel.STAR5_ID,0,3,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3],
            [2,2,3]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //Level 47
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [1,0,3,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3],
            [2,2,3]
            ],
                                        goals: [0,0,100,0,0,0,4,0]
            
        ) )
        
        //Level 48
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        //Level 49
        gameSamples.append( GameSample( fruits:[
            [1,1,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.CHOLOLATE_ID,0,5]
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        
        //Level 50
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [GameModel.BLOCKED_ID,0,1],
            [2,0,2,1],
            [GameModel.BLOCKED_ID,0,3],
            [2,0,4,1],
            [GameModel.BLOCKED_ID,0,5],
            [1,5,0,1],
            [GameModel.BLOCKED_ID,5,1],
            [2,5,2,1],
            [GameModel.BLOCKED_ID,5,3],
            [2,5,4,1],
            [GameModel.BLOCKED_ID,5,5],
            [3,1,1],
            [4,2,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 51
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [GameModel.STAR5_ID,0,0],
            [GameModel.STAR5_ID,1,0],
            [2,2,0],
            [3,0,1],
            [4,1,1],
            [5,0,2]
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        
        //Level 52
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [1,2,5,1],
            [2,3,5,1],
            [2,4,5,1],
            [3,5,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            [5,2,4,1],
            [5,3,4,1],
            [1,4,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            [5,2,3,1],
            [5,3,3,1],
            
            [1,1,0],
            [2,2,0],
            [2,0,1],
            [4,1,1],
            [1,0,2]
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        //Level 53
        gameSamples.append( GameSample( fruits:[
            [GameModel.STAR5_ID,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3],
            [2,2,3]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 54
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [3,2,0,1],
            [4,3,0,1],
            [1,4,0,1],
            [2,5,0,1],
            [3,0,1,1],
            [4,1,1,1],
            [1,2,1,1],
            [2,3,1,1],
            [3,4,1,1],
            [4,5,1,1],
            [1,0,2,1],
            [2,1,2,1],
            [3,4,2,1],
            [4,5,2,1],
            [1,0,3,1],
            [2,5,3,1],
            [1,0,4],
            [1,0,5],
            [1,5,5],
            [2,1,3,1],
            [2,2,3,1],
            [2,3,3,1],
            [2,4,3,1],
            [1,2,2,1],
            [1,3,2,1]
            ],
                                        goals: [0,0,100,0,0,0,5,0]
            
        ) )

        //Level 55
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,4,4],
            [2,1,5,1],
            [2,4,5,1],
            [1,0,0],
            [2,1,0],
            [GameModel.STAR5_ID,2,0],
            [GameModel.STAR5_ID,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5],
            [2,3,5],
            [2,0,1],
            [3,1,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 56
        gameSamples.append( GameSample( fruits:[
            [1,1,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.BLOCKED_ID,1,4],
            [1,2,5,1],
            [2,3,5,1],
            [2,2,4,1]
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 57
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5],
            [2,2,5],
            [3,3,5],
            [3,4,5],
            [4,5,5,1],
            [1,5,4],
            [1,5,3]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 58
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,1,5,1],
            [GameModel.BLOCKED_ID,1,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [1,4,5,1],
            [GameModel.BLOCKED_ID,4,4]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 59
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [1,0,0],
            [2,1,0],
            [GameModel.STAR5_ID,2,0],
            [GameModel.STAR5_ID,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5,1],
            [2,3,5,1],
            [2,2,4,1],
            [3,3,4,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        //Level 60
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [4,1,4,1],
            [4,2,4,1],
            [4,3,4,1],
            [4,4,4,1],
            [4,2,5,1],
            [4,3,5,1],
            [GameModel.STAR5_ID,2,0],
            [GameModel.STAR5_ID,0,0]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 61
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [1,2,5,1],
            [2,3,5,1],
            [2,4,5,1],
            [3,5,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            [5,2,4,1],
            [5,3,4,1],
            [1,4,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            [5,2,3,1],
            [5,3,3,1],
            
            [1,0,2,1],
            [1,1,2,1],
            [5,2,2,1],
            
            [1,0,1,1],
            [1,1,1,1],
            
            [4,0,0,1],
            
            [GameModel.STAR5_ID,3,2],
            [GameModel.STAR5_ID,4,2]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 62
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [2,2,0,1],
            [3,3,0,1],
            [4,4,0,1],
            [5,5,0,1],
            [1,0,5,1],
            [2,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [4,4,5,1],
            [5,5,5,1],
            [2,0,1,1],
            [3,0,2,1],
            [3,0,3,1],
            [2,0,4,1],
            [2,5,1,1],
            [3,5,2,1],
            [3,5,3,1],
            [2,5,4,1],
            [3,1,1,1],
            [5,1,4,1],
            [2,4,1,1],
            [2,4,4,1],
            [3,2,2],
            [GameModel.STAR5_ID,3,3]
            ],
                                        goals: [0,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 63
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            
            [GameModel.BLOCKED_ID,0,2],
            [GameModel.BLOCKED_ID,1,2],
            
            [1,2,5,1],
            [4,2,4,1],
            [1,2,3,1],
            [GameModel.BLOCKED_ID,2,2],
            [1,0,0]
            
            
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        //Level 64
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            
            [GameModel.BLOCKED_ID,0,2],
            [GameModel.BLOCKED_ID,1,2],
            
            [GameModel.CHOLOLATE_ID,5,5],
            [1,4,5,1],
            
            [4,5,4,1],
            [4,4,4,1],
            
            [1,5,3,1],
            [1,4,3,1],
            
            [GameModel.BLOCKED_ID,5,2],
            [GameModel.BLOCKED_ID,4,2],
            
            [1,1,0],
            [1,1,1]
            
            
            ],
                                        goals: [2,0,100,0,0,0,5,0]
        ) )
        
        //Level 65
        gameSamples.append( GameSample( fruits:[
            
            
            [1,0,2,1],
            [1,1,2,1],
            [1,2,2,1],
            [2,3,2,1],
            [2,4,2,1],
            [2,5,2,1],
            [1,0,3,1],
            [1,1,3,1],
            [1,2,3,1],
            [2,3,3,1],
            [2,4,3,1],
            [2,5,3,1],
            
            
            [GameModel.STAR5_ID,1,0],
            [1,1,1]
            
            
            ],
                                        goals: [0,0,100,0,0,0,5,0]
        ) )
        
        
        

        //Level 66
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5],
            [2,2,5],
            [3,3,5],
            [3,4,5]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        //level 67
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,0,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.CHOLOLATE_ID,0,2],
            [1,0,3],
            [2,1,3],
            [1,0,4],
            [4,1,4],
            [3,2,4],
            [3,0,5],
            [2,1,5],
            [1,2,5],
            [4,3,5]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //level 68
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [1,0,3,1],
            [2,1,3,1],
            [1,0,4,1],
            [4,1,4,1],
            [3,2,4,1],
            [3,0,5,1],
            [2,1,5,1],
            [1,2,5,1],
            [4,2,3,1]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )
        
        //level 69
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,1,4,1],
            [1,0,4,1],
            [4,1,4,1],
            [3,0,5,1],
            [2,1,5,1],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,3,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [1,4,4,1],
            [4,5,4,1],
            [3,4,5,1],
            [2,5,5,1]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )

        //Level 70
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [4,5,5,1]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        

        //Level 71
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,1,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,3,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.CHOLOLATE_ID,5,5]
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        //Level 72
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [3,4,5,2],
            [4,5,5,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 73
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5],
            [2,2,5],
            [3,3,5],
            [3,4,5],
            [4,5,5]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 74
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [4,5,5,1]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        //level 75
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,0,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.CHOLOLATE_ID,0,2],
            [1,0,3,1],
            [2,1,3,1],
            [1,0,4,1],
            [4,1,4,1],
            [3,2,4,1],
            [3,0,5,1],
            [2,1,5,1],
            [1,2,5,1],
            [4,3,5,1]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 76
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [4,5,5,1]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        //Level 77
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [3,4,5,2],
            [4,5,5,2]
            
            ],
                                        goals: [2,0,100,0,0,0,6,0]
        ) )
        
        
        //Level 78
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [3,4,5,2],
            [4,5,5,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        

        //level 79
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [1,0,3,2],
            [2,1,3,2],
            [1,0,4,2],
            [4,1,4,2],
            [3,2,4,2],
            [3,0,5,2],
            [2,1,5,2],
            [1,2,5,2],
            [4,2,3,2]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )
        
        //level 80
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,1,4,1],
            [1,0,4,2],
            [4,1,4,2],
            [3,0,5,2],
            [2,1,5,2],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,3,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [1,4,4,2],
            [4,5,4,2],
            [3,4,5,2],
            [2,5,5,2]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )
        
        //level 81
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,1,4,1],
            [1,0,4,1],
            [4,1,4,1],
            [3,0,5,1],
            [2,1,5,1],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,3,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [1,4,4,1],
            [4,5,4,1],
            [3,4,5,1],
            [2,5,5,1],
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [1,0,0,1],
            [4,1,0,1],
            [3,0,1,1],
            [2,1,1,1],
            [GameModel.EDGE_ID,4,1,0],
            [GameModel.EDGE_ID,5,1,0],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [1,4,0,1],
            [4,5,0,1],
            [3,4,1,1],
            [2,5,1,1],
            [3,2,3]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )
        
        //Level 82
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,1,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,3,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [1,0,4],
            [2,1,4],
            [2,2,4],
            [4,3,4],
            [5,4,4],
            [5,5,4],
            [1,0,0]
            
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        //Level 83
        gameSamples.append( GameSample( fruits:[
            [1,0,0,1],
            [2,1,0,1],
            [2,2,0,1],
            [3,3,0,1],
            [4,4,0,1],
            [5,5,0,1],
            [1,0,5,1],
            [2,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [4,4,5,1],
            [5,5,5,1],
            [2,0,1,1],
            [3,0,2,1],
            [3,0,3,1],
            [2,0,4,1],
            [2,5,1,1],
            [3,5,2,1],
            [3,5,3,1],
            [2,5,4,1],
            [3,1,1,1],
            [5,1,4,1],
            [2,4,1,1],
            [2,4,4,1],
            [1,1,2,1],
            [1,1,3,1],
            [1,4,2,1],
            [1,4,3,1],
            
            [GameModel.STAR5_ID,2,2],
            [GameModel.STAR5_ID,3,3]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )
        

        //Level 84
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.EDGE_ID,4,3,0]
            
            ],
                                        goals: [4,0,0,0,0,0,6,0]
        ) )
        
        
        //Level 85
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,0,2,1],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,0,4,1],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,4,1,1],
            [GameModel.EDGE_ID,4,2,1],
            [GameModel.EDGE_ID,4,3,1],
            [GameModel.EDGE_ID,4,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [1,0,0],
            [5,0,1],
            [2,0,2],
            [3,0,3],
            [4,0,4],
            [1,5,0],
            [5,5,1],
            [2,5,2],
            [3,5,3],
            [4,5,4]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //level 86
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,0,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.CHOLOLATE_ID,0,2],
            [1,0,3,2],
            [2,1,3,2],
            [1,0,4,2],
            [4,1,4,2],
            [3,2,4,2],
            [3,0,5,2],
            [2,1,5,2],
            [1,2,5,2],
            [4,3,5,2]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        

        //level 87
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,1,4,1],
            [1,0,4,2],
            [4,1,4,2],
            [3,0,5,2],
            [2,1,5,2],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,3,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [1,4,4,2],
            [4,5,4,2],
            [3,4,5,2],
            [2,5,5,2],
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [1,0,0,2],
            [4,1,0,2],
            [3,0,1,2],
            [2,1,1,2],
            [GameModel.EDGE_ID,4,1,0],
            [GameModel.EDGE_ID,5,1,0],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [1,4,0,2],
            [4,5,0,2],
            [3,4,1,2],
            [2,5,1,2],
            [3,2,3]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )
        
        //Level 88
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,1,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,3,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [1,0,4,1],
            [2,1,4,1],
            [2,2,4,1],
            [4,3,4,1],
            [5,4,4,1],
            [5,5,4,1],
            [1,0,0]
            
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )

        //Level 89
        gameSamples.append( GameSample( fruits:[
            [1,0,0,2],
            [2,1,0,2],
            [2,2,0,2],
            [3,3,0,2],
            [4,4,0,2],
            [5,5,0,2],
            [1,0,5,2],
            [2,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [5,5,5,2],
            [2,0,1,2],
            [3,0,2,2],
            [3,0,3,2],
            [2,0,4,2],
            [2,5,1,2],
            [3,5,2,2],
            [3,5,3,2],
            [2,5,4,2],
            [3,1,1,2],
            [5,1,4,2],
            [2,4,1,2],
            [2,4,4,2],
            [1,1,2,2],
            [1,1,3,2],
            [1,4,2,2],
            [1,4,3,2],
            
            [GameModel.STAR5_ID,2,2],
            [GameModel.STAR5_ID,3,3]
            ],
                                        goals: [0,0,0,0,0,0,6,0]
        ) )
        
        
        //Level 90
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.EDGE_ID,4,3,0],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [4,4,5,1],
            [5,5,5,1],
            [5,0,4,1],
            [1,1,4,1],
            [2,2,4,1],
            [3,3,4,1],
            [4,4,4,1],
            [5,5,4,1],
            [1,0,0]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        

        //Level 91
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,0,2,1],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,0,4,1],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,4,1,1],
            [GameModel.EDGE_ID,4,2,1],
            [GameModel.EDGE_ID,4,3,1],
            [GameModel.EDGE_ID,4,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [1,0,0,1],
            [5,0,1,1],
            [2,0,2,1],
            [3,0,3,1],
            [4,0,4,1],
            [1,5,0,1],
            [5,5,1,1],
            [2,5,2,1],
            [3,5,3,1],
            [4,5,4,1],
            [2,2,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 92
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,1,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,3,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [1,0,4,2],
            [2,1,4,2],
            [2,2,4,2],
            [4,3,4,2],
            [5,4,4,2],
            [5,5,4,2],
            [1,0,0]
            
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        //Level 93
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,1,5,1],
            [GameModel.CHOLOLATE_ID,2,5,1],
            [GameModel.CHOLOLATE_ID,3,5,1],
            [GameModel.CHOLOLATE_ID,4,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            [1,0,4,1],
            [2,1,4,1],
            [2,2,4,1],
            [4,3,4,1],
            [5,4,4,1],
            [5,5,4,1],
            [1,0,0]
            
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )

        //Level 94
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.EDGE_ID,4,3,0],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [4,4,5,1],
            [5,5,5,1],
            [5,0,4,1],
            [1,1,4,1],
            [2,2,4,1],
            [3,3,4,1],
            [4,4,4,1],
            [5,5,4,1],
            [1,0,0]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        
        //Level 95
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,0,2,1],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,0,4,1],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,4,1,1],
            [GameModel.EDGE_ID,4,2,1],
            [GameModel.EDGE_ID,4,3,1],
            [GameModel.EDGE_ID,4,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [1,0,0,2],
            [5,0,1,2],
            [2,0,2,2],
            [3,0,3,2],
            [4,0,4,2],
            [1,5,0,2],
            [5,5,1,2],
            [2,5,2,2],
            [3,5,3,2],
            [4,5,4,2],
            [2,2,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 96
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,1,5,2],
            [GameModel.CHOLOLATE_ID,2,5,2],
            [GameModel.CHOLOLATE_ID,3,5,2],
            [GameModel.CHOLOLATE_ID,4,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [1,0,4,2],
            [2,1,4,2],
            [2,2,4,2],
            [4,3,4,2],
            [5,4,4,2],
            [5,5,4,2],
            [1,0,0]
            
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        //Level 97
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,1,5,1],
            [GameModel.CHOLOLATE_ID,2,5,1],
            [GameModel.CHOLOLATE_ID,3,5,1],
            [GameModel.CHOLOLATE_ID,4,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            [1,0,4,1],
            [2,1,4,1],
            [2,2,4,1],
            [4,3,4,1],
            [5,4,4,1],
            [5,5,4,1],
            [1,0,3,1],
            [2,1,3,1],
            [2,2,3,1],
            [4,3,3,1],
            [5,4,3,1],
            [5,5,3,1],
            [1,0,0]
            
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        //Level 98
        gameSamples.append( GameSample( fruits:[
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,1,5,2],
            [GameModel.CHOLOLATE_ID,2,5,2],
            [GameModel.CHOLOLATE_ID,3,5,2],
            [GameModel.CHOLOLATE_ID,4,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [1,0,4,2],
            [2,1,4,2],
            [2,2,4,2],
            [4,3,4,2],
            [5,4,4,2],
            [5,5,4,2],
            [1,0,3,2],
            [2,1,3,2],
            [2,2,3,2],
            [4,3,3,2],
            [5,4,3,2],
            [5,5,3,2],
            [1,0,0]
            
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        
        
        //Level 99
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.EDGE_ID,4,3,0],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [5,5,5,2],
            [5,0,4,2],
            [1,1,4,2],
            [2,2,4,2],
            [3,3,4,2],
            [4,4,4,2],
            [5,5,4,2],
            [1,0,0]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 100
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.EDGE_ID,4,3,0],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [5,5,5,2],
            [5,0,4,2],
            [1,1,4,2],
            [2,2,4,2],
            [3,3,4,2],
            [4,4,4,2],
            [5,5,4,2],
            [5,0,3,2],
            [1,1,3,2],
            [2,2,3,2],
            [3,3,3,2],
            [4,4,3,2],
            [5,5,3,2],
            [GameModel.STAR5_ID,0,0],
            [GameModel.STAR5_ID,3,1]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        */
        
        //First level basket
        //Level 101
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,0,2,1],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,0,4,1],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,4,1,1],
            [GameModel.EDGE_ID,4,2,1],
            [GameModel.EDGE_ID,4,3,1],
            [GameModel.EDGE_ID,4,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [1,0,0,2],
            [5,0,1,2],
            [2,0,2,2],
            [3,0,3,2],
            [4,0,4,2],
            [1,5,0,2],
            [5,5,1,2],
            [2,5,2,2],
            [3,5,3,2],
            [4,5,4,2],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [GameModel.FRUIT_BASKET_ID,2,2],
            [GameModel.FRUIT_BASKET_ID,2,3],
            [4,1,3]
            
            ],
                                        goals: [2,0,0,0,0,0,6,5]
        ) )
        
        //Level 102
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            [5,0,3,2],
            [2,0,4,2],
            [2,1,3,2],
            [5,1,4,2],
            [3,2,3,2],
            [2,2,4,2],
            [5,3,3,2],
            [5,3,4,2],
            [3,4,3,2],
            [2,4,4,2],
            [5,5,3,2],
            [2,5,4,2],
            [GameModel.FRUIT_BASKET_ID,2,1],
            [GameModel.FRUIT_BASKET_ID,2,0],
            [4,0,0]
            
            ],
                                        goals: [3,0,0,0,0,0,6,7]
        ) )
        

        //goals [Chcolate, targetScore, maxMoves, targetApples, targetSpecial, targetStars, colorCount, baloon frequency]
        //Level 103
        gameSamples.append( GameSample( fruits:[
            [1,0,5]
            ,[GameModel.FRUIT_BASKET_ID,0,0]
            ],
                                        goals: [0,0,0,0,0,5,6,6]
        ) )
        
        
        //Level 104
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [GameModel.FRUIT_BASKET_ID,0,0],
            [1,1,0],
            [2,2,0],
            [3,0,1],
            [4,1,1],
            [5,0,2]
            
            ],
                                        goals: [2,0,0,0,0,0,5,6]
        ) )
        
        //Level 105
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,4,4],
            [2,1,5,1],
            [2,4,5,1],
            [1,0,0],
            [2,1,0],
            [GameModel.FRUIT_BASKET_ID,2,0],
            [3,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5],
            [2,3,5],
            [2,0,1],
            [3,1,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        //Level 106
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [1,0,0],
            [2,1,0],
            [GameModel.FRUIT_BASKET_ID,2,0],
            [3,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5,1],
            [2,3,5,1],
            [2,2,4,1],
            [3,3,4,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        //Level 107
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [4,1,4,1],
            [4,2,4,1],
            [4,3,4,1],
            [4,4,4,1],
            [4,2,5,1],
            [4,3,5,1],
            [GameModel.FRUIT_BASKET_ID,2,0]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        
        //Level 108
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            
            [GameModel.BLOCKED_ID,0,1],
            [2,0,0,1],
            [GameModel.BLOCKED_ID,1,0],
            [GameModel.BLOCKED_ID,5,1],
            [3,5,0,1],
            [GameModel.BLOCKED_ID,4,0],
            
            [GameModel.FRUIT_BASKET_ID,2,2],
            [GameModel.FRUIT_BASKET_ID,3,2],
            
            [1,2,0,1],
            [1,3,0,1],
            [2,2,5,1],
            [2,3,5,1],
            
            
            [3,0,2,1],
            [3,0,3,1],
            [4,5,2,1],
            [4,5,3,1]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        //Level 109
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [2,2,5,1],
            [3,3,5,1],
            [3,4,5,1],
            [GameModel.FRUIT_BASKET_ID,0,0],
            [1,5,5,1],
            [3,0,1],
            [4,1,1],
            [5,0,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,6]
        ) )
        
        
        //Level 110
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,1],
            [1,2,5,1],
            [2,3,5,1],
            [2,4,5,1],
            [3,5,5,1],
            
            [4,0,4,1],
            [4,1,4,1],
            [5,2,4,1],
            [5,3,4,1],
            [1,4,4,1],
            
            [1,0,3,1],
            [1,1,3,1],
            [5,2,3,1],
            [5,3,3,1],
            
            [1,0,2,1],
            [1,1,2,1],
            [5,2,2,1],
            
            [1,0,1,1],
            [1,1,1,1],
            
            [4,0,0,1],
            
            [GameModel.FRUIT_BASKET_ID,3,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,6]
        ) )
        
        
        //Level 111
        gameSamples.append( GameSample( fruits:[
            [1,0,5,1],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,1],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            
            
            [1,0,0],
            [1,1,0],
            [4,2,0],
            [5,3,0],
            [2,0,1],
            [3,1,1],
            [GameModel.FRUIT_BASKET_ID,2,1],
            [GameModel.FRUIT_BASKET_ID,3,1]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        
        //Level 112
        gameSamples.append( GameSample( fruits:[
            [GameModel.BLOCKED_ID,0,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,2,4],
            [GameModel.BLOCKED_ID,3,4],
            [GameModel.BLOCKED_ID,4,4],
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [3,4,5,2],
            [GameModel.FRUIT_BASKET_ID,0,0],
            [GameModel.FRUIT_BASKET_ID,1,0],
            [2,2,0],
            [3,0,1],
            [4,1,1],
            [5,0,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,6]
        ) )
        
        //Level 113
        gameSamples.append( GameSample( fruits:[
            [1,0,5,2],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,2],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,4],
            [GameModel.BLOCKED_ID,4,4],
            [2,1,5,2],
            [2,4,5,2],
            [1,0,0],
            [2,1,0],
            [GameModel.FRUIT_BASKET_ID,2,0],
            [GameModel.FRUIT_BASKET_ID,3,0],
            [3,4,0],
            [4,5,0],
            [1,2,5],
            [2,3,5],
            [2,0,1],
            [3,1,1],
            [4,2,1],
            [5,3,1],
            [5,4,1]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )

        //Level 114
        gameSamples.append( GameSample( fruits:[
            [1,0,5,2],
            [GameModel.BLOCKED_ID,0,4],
            [1,5,5,2],
            [GameModel.BLOCKED_ID,5,4],
            [GameModel.BLOCKED_ID,1,5],
            [GameModel.BLOCKED_ID,4,5],
            [4,1,4,2],
            [4,2,4,2],
            [4,3,4,2],
            [4,4,4,2],
            [4,2,5,2],
            [4,3,5,2],
            [GameModel.FRUIT_BASKET_ID,2,0],
            [GameModel.FRUIT_BASKET_ID,0,0]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        
        //Level 115
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [1,1,5,2],
            [1,2,5,2],
            [2,3,5,2],
            [2,4,5,2],
            [3,5,5,2],
            
            [4,0,4,2],
            [4,1,4,2],
            [5,2,4,2],
            [5,3,4,2],
            [1,4,4,2],
            
            [1,0,3,2],
            [1,1,3,2],
            [5,2,3,2],
            [5,3,3,2],
            
            [1,0,2,2],
            [1,1,2,2],
            [5,2,2,2],
            
            [1,0,1,2],
            [1,1,1,2],
            
            [4,0,0,2],
            
            [GameModel.FRUIT_BASKET_ID,3,2],
            [GameModel.FRUIT_BASKET_ID,4,2]
            
            ],
                                        goals: [2,0,0,0,0,0,6,6]
        ) )
        
        
        //Level 116
        gameSamples.append( GameSample( fruits:[
            [1,0,0,2],
            [2,1,0,2],
            [2,2,0,2],
            [3,3,0,2],
            [4,4,0,2],
            [5,5,0,2],
            [1,0,5,2],
            [2,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [5,5,5,2],
            [2,0,1,2],
            [3,0,2,2],
            [3,0,3,2],
            [2,0,4,2],
            [2,5,1,2],
            [3,5,2,2],
            [3,5,3,2],
            [2,5,4,2],
            [3,1,1,2],
            [5,1,4,2],
            [2,4,1,2],
            [2,4,4,2],
            [3,2,2],
            [GameModel.FRUIT_BASKET_ID,3,3]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        //Level 117
        gameSamples.append( GameSample( fruits:[
            
            
            [1,0,2,2],
            [1,1,2,2],
            [1,2,2,2],
            [2,3,2,2],
            [2,4,2,2],
            [2,5,2,2],
            [1,0,3,2],
            [1,1,3,2],
            [1,2,3,2],
            [2,3,3,2],
            [2,4,3,2],
            [2,5,3,2],
            
            
            [GameModel.FRUIT_BASKET_ID,1,0],
            [GameModel.FRUIT_BASKET_ID,1,1]
            
            
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        //Level 118
        gameSamples.append( GameSample( fruits:[
            [1,0,0,2],
            [2,1,0,2],
            [2,2,0,2],
            [3,3,0,2],
            [4,4,0,2],
            [5,5,0,2],
            [1,0,5,2],
            [2,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [5,5,5,2],
            [2,0,1,2],
            [3,0,2,2],
            [3,0,3,2],
            [2,0,4,2],
            [2,5,1,2],
            [3,5,2,2],
            [3,5,3,2],
            [2,5,4,2],
            [3,1,1,2],
            [5,1,4,2],
            [2,4,1,2],
            [2,4,4,2],
            [1,1,2,2],
            [1,1,3,2],
            [1,4,2,2],
            [1,4,3,2],
            
            [GameModel.FRUIT_BASKET_ID,2,2],
            [GameModel.FRUIT_BASKET_ID,3,3]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        //Level 119
        gameSamples.append( GameSample( fruits:[
            [1,0,0,2],
            [2,1,0,2],
            [2,2,0,2],
            [3,3,0,2],
            [4,4,0,2],
            [5,5,0,2],
            [1,0,5,2],
            [2,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [5,5,5,2],
            [2,0,1,2],
            [3,0,2,2],
            [3,0,3,2],
            [2,0,4,2],
            [2,5,1,2],
            [3,5,2,2],
            [3,5,3,2],
            [2,5,4,2],
            [3,1,1,2],
            [5,1,4,2],
            [2,4,1,2],
            [2,4,4,2],
            [1,1,2,2],
            [1,1,3,2],
            [1,4,2,2],
            [1,4,3,2],
            
            [GameModel.FRUIT_BASKET_ID,2,2],
            [GameModel.FRUIT_BASKET_ID,3,3]
            ],
                                        goals: [0,0,0,0,0,0,6,6]
        ) )
        
        
        //Level 120
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,3,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.EDGE_ID,4,3,0],
            [1,1,5,2],
            [2,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [5,5,5,2],
            [5,0,4,2],
            [1,1,4,2],
            [2,2,4,2],
            [3,3,4,2],
            [4,4,4,2],
            [5,5,4,2],
            [5,0,3,2],
            [1,1,3,2],
            [2,2,3,2],
            [3,3,3,2],
            [4,4,3,2],
            [5,5,3,2],
            [GameModel.FRUIT_BASKET_ID,0,0],
            [GameModel.FRUIT_BASKET_ID,3,1]
            
            ],
                                        goals: [2,0,0,0,0,0,6,6]
        ) )
        

        //Level 121
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,5,4,0],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.HAND_SAW_ID,3,5]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 122
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,5,4,0],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.HAND_SAW_ID,3,5],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 123
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.EDGE_ID,0,0,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,5,1],
            
            [GameModel.HAND_SAW_ID,0,0]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 124
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,2,5,1]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 125
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,1,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,3,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [1,0,4],
            [2,1,4],
            [2,2,4],
            [4,3,4],
            [2,4,4],
            [6,5,4],
            
            [GameModel.HAND_SAW_ID,0,0]
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        
        //Level 126
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,1,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,3,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,3,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,2,0],
            
            [GameModel.HAND_SAW_ID,0,0]
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        //Level 127
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,4,0]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 128
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,1,5,1],
            [GameModel.CHOLOLATE_ID,2,5,1],
            [GameModel.CHOLOLATE_ID,3,5,1],
            
            [GameModel.CHOLOLATE_ID,0,4,1],
            [GameModel.CHOLOLATE_ID,1,4,1],
            [GameModel.CHOLOLATE_ID,2,4,1],
            [GameModel.CHOLOLATE_ID,3,4,1],
            
            [GameModel.CHOLOLATE_ID,0,3,1],
            [GameModel.CHOLOLATE_ID,1,3,1],
            [GameModel.CHOLOLATE_ID,2,3,1],
            [GameModel.CHOLOLATE_ID,3,3,1],
            
            [GameModel.CHOLOLATE_ID,0,2,1],
            [GameModel.CHOLOLATE_ID,1,2,1],
            [GameModel.CHOLOLATE_ID,2,2,1],
            [GameModel.CHOLOLATE_ID,3,2,1],
            
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,2,1,0],
            [GameModel.EDGE_ID,3,1,0],
            
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.FRUIT_BASKET_ID,1,0],
            [GameModel.FRUIT_BASKET_ID,2,0]
            ],
                                        goals: [16,0,0,0,0,0,6,4]
        ) )
        
        //Level 129
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,0,4,1],
            [GameModel.CHOLOLATE_ID,0,3,1],
            [GameModel.CHOLOLATE_ID,0,2,1],
            [GameModel.CHOLOLATE_ID,0,1,1],
            
            [GameModel.CHOLOLATE_ID,5,5,1],
            [GameModel.CHOLOLATE_ID,5,4,1],
            [GameModel.CHOLOLATE_ID,5,3,1],
            [GameModel.CHOLOLATE_ID,5,2,1],
            [GameModel.CHOLOLATE_ID,5,1,1],
            
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,4,0],
            
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,2,0],
            
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,4,1,0],
            [GameModel.EDGE_ID,5,1,0],
            
            [GameModel.EDGE_ID,0,0,0],
            [GameModel.EDGE_ID,1,0,0],
            [GameModel.EDGE_ID,4,0,0],
            [GameModel.EDGE_ID,5,0,0]
            
            ],
                                        goals: [10,0,0,0,0,0,6,0]
        ) )
        
        //Level 130
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,2,0],
            
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,3,1],
            
            [1,1,5,1],
            [3,2,5,1],
            [4,3,5,1],
            [2,4,5,1],
            
            [4,0,4,1],
            [6,1,4,1],
            [2,2,4,1],
            [1,3,4,1],
            [3,4,4,1],
            [4,5,4,1],
            
            [2,0,3,1],
            [4,1,3,1],
            [1,2,3,1],
            [1,3,3,1],
            [4,4,3,1],
            [6,5,3,1],
            
            [GameModel.HAND_SAW_ID,0,0,1]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //Level 131
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.CHOLOLATE_ID,5,5],
            [GameModel.CHOLOLATE_ID,1,5],
            [GameModel.CHOLOLATE_ID,4,5],
            [GameModel.CHOLOLATE_ID,2,5],
            [GameModel.CHOLOLATE_ID,3,5],
            
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,1,0],
            [GameModel.EDGE_ID,5,2,0],
            [GameModel.EDGE_ID,5,3,0],
            
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,2,0,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,2,1,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,5,1]
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        
        
        
        
        ///New Levels
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,5,4,0],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            [2,1,5,2],
            [4,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [2,0,4,2],
            [4,1,4,2],
            [2,2,4,2],
            [4,3,4,2],
            [2,4,4,2],
            [4,5,4,2],
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.EDGE_ID,5,4,0],
            [GameModel.EDGE_ID,4,5,1],
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            [2,1,5,2],
            [4,2,5,2],
            [3,3,5,2],
            [4,4,5,2],
            [2,0,4,2],
            [4,1,4,2],
            [2,2,4,2],
            [4,3,4,2],
            [2,4,4,2],
            [4,5,4,2],
            [3,0,3,2],
            [4,1,3,2],
            [2,2,3,2],
            [4,3,3,2],
            [2,4,3,2],
            [4,5,3,2],
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        
        //126
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5],
            [GameModel.EDGE_ID,0,0,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [2,1,5],
            [4,2,5],
            [3,3,5],
            [2,4,5],
            
            [3,0,4],
            [3,1,4],
            [5,2,4],
            [3,3,4],
            
            [2,0,3],
            [6,1,3],
            [4,2,3],
            
            [3,0,2],
            [3,1,2],
            
            [6,0,1],
            
            [GameModel.HAND_SAW_ID,0,0]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //127
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.EDGE_ID,0,0,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [2,1,5,1],
            [4,2,5,1],
            [3,3,5,1],
            [2,4,5,1],
            
            [3,0,4,1],
            [3,1,4,1],
            [5,2,4,1],
            [3,3,4,1],
            
            [2,0,3,1],
            [6,1,3,1],
            [4,2,3,1],
            
            [3,0,2,1],
            [3,1,2,1],
            
            [6,0,1,1],
            
            [GameModel.HAND_SAW_ID,0,0]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        //128
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.EDGE_ID,0,0,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,3,3,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,0,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [2,1,5,2],
            [4,2,5,2],
            [3,3,5,2],
            [2,4,5,2],
            
            [3,0,4,2],
            [3,1,4,2],
            [5,2,4,2],
            [3,3,4,2],
            
            [2,0,3,2],
            [6,1,3,2],
            [4,2,3,2],
            
            [3,0,2,2],
            [3,1,2,2],
            
            [6,0,1,2],
            
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.FRUIT_BASKET_ID,1,0],
            [GameModel.FRUIT_BASKET_ID,2,0],
            
            ],
                                        goals: [2,0,0,0,0,0,6,5]
        ) )
        
       
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [3,0,3,1],
            [4,1,3,1],
            [5,2,3,1],
            [2,0,4,1],
            [6,1,4,1],
            [1,2,4,1],
            [2,1,5,1],
            [5,2,5,1]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,0,5,1],
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,2,3,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [3,0,3,2],
            [4,1,3,2],
            [5,2,3,2],
            [2,0,4,2],
            [6,1,4,2],
            [1,2,4,2],
            [2,1,5,2],
            [5,2,5,2]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,1,5,1],
            [GameModel.CHOLOLATE_ID,2,5,1],
            [GameModel.CHOLOLATE_ID,3,5,1],
            [GameModel.CHOLOLATE_ID,4,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [1,0,4,1],
            [2,1,4,1],
            [2,2,4,1],
            [4,3,4,1],
            [2,4,4,1],
            [6,5,4,1],
            
            [GameModel.HAND_SAW_ID,0,0]
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,1,5,2],
            [GameModel.CHOLOLATE_ID,2,5,2],
            [GameModel.CHOLOLATE_ID,3,5,2],
            [GameModel.CHOLOLATE_ID,4,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [1,0,4,2],
            [2,1,4,2],
            [2,2,4,2],
            [4,3,4,2],
            [2,4,4,2],
            [6,5,4,2],
            
            [GameModel.HAND_SAW_ID,0,0]
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,1,5,1],
            [GameModel.CHOLOLATE_ID,2,5,1],
            [GameModel.CHOLOLATE_ID,3,5,1],
            [GameModel.CHOLOLATE_ID,4,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,3,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,2,0],
            
            [GameModel.HAND_SAW_ID,0,0]
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,1,5,2],
            [GameModel.CHOLOLATE_ID,2,5,2],
            [GameModel.CHOLOLATE_ID,3,5,2],
            [GameModel.CHOLOLATE_ID,4,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,2,2,0],
            [GameModel.EDGE_ID,3,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,2,0],
            
            [GameModel.HAND_SAW_ID,0,0]
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,4,0],
            
            [2,1,5,1],
            [6,2,5,1],
            [4,3,5,1],
            [5,4,5,1]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,4,0],
            
            [2,1,5,2],
            [6,2,5,2],
            [4,3,5,2],
            [5,4,5,2]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.EDGE_ID,1,1,1],
            [GameModel.EDGE_ID,1,2,1],
            [GameModel.EDGE_ID,1,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,3,1,1],
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,4,0],
            
            [2,1,5,2],
            [6,2,5,2],
            [4,3,5,2],
            [5,4,5,2],
            [4,0,4,2],
            [2,1,4,2],
            [6,2,4,2],
            [4,3,4,2],
            [5,4,4,2],
            [4,5,4,2]
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        

        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,1,5,2],
            [GameModel.CHOLOLATE_ID,2,5,2],
            [GameModel.CHOLOLATE_ID,3,5,2],
            
            [GameModel.CHOLOLATE_ID,0,4,2],
            [GameModel.CHOLOLATE_ID,1,4,2],
            [GameModel.CHOLOLATE_ID,2,4,2],
            [GameModel.CHOLOLATE_ID,3,4,2],
            
            [GameModel.CHOLOLATE_ID,0,3,2],
            [GameModel.CHOLOLATE_ID,1,3,2],
            [GameModel.CHOLOLATE_ID,2,3,2],
            [GameModel.CHOLOLATE_ID,3,3,2],
            
            [GameModel.CHOLOLATE_ID,0,2,2],
            [GameModel.CHOLOLATE_ID,1,2,2],
            [GameModel.CHOLOLATE_ID,2,2,2],
            [GameModel.CHOLOLATE_ID,3,2,2],
            
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,2,1,0],
            [GameModel.EDGE_ID,3,1,0],
            
            [GameModel.EDGE_ID,3,2,1],
            [GameModel.EDGE_ID,3,3,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,3,5,1],
            
            [GameModel.HAND_SAW_ID,0,0],
            [GameModel.FRUIT_BASKET_ID,1,0],
            [GameModel.FRUIT_BASKET_ID,2,0]
            ],
                                        goals: [16,0,0,0,0,0,6,4]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,0,4,2],
            [GameModel.CHOLOLATE_ID,0,3,2],
            [GameModel.CHOLOLATE_ID,0,2,2],
            [GameModel.CHOLOLATE_ID,0,1,2],
            
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.CHOLOLATE_ID,5,4,2],
            [GameModel.CHOLOLATE_ID,5,3,2],
            [GameModel.CHOLOLATE_ID,5,2,2],
            [GameModel.CHOLOLATE_ID,5,1,2],
            
            [GameModel.EDGE_ID,0,4,0],
            [GameModel.EDGE_ID,1,4,0],
            [GameModel.EDGE_ID,4,4,0],
            [GameModel.EDGE_ID,5,4,0],
            
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,3,0],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,2,0],
            
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,1,1,0],
            [GameModel.EDGE_ID,4,1,0],
            [GameModel.EDGE_ID,5,1,0],
            
            [GameModel.EDGE_ID,0,0,0],
            [GameModel.EDGE_ID,1,0,0],
            [GameModel.EDGE_ID,4,0,0],
            [GameModel.EDGE_ID,5,0,0]
            
            ],
                                        goals: [10,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,1,3,0],
            [GameModel.EDGE_ID,2,4,0],
            [GameModel.EDGE_ID,3,4,0],
            [GameModel.EDGE_ID,4,3,0],
            [GameModel.EDGE_ID,5,2,0],
            
            [GameModel.EDGE_ID,0,3,1],
            [GameModel.EDGE_ID,1,4,1],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,4,1],
            [GameModel.EDGE_ID,4,3,1],
            
            [1,1,5,2],
            [3,2,5,2],
            [4,3,5,2],
            [2,4,5,2],
            
            [4,0,4,2],
            [6,1,4,2],
            [2,2,4,2],
            [1,3,4,2],
            [3,4,4,2],
            [4,5,4,2],
            
            [2,0,3,2],
            [4,1,3,2],
            [1,2,3,2],
            [1,3,3,2],
            [4,4,3,2],
            [6,5,3,2],
            
            [GameModel.HAND_SAW_ID,0,0,1]
            
            ],
                                        goals: [2,0,0,0,0,0,6,0]
        ) )
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,1],
            [GameModel.CHOLOLATE_ID,5,5,1],
            [GameModel.CHOLOLATE_ID,1,5,1],
            [GameModel.CHOLOLATE_ID,4,5,1],
            [GameModel.CHOLOLATE_ID,2,5,1],
            [GameModel.CHOLOLATE_ID,3,5,1],
            
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,1,0],
            [GameModel.EDGE_ID,5,2,0],
            [GameModel.EDGE_ID,5,3,0],
            
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,2,0,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,2,1,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,5,1],
            
            
            [1,0,4,1],
            [1,1,4,1],
            [1,2,4,1],
            [1,3,4,1],
            [1,4,4,1],
            [1,5,4,1],
            [1,1,0],
            [1,2,0],
            [1,3,0],
            [1,4,0]
            
            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        
        gameSamples.append( GameSample( fruits:[
            [GameModel.CHOLOLATE_ID,0,5,2],
            [GameModel.CHOLOLATE_ID,5,5,2],
            [GameModel.CHOLOLATE_ID,1,5,2],
            [GameModel.CHOLOLATE_ID,4,5,2],
            [GameModel.CHOLOLATE_ID,2,5,2],
            [GameModel.CHOLOLATE_ID,3,5,2],
            
            [GameModel.EDGE_ID,0,1,0],
            [GameModel.EDGE_ID,0,2,0],
            [GameModel.EDGE_ID,0,3,0],
            [GameModel.EDGE_ID,1,2,0],
            [GameModel.EDGE_ID,4,2,0],
            [GameModel.EDGE_ID,5,1,0],
            [GameModel.EDGE_ID,5,2,0],
            [GameModel.EDGE_ID,5,3,0],
            
            [GameModel.EDGE_ID,1,0,1],
            [GameModel.EDGE_ID,2,0,1],
            [GameModel.EDGE_ID,3,0,1],
            [GameModel.EDGE_ID,2,1,1],
            [GameModel.EDGE_ID,2,4,1],
            [GameModel.EDGE_ID,1,5,1],
            [GameModel.EDGE_ID,2,5,1],
            [GameModel.EDGE_ID,3,5,1],
            
            
            [1,0,4,2],
            [1,1,4,2],
            [1,2,4,2],
            [1,3,4,2],
            [1,4,4,2],
            [1,5,4,2],
  
            [1,1,0],
            [1,2,0],
            [1,3,0],
            [1,4,0]

            ],
                                        goals: [6,0,0,0,0,0,6,0]
        ) )
        
        
        FindFirstLevels()
        
            print ("There are \(gameSamples.count) samples")
        
    }
}
