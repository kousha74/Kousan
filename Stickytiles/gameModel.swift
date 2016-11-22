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
    var gameItems = [[Int]]()
    
    init( localArr: [[Int]]) {
        gameItems = localArr
    }
}

class GameModel {
    
    private var currentLevel:Int = 0
    
    private var maxLevelCompleted:Int = -1
    
    static let maxLevel:Int = 49
    
    static let delay = 0.35
    
    private var label : SKLabelNode?
    
    private var gameSamples : [GameSample]
    
    private var cellSize : Int = 50
    
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
    
    private let COLOR_COUNT = 6
    
    let boardSize : Int = 6
    
    func OnProductPurchased( productID: String ) {
        if ( productID == StickyTilesProducts.removeAds ){
            userDefaults.set( 1, forKey: "removeAds")
        }
    }
    
    func IsProductPurchased( productID: String )->Bool{
        
        if ( productID == StickyTilesProducts.removeAds ){
            return ( userDefaults.integer(forKey: "removeAds") != 0 )
        }

        return false
    }
    
    func AreAdsAvailable()->Bool{
        return ( userDefaults.integer(forKey: "removeAds") == 0 ) && ( currentLevel > 10 )
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
    
    func loadGame( level:Int)
    {
        for tile in gameTiles{
            allTiles.append(tile)
        }
        
        gameTiles.removeAll()
        
        let getSample = gameSamples[level]
        
        for index in 0...(getSample.gameItems.count-1){
            let tile = GetEmptyTile()
            
            let gameItem = getSample.gameItems[ index ]
            
            tile.SetID(Id:gameItem[0])
            
            tile.SetRowAndCol(row: gameItem[2], col: gameItem[1], cellSize: cellSize, viewOffset: viewOffset)
            
            gameTiles.append(tile)
            tile.sprite?.alpha = 1.0
        }
    }
    
    func AddTile()->TileNode?{
        //First find an empty tile
        let tile = GetEmptyTile()
        
        if let emptyCell = FindEmptyCell(){
            
            //TBD
            // +2 for bubble and chocolate
            var Id = Int(arc4random_uniform(UInt32(COLOR_COUNT+2))) + 1
            
            if ( Id == COLOR_COUNT + 1 ){
                Id = 10
            }
            
            if ( Id == COLOR_COUNT + 2 ){
                Id = 13
            }
            
            tile.SetID(Id: Id)
            tile.SetRowAndCol(row: Int(emptyCell.y), col: Int(emptyCell.x), cellSize: cellSize, viewOffset: viewOffset)
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
    
    func GetEmptyTile()->TileNode{
        let tile = allTiles[0]
        
        allTiles.remove(at: 0)
        
        tile.Reset()
        
        return tile
    }
    
    func reloadGame(){
    }
    
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
        
        for i in 0...gameTiles.count-1{
            if ( gameTiles[i] === tile ){
                gameTiles.remove(at: i)
                allTiles.append(tile)
                break
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
        
            //[id,x,y,sizex,sizey,locked]
        
            // 1-5
            /*gameSamples.append( GameSample( localArr:[[1,0,1,1,1,0],[1,0,2,1,1,0],[1,0,3,1,1,0],[1,0,4,1,1,0],[1,0,5,1,1,0],[1,1,0,1,1,0]]) )
        
            gameSamples.append( GameSample( localArr:[[2,0,0,1,1,0],[1,0,1,1,1,0],[1,0,2,1,1,0],[1,0,3,1,1,0],[1,0,4,1,1,0],[1,0,5,1,1,0],[1,1,0,1,1,0],[2,1,1,1,1,0],[2,1,2,1,1,0],[2,1,3,1,1,0],[2,1,4,1,1,0],[2,1,5,1,1,0]]) )
            gameSamples.append( GameSample( localArr:[[2,0,0,1,1,0],[1,0,1,1,1,0],[1,0,2,1,1,0],[1,0,3,1,1,0],[1,0,4,1,1,0],[1,0,5,1,1,0],[1,5,0,1,1,0],[2,5,1,1,1,0],[2,5,2,1,1,0],[2,5,3,1,1,0],[2,5,4,1,1,0],[2,5,5,1,1,0]]) )
            gameSamples.append( GameSample( localArr:[[2,0,0,1,1,0],[1,0,1,1,1,0],[1,0,2,1,1,0],[1,0,3,1,1,0],[1,0,4,1,1,0],[1,0,5,1,1,0],[1,2,0,1,1,0],[2,2,1,1,1,0],[2,2,2,1,1,0],[2,2,3,1,1,0],[2,2,4,1,1,0],[2,2,5,1,1,0]]) )*/
            gameSamples.append( GameSample( localArr:[[3,0,0,1,1,0],[1,0,1,1,1,0],[1,0,2,1,1,0],[1,0,3,1,1,0],[1,0,4,1,1,0],[1,0,5,1,1,0],[1,1,0,1,1,0],[2,1,1,1,1,0],[2,1,2,1,1,0],[2,1,3,1,1,0],[2,1,4,1,1,0],[2,1,5,1,1,0],[2,2,0,1,1,0],[3,2,1,1,1,0],[3,2,2,1,1,0],[15,2,3,1,1,0],[3,3,4,1,1,0],[3,3,5,1,1,0]]) )
        
            // 6-10
            /*gameSamples.append( GameSample( localArr:[[2,1,0,1,1,0],[2,1,1,1,1,0],[2,1,2,1,1,0],[2,1,3,1,1,0],[2,1,4,1,1,0],[2,1,5,1,1,0],[4,3,3,1,1,0],[4,3,4,1,1,0],[4,3,5,1,1,0],[4,4,0,1,1,0],[4,3,1,1,1,0],[4,3,2,1,1,0],[3,5,0,1,1,0],[3,5,1,1,1,0],[3,5,2,1,1,0],[3,5,3,1,1,0],[3,5,4,1,1,0],[3,5,5,1,1,0]]) )*/
            gameSamples.append( GameSample( localArr:[[2,0,0,1,1,0],[1,0,1,1,1,0],[1,0,2,1,1,0],[1,0,3,1,1,0],[1,0,4,1,1,0],[1,0,5,1,1,0],[1,2,0,1,1,0],[2,2,1,1,1,0],[2,2,2,1,1,0],[2,2,3,1,1,0],[2,2,4,1,1,0],[2,2,5,1,1,0],[3,5,0,1,1,0],[3,5,1,1,1,0],[3,5,2,1,1,0],[3,5,3,1,1,0],[3,5,4,1,1,0],[3,5,5,1,1,0]]) )
            /*gameSamples.append( GameSample( localArr:[[1,0,0,1,1,0],[1,1,1,1,1,0],[1,0,2,1,1,0],[1,1,3,1,1,0],[1,0,4,1,1,0],[1,1,5,1,1,0],[2,0,1,1,1,0],[2,0,3,1,1,0],[2,0,5,1,1,0],[2,1,0,1,1,0],[2,1,2,1,1,0],[2,1,4,1,1,0]]) )
            gameSamples.append( GameSample( localArr:[[3,0,0,1,1,0],[3,0,1,1,1,0],[1,0,2,1,1,0],[1,0,3,1,1,0],[1,0,4,1,1,0],[1,0,5,1,1,0],[1,2,0,1,1,0],[2,1,1,1,1,0],[2,1,2,1,1,0],[2,1,3,1,1,0],[2,1,4,1,1,0],[2,1,5,1,1,0],[2,1,0,1,1,0],[1,2,1,1,1,0],[3,2,2,1,1,0],[3,2,3,1,1,0],[3,2,4,1,1,0],[3,2,5,1,1,0]]) )*/
            gameSamples.append( GameSample( localArr:[
                [1,0,0,1,1,0],
                [1,0,1,1,1,0],
                [1,0,2,1,1,0],
                [1,0,3,1,1,0],
                
                [2,1,0,1,1,0],
                [2,1,1,1,1,0],
                [2,1,2,1,1,0],
                [2,1,3,1,1,0],
                
                [4,3,0,1,1,0],
                [4,3,1,1,1,0],
                [4,3,2,1,1,0],
                [4,3,3,1,1,0],
                
                [3,2,0,1,1,0],
                [3,2,1,1,1,0],
                [3,2,2,1,1,0],
                [3,2,3,1,1,0]
                ]) )
        
        
            print ("There are \(gameSamples.count) samples")
        
    }
}
