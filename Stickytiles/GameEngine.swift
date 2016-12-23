//
//  GameEngine.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/29/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameEngine {
    
    enum Direction {
        case Up, Down, Right, Left, None
    }
    
    class var sharedInstance: GameEngine {
        struct Static {
            static let instance: GameEngine = GameEngine()
        }
        return Static.instance
    }
    
    private init() {
        m_move_direction = MOVE_DIRECTION_NONE
        explosions.append(SKTexture(imageNamed: "6.png"))
        explosions.append(SKTexture(imageNamed: "7.png"))
        explosions.append(SKTexture(imageNamed: "8.png"))
        explosions.append(SKTexture(imageNamed: "9.png"))
        explosions.append(SKTexture(imageNamed: "10.png"))
        explosions.append(SKTexture(imageNamed: "11.png"))
    }
    
    var m_direction: Direction = .None
    
    private var m_GameSceneProtocol:GameSceneProtocol?
    
    private var isProcessing = false
    
    private var shouldAddTile = false
    
    static let MIN_CLUSTER_SIZE = 3
    
    var isDemo = false
    
    // MARK : Constants
    let MOVE_DIRECTION_NONE:Int = 0
    let MOVE_DIRECTION_HORIZONTAL:Int = 1
    let MOVE_DIRECTION_VERTICAL:Int = 2
    let MOVE_DETECTION_PIXELS:Int =	20
    
    let DIRECTION_UP:Int = 0
    let DIRECTION_DOWN:Int = 1
    let DIRECTION_LEFT:Int = 2
    let DIRECTION_RIGHT:Int = 3
    
    // MARK : member variables
    var gameModel = GameModel.sharedInstance
    var dragging = false
    var touchPos = CGPoint(x: 0, y: 0)
    var currentPos = CGPoint(x: 0, y: 0)
    var touchedCell = CGPoint(x: 0, y: 0)
    var m_move_direction:Int
    var m_upper_bound:CGFloat = 0
    var m_lower_bound:CGFloat = 0
    var direction_vector = [ CGPoint(x: 0, y: 1), CGPoint(x: 0, y: -1), CGPoint(x: -1, y: 0), CGPoint(x: 1, y: 0)];
    let isStickyOn = true
    
    var explosions = [SKTexture]()
    
    func SetParent( parent: GameSceneProtocol )
    {
        m_GameSceneProtocol = parent
    }
    
    func LoadGame( level:Int ){
        m_move_direction = MOVE_DIRECTION_NONE
        dragging = false
        isProcessing = false
        gameModel.loadGame(level: level)
        
        for tile in gameModel.GetTiles(){
            m_GameSceneProtocol?.onAddChild(child: tile.sprite!)
        }
        
        for edge in gameModel.GetEdges(){
            m_GameSceneProtocol?.onAddChild(child: edge.sprite)
        }
    
        if gameModel.GetTileCount() < gameModel.MIN_TILES {
            //Adding random tiles to make sure there are enough tiles
            AddTiles()
        }
        
        m_GameSceneProtocol?.UpdateLabels()
        m_GameSceneProtocol?.OnGameLoaded()
    }
    
    func OnTouch(pos:CGPoint){
        
        touchPos.x = pos.x
        touchPos.y = pos.y
        
        if !isProcessing && !dragging
        {
            dragging = true
        }
    }
    
    func IsWon()->Bool{
        
        if gameModel.FindCoveredTile() != nil{
            return false
        }
        
        //check chocolates
        if gameModel.targetChocolates != 0 {
            if gameModel.targetChocolates == gameModel.chRemoved {
                return true
            }
        }
        //check target score
        else if gameModel.targetScore != 0 {
            if gameModel.targetScore <= gameModel.score {
                return true
            }
        }
        //check target apples
        else if gameModel.targetApples != 0 {
            if gameModel.targetApples <= gameModel.applesRemoved {
                return true
            }
        }
        //check target Special
        else if gameModel.targetSpecials != 0 {
            if gameModel.targetSpecials <= gameModel.specialsRemoved {
                return true
            }
        }
        //check target stars
        else if gameModel.targetStars != 0 {
            if gameModel.targetStars <= gameModel.starsRemoved {
                return true
            }
        }
        else {
            //the only choice is covered ones which is already covered
            return true
        }
        
        return false
    }
    
    func IsLost()->Bool{
        return gameModel.IsLost()
    }
    
    func OnUpdate( currentTime: TimeInterval ){
    }
    
    func OnDrag(pos:CGPoint){
        return
    }
    
    @objc func PushAgainstTheWall()
    {
        print("Pushing aganist the wall")
        let boardSize = gameModel.boardSize
        
        var targetRow:Int = 0
        var targetCol:Int = 0
        var pos:CGPoint = CGPoint(x:0,y:0)
        
        //Remove locks
        gameModel.SetFlag(flag: TileNode.IS_LOCKED, isSet: false)
        
        switch ( m_direction ) {
        case .Right:
            for row in 0...boardSize-1{
                targetRow = row
                targetCol = boardSize-1
                for col in (0...boardSize-1).reversed()
                {
                    pos.x = CGFloat(col)
                    pos.y = CGFloat(row)
                    
                    if gameModel.FindEdge(pos: pos, isHorizontal: false){
                        targetCol = col
                    }

                    if let touchedTile = gameModel.GetTile(pos: pos) {
                        if !touchedTile.CanMove(){
                            targetCol = touchedTile.GetCol() - 1
                        }
                        else{
                            touchedTile.Moveto(
                                delta_row: targetRow,
                                delta_col: targetCol,
                                cellSize: CGFloat(gameModel.GetCellSize()),
                                viewOffset: gameModel.GetViewOffset())
                            targetCol -= 1
                        }
                    }
                }
            }
            break
            
        case .Left:
            for row in 0...boardSize-1{
                targetCol = 0
                targetRow = row
                for col in 0...boardSize-1
                {
                    pos.x = CGFloat(col)
                    pos.y = CGFloat(row)
                    
                    if let touchedTile = gameModel.GetTile(pos: pos){
                        if !touchedTile.CanMove(){
                            targetCol = touchedTile.GetCol() + 1
                        }
                        else{
                            touchedTile.Moveto(
                                delta_row: targetRow,
                                delta_col: targetCol,
                                cellSize: CGFloat(gameModel.GetCellSize()),
                                viewOffset: gameModel.GetViewOffset())
                            targetCol += 1
                        }
                    }
                    
                    if gameModel.FindEdge(pos: pos, isHorizontal: false){
                        targetCol = col + 1
                    }

                }
            }
            break
            
        case .Up:
            for col in 0...boardSize-1{
                targetCol = col
                targetRow = boardSize-1
                for row in (0...boardSize-1).reversed()
                {
                    pos.x = CGFloat(col)
                    pos.y = CGFloat(row)
                    
                    if gameModel.FindEdge(pos: pos, isHorizontal: true){
                        targetRow = row
                    }
                    
                    if let touchedTile = gameModel.GetTile(pos: pos){
                        if !touchedTile.CanMove(){
                            targetRow = touchedTile.GetRow() - 1
                        }
                        else{
                            touchedTile.Moveto(
                                delta_row: targetRow,
                                delta_col: targetCol,
                                cellSize: CGFloat(gameModel.GetCellSize()),
                                viewOffset: gameModel.GetViewOffset())
                            targetRow -= 1
                        }
                    }
                }
            }
            break
            
        case .Down:
            for col in 0...boardSize-1{
                targetCol = col
                targetRow = 0
                for row in 0...boardSize-1
                {
                    pos.x = CGFloat(col)
                    pos.y = CGFloat(row)
                    
                    if let touchedTile = gameModel.GetTile(pos: pos) {
                        
                        if !touchedTile.CanMove(){
                            targetRow = touchedTile.GetRow() + 1
                        }
                        else{
                        
                            touchedTile.Moveto(
                                delta_row: targetRow,
                                delta_col: targetCol,
                                cellSize: CGFloat(gameModel.GetCellSize()),
                                viewOffset: gameModel.GetViewOffset())
                            targetRow += 1
                        }
                    }
                    
                    if gameModel.FindEdge(pos: pos, isHorizontal: true){
                        targetRow = row + 1
                    }

                }
            }
            break
            
        default:
            break
        }
        
        if !isDemo {
            Timer.scheduledTimer(timeInterval: TimeInterval( ( m_direction != .None ) ? GameModel.delay : 0.0 ), target: self, selector:#selector(GameEngine.FindClusters), userInfo: nil, repeats: false)
        }
    }
    
    func GetDirection( touchPos:CGPoint, releasePos:CGPoint)->Direction
    {
        let deltaX = releasePos.x - touchPos.x
        let deltaY = releasePos.y - touchPos.y
        
        if ( abs(deltaX) > abs(deltaY) ){
            //Horizontal Move
            if abs(deltaX) > CGFloat(MOVE_DETECTION_PIXELS) {
                return ( (deltaX > 0) ? .Right : .Left )
            }
            else{
                return .None
            }
            
        }
        else{
            if abs(deltaY) > CGFloat(MOVE_DETECTION_PIXELS) {
                return ( (deltaY > 0) ? .Up : .Down )
            }
            else{
                return .None
            }
        }
    }
    
    func OnRelease(pos:CGPoint){
        
        if  !isProcessing && dragging {
            
            m_direction = GetDirection(touchPos: touchPos, releasePos: pos)
            
            if ( m_direction != .None ) {
                dragging = false
                isProcessing = true
                shouldAddTile = true
                PushAgainstTheWall()
                gameModel.ChangeMoveCount(delta: 1)
                gameModel.Tick()
            }
            else{
                //It's a tap
                dragging = false
                m_direction = .None
                touchedCell.x = floor(( touchPos.x - gameModel.GetViewOffset().x )/CGFloat(gameModel.GetCellSize()) )
                touchedCell.y = floor(( touchPos.y - gameModel.GetViewOffset().y )/CGFloat(gameModel.GetCellSize()) )
                
                if gameModel.IsValidPosition(pos: touchedCell){
                    if let touchedTile = gameModel.GetTile(pos: touchedCell) {
                        
                        //touching covered ones should do nothing
                        if touchedTile.GetCoverCount() == 0 {
                            
                            if !CheckForFruitBasket(tile: touchedTile) {
                                switch touchedTile.GetID() {
                                case TileNode.STAR5_ID:
                                    touchedTile.SetFlag(flag: TileNode.TBP, isSet: true)
                                    isProcessing = true
                                    shouldAddTile = true
                                    MarkSpecialNodes(tile: touchedTile)
                                    Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.ProcessSpecialNodes), userInfo: nil, repeats: false)
                                    gameModel.ChangeMoveCount(delta: 1)
                                    break
                                    
                                case TileNode.STAR7_ID:
                                    touchedTile.SetFlag(flag: TileNode.TBP, isSet: true)
                                    isProcessing = true
                                    shouldAddTile = true
                                    MarkSpecialNodes(tile: touchedTile)
                                    Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.ProcessSpecialNodes), userInfo: nil, repeats: false)
                                    gameModel.ChangeMoveCount(delta: 1)
                                    break
                                
                                case TileNode.BLOCKER_ID: //touching a blocker removes it
                                    DeleteTile(tile: touchedTile)
                                    break
                                    
                                case TileNode.BUBBLE_ID: //pop the balloon
                                    gameModel.SoundWave()
                                    DeleteTile(tile: touchedTile)
                                    //balloon is not a move
                                    //gameModel.ChangeMoveCount(delta: 1)
                                    break
                                    
                                case TileNode.FRUIT_BASKET_ID:
                                    OnFruitBasketTouched( tile: touchedTile)
                                    break
                                
                                case TileNode.BOMB_ID:
                                    touchedTile.SetFlag(flag: TileNode.TBP, isSet: true)
                                    isProcessing = true
                                    shouldAddTile = true
                                    Timer.scheduledTimer(timeInterval: TimeInterval( 0.0 ), target: self, selector:#selector(GameEngine.ProcessSpecialNodes), userInfo: nil, repeats: false)
                                    gameModel.ChangeMoveCount(delta: 1)
                                    break
                                    
                                case TileNode.HAND_SAW_ID:
                                    //gameModel.SoundWoodCut()
                                    break

                                default:
                                    break
                                }
                            }
                        }
                    }
                    else{
                        GameModel.blokerUsed = true
                        RemoveBlockers() //At most one blocker is allowed
                        AddTile(id: TileNode.BLOCKER_ID, pos: touchedCell)
                        //gameModel.ChangeMoveCount(delta: 1)
                    }
                }
            }
        }
    }
    
    @objc func FindClusters(){
        
        var clusterFound = false
        
        var specialClusterFound = false
        
        if ( gameModel.GetTileCount() > 0){
            
            // reset the visited flag
            gameModel.SetFlag(flag: TileNode.IS_VISITED, isSet: false)
            
            var gameTiles = [TileNode]()
            
            for tile in gameModel.GetGameTiles(){
                gameTiles.append(tile)
            }
            
            for tile in gameTiles{
                if ( !tile.GetFlag(flag: TileNode.IS_VISITED))
                {
                    let cluster = FindClusterAtTile(tile: tile)
                    
                    if ( cluster.count >= GameEngine.MIN_CLUSTER_SIZE )
                    {
                        var clusterType = GetClusterType(cluster: cluster)
                        
                        for tile2 in cluster{
                            
                            if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                                
                                //if the cluster has a special type, then one of the regular tiles must be converted accordingly
                                if ( clusterType != TileNode.ClusterType.None ){
                                    gameModel.SoundChime()
                                    specialClusterFound = true
                                    tile2.SetClusterType(type: clusterType)
                                    //this tile must be locked, so it won't be removed immediately
                                    tile2.SetFlag(flag: TileNode.IS_LOCKED, isSet: true)
                                    
                                    
                                    switch clusterType {
                                    case .Four:
                                        m_GameSceneProtocol?.OnToast(msg: "Power Fruit")
                                        break
                                    case .Row:
                                        m_GameSceneProtocol?.OnToast(msg: "Row Remover")
                                        break
                                    case .Col:
                                        m_GameSceneProtocol?.OnToast(msg: "Column Remover")
                                        break
                                    case .Five:
                                        m_GameSceneProtocol?.OnToast(msg: "Yellow Star")
                                        break
                                    case .Six:
                                        m_GameSceneProtocol?.OnToast(msg: "Green Star")
                                        break
                                    default:
                                        break
                                    }
                                    
                                    clusterType = TileNode.ClusterType.None
                                }
                                else {
                                    DeleteTile(tile: tile2)
                                }
                            }
                            else {
                                tile2.SetFlag(flag: TileNode.TBP, isSet: true)
                            }
                        }
                        
                        clusterFound = true
                    }
                    else{
                        //Checking for cholocates
                        if tile.GetID() == TileNode.CHOLOLATE_ID && tile.GetRow() == 0 {
                            DeleteTile(tile: tile)
                            clusterFound = true
                        }
                    }
                }
            }
        }
        
        let tile2 = gameModel.FindFlag(flag: TileNode.TBP, isSet: true)
        
        if ( clusterFound ) || ( tile2 != nil ) {
            
            if clusterFound {
                m_GameSceneProtocol?.OnToast(msg: "Nice Job!")
            }
            
            if (!specialClusterFound){
                gameModel.SoundWave()
            }
            
            if ( tile2 != nil ){
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.ProcessSpecialNodes), userInfo: nil, repeats: false)
                MarkSpecialNodes( tile: tile2! )
            }
            else{
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.PushAgainstTheWall), userInfo: nil, repeats: false)
            }
        }
        else if ApplySaw(){
            //do nothing
        }
        else if shouldAddTile {
            shouldAddTile = false
            AddTiles()
        }
        else{
            FinalizeProcessing()
        }
    }
    
    func FinalizeProcessing(){
        isProcessing = false
        RemoveBlockers()
        
        if ( IsWon() )
        {
            gameModel.OnGameWon()
            m_GameSceneProtocol?.OnGameWon()
        }
        else if ( IsLost() ){
            m_GameSceneProtocol?.OnGameLost()
        }
        else{
            if ( ( gameModel.AreAdsAvailable() ) && ((gameModel.GetMoveCount()%Constants.adFrequency) == 0 ) && ( gameModel.GetMoveCount() > 0 )){
                Chartboost.showInterstitial(CBLocationHomeScreen)
            }
        }
    }
    
    func RemoveBlockers(){
        //TBD only removes one blocker
        for tile in gameModel.GetTiles(){
            if tile.GetID() == TileNode.BLOCKER_ID {
                DeleteTile(tile: tile)
            }
        }
    }
    
    func SameFruit(tile1:TileNode, tile2:TileNode)->Bool{
        return ( tile1.GetID() == tile2.GetID() ) && ( tile1.IsFruit() )
    }
    
    func DeleteTile(tile:TileNode){
        TileWillBeDeleted(tile: tile)
        gameModel.RemoveTile(tile: tile)
        m_GameSceneProtocol?.UpdateLabels()
        let fadeoutAction = SKAction.fadeOut(withDuration: GameModel.delay)
        let actionMoveDone = SKAction.removeFromParent()
        tile.sprite?.run( SKAction.sequence([fadeoutAction,actionMoveDone]))
    }
    
    func TileWillBeDeleted(tile:TileNode)
    {
        if tile.IsFruit(){
            
            var pos = CGPoint(x: tile.GetCol(), y: tile.GetRow() )
            //tbd consider using an array
            
            pos.x = CGFloat( tile.GetCol() )
            pos.y = CGFloat( tile.GetRow() + 1 )
            if let neighborTile = gameModel.GetTile(pos: pos){
                
                if neighborTile.GetID() == TileNode.QUESTION_ID{
                    neighborTile.SetID(Id: gameModel.GetRandomTileID())
                }
                
                if ( neighborTile.RemoveCoverB() )
                {
                    gameModel.SoundGlass()
                }
            }
            
            pos.x = CGFloat( tile.GetCol() )
            pos.y = CGFloat( tile.GetRow() - 1 )
            if let neighborTile = gameModel.GetTile(pos: pos){
                if neighborTile.GetID() == TileNode.QUESTION_ID{
                    neighborTile.SetID(Id: gameModel.GetRandomTileID())
                }
                
                if ( neighborTile.RemoveCoverB() )
                {
                    gameModel.SoundGlass()
                }
            }
            
            pos.x = CGFloat( tile.GetCol() + 1 )
            pos.y = CGFloat( tile.GetRow() )
            if let neighborTile = gameModel.GetTile(pos: pos){
                if neighborTile.GetID() == TileNode.QUESTION_ID{
                    neighborTile.SetID(Id: gameModel.GetRandomTileID())
                }
                
                if ( neighborTile.RemoveCoverB() )
                {
                    gameModel.SoundGlass()
                }
            }
            
            pos.x = CGFloat( tile.GetCol() - 1 )
            pos.y = CGFloat( tile.GetRow() )
            if let neighborTile = gameModel.GetTile(pos: pos){
                if neighborTile.GetID() == TileNode.QUESTION_ID{
                    neighborTile.SetID(Id: gameModel.GetRandomTileID())
                }
                
                if ( neighborTile.RemoveCoverB() )
                {
                    gameModel.SoundGlass()
                }
            }
        }
    }
        
    func DeleteRow( row:Int ){
        for col in 0...gameModel.boardSize-1{
            
            if let temp = gameModel.GetTile(pos: CGPoint(x:CGFloat(col), y: CGFloat(row))) {
                let tile2 = temp
                tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                TryToDelete(tile: tile2)
            }
        }
    }
    
    func DeleteCol( col:Int ){
        for row in 0...gameModel.boardSize-1{
            
            if let temp = gameModel.GetTile(pos: CGPoint(x:CGFloat(col), y: CGFloat(row))) {
                let tile2 = temp
                tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                TryToDelete(tile: tile2)
            }
        }
    }
    
    func DeleteDiagonally( tile: TileNode ){
        for tile2 in gameModel.GetTiles(){
            let deltaRow = abs( tile.GetRow() - tile2.GetRow() )
            let deltaCol = abs( tile.GetCol() - tile2.GetCol() )
            if deltaRow == deltaCol{
                tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                TryToDelete(tile: tile2)
            }
        }
    }
    
    func TryToDelete( tile:TileNode ){
        
        let id = tile.GetID()
        
        if id != TileNode.BLOCKED_ID && id != TileNode.BLOCKER_ID && id != TileNode.CHOLOLATE_ID {
            if !tile.GetFlag(flag: TileNode.IS_LOCKED) {
                if  !tile.RemoveCoverB() {
                    if ( tile.GetClusterType() == TileNode.ClusterType.None ){
                        //delete the tile
                        DeleteTile(tile: tile )
                    }
                    else{
                        tile.SetFlag(flag: TileNode.TBP, isSet: true)
                    }
                }
                else{
                    gameModel.SoundGlass()
                }
            }
        }
    }
    
    @objc func ProcessSpecialNodes(){
        
        if let tile = gameModel.FindFlag(flag: TileNode.TBP, isSet: true){
            
            let clusterType = tile.GetClusterType()
            
            switch ( clusterType ){
            case .Row:
                DeleteRow(row: tile.GetRow() )
                break
                
            case .Col:
                DeleteCol(col: tile.GetCol())
                break
                
            case .Four:
                for tile2 in gameModel.GetTiles(){
                    // Deleting all the tiles with the same color
                    // If the tile is LOCKED, do not remove it
                    /*if SameFruit(tile1: tile, tile2: tile2){
                        
                        tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                        
                        TryToDelete(tile: tile2)
                    }*/
                    let rowDiff = abs( tile.GetRow() - tile2.GetRow() )
                    let colDiff = abs( tile.GetCol() - tile2.GetCol() )
                    
                    if rowDiff == 1 && colDiff == 1 {
                        tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                        TryToDelete(tile: tile2)
                    }
                }
                break
                
            case .Five:
                DeleteRow(row: tile.GetRow() )
                DeleteCol(col: tile.GetCol() )
                break;
                
            case .Six:
                DeleteRow(row: tile.GetRow() )
                DeleteCol(col: tile.GetCol() )
                DeleteDiagonally(tile: tile)
                break;
                
            case .Bomb:
                gameModel.SoundExplosion()
                OnBombTouched(bombTile: tile)
                break
                
            default:
                break
            }
            
            tile.SetFlag(flag: TileNode.TBP, isSet: false)
            DeleteTile(tile: tile )
            
            if tile.GetClusterType() != .Bomb {

                if m_direction == .None {
                    m_direction = .Down
                }
            
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.PushAgainstTheWall), userInfo: nil, repeats: false)
            }
                
        }
    }

    func MarkSpecialNodes(tile:TileNode){
        
        let clusterType = tile.GetClusterType()
        
        switch ( clusterType ){
        case .Row:
            AddTempLine(row1: tile.GetRow(), col1: 0, row2: tile.GetRow(), col2: gameModel.boardSize-1 )
            gameModel.SoundLaser()
            break
            
        case .Col:
            AddTempLine(row1: 0, col1: tile.GetCol(), row2: gameModel.boardSize-1, col2: tile.GetCol() )
            gameModel.SoundLaser()
            break
            
        case .Four:
            /*var tileFound = false
            for tile2 in gameModel.GetTiles(){
                
                if SameFruit(tile1: tile, tile2: tile2 ){
                    if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                        AddTempLine(row1: tile.GetRow(), col1: tile.GetCol(), row2: tile2.GetRow(), col2: tile2.GetCol() )
                        tileFound = true
                    }
                }
            }
            
            if tileFound{
                gameModel.SoundLaser()
            }*/
            let row1 = tile.GetRow() + 1
            var col1 = tile.GetCol() - 1
            let row2 = tile.GetRow() - 1
            var col2 = tile.GetCol() + 1
            AddTempLine(row1: row1, col1: col1, row2: row2, col2: col2 )
            
            col2 = tile.GetCol() - 1
            col1 = tile.GetCol() + 1
            AddTempLine(row1: row1, col1: col1, row2: row2, col2: col2 )
            
            gameModel.SoundLaser()
            
            break
            
        case .Five:
            AddTempLine(row1: tile.GetRow(), col1: 0, row2: tile.GetRow(), col2: gameModel.boardSize-1 )
            AddTempLine(row1: 0, col1: tile.GetCol(), row2: gameModel.boardSize-1, col2: tile.GetCol() )
            gameModel.SoundLaser()
            break
            
        case .Six:
            AddTempLine(row1: tile.GetRow(), col1: 0, row2: tile.GetRow(), col2: gameModel.boardSize-1 )
            AddTempLine(row1: 0, col1: tile.GetCol(), row2: gameModel.boardSize-1, col2: tile.GetCol() )
            var row1: Int = 0
            var col1: Int = 0
            var row2: Int = 0
            var col2: Int = 0
            
            if ( tile.GetCol() > tile.GetRow() ){
                row1 = 0
                col1 = tile.GetCol() - tile.GetRow()
                
                let delta = gameModel.boardSize - 1 - col1
                
                row2 = row1 + delta
                col2 = col1 + delta
            }
            else{
                row1 = tile.GetRow() - tile.GetCol()
                col1 = 0
                
                let delta = gameModel.boardSize - 1 - row1
                
                row2 = row1 + delta
                col2 = col1 + delta
            }
            AddTempLine(row1: row1, col1: col1, row2: row2, col2: col2)
            
            for index in 0...gameModel.boardSize{
                row1 = tile.GetRow() + index
                col1 = tile.GetCol() - index
                
                if ( row1 == gameModel.boardSize - 1 ) || ( col1 == 0 ){
                    break
                }
            }
            
            for index in 0...gameModel.boardSize{
                row2 = tile.GetRow() - index
                col2 = tile.GetCol() + index
                
                if ( row2 == 0 ) || ( col2 == gameModel.boardSize - 1 ){
                    break
                }
            }
            AddTempLine(row1: row1, col1: col1, row2: row2, col2: col2)
            gameModel.SoundLaser()
            
            
        default:
            break
        }
    }

    func AddTiles(){
        
        let fadeinAction = SKAction.fadeIn(withDuration: GameModel.delay/2.0 )

        for tile in gameModel.AddTiles() {
            m_GameSceneProtocol?.onNewTile(tile: tile)
            tile.sprite?.alpha = 0.0
            tile.sprite?.run( fadeinAction )
        }

        Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.FindClusters), userInfo: nil, repeats: false)
    }
    
    
    func AddTile(id: Int, pos:CGPoint){
        if AddTile2(id: id, pos: pos) != nil {
            //nothing to do
        }
    }

    func AddTile2(id: Int, pos:CGPoint)->TileNode?{
        if let tile = gameModel.AddTile(id: id, pos: pos) {
            m_GameSceneProtocol?.onNewTile(tile: tile)
            tile.sprite?.alpha = 0.0
            tile.sprite?.run( SKAction.fadeIn(withDuration: GameModel.delay ) )
            return tile
        }
        
        return nil
    }

    
    func GetClusterType(cluster:[TileNode])->TileNode.ClusterType{
        
        switch (cluster.count){
        case 0:
            return .None
        case 1:
            return .None
        case 2:
            return .None
        case 3:
            return .None
            
        case 4:
            //check if all in the same row
            let row = Int(cluster[0].pos.y)
            
            if ( row == Int(cluster[1].pos.y )) && ( row == Int(cluster[2].pos.y ) ) && ( row == Int(cluster[3].pos.y ) ) {
                return .Row
            }
            
            //check if all in the same column
            let col = Int(cluster[0].pos.x)
            
            if ( col == Int(cluster[1].pos.x )) && ( col == Int(cluster[2].pos.x ) ) && ( col == Int(cluster[3].pos.x ) ) {
                return .Col
            }
            
            return .Four
        
        case 5:
            return .Five
            
        case 6:
            return .Six
            
        default:
            return .Six
        
        }
    }
    
    func FindClusterAtTile( tile:TileNode )->[TileNode]{
        
        var cluster = [TileNode]()
        var queue = [TileNode]()
        
        tile.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
        cluster.append(tile)
        queue.append(tile)
        
        // special tiles don't form a cluster
        // covered tiles don't form a cluster
        if ( tile.GetID() < TileNode.BUBBLE_ID ) && (tile.GetCoverCount() == 0) {
            var newTilePos = CGPoint(x: 0, y: 0)
            
            while ( !queue.isEmpty )
            {
                let currentTile = queue[0]
                queue.remove(at: 0)
                
                for pos in direction_vector {
                    
                    newTilePos.x = currentTile.pos.x + pos.x
                    newTilePos.y = currentTile.pos.y + pos.y
                
                    if let newTile = gameModel.GetTile(pos: newTilePos){
                        if ( !newTile.GetFlag(flag: TileNode.IS_VISITED ) ) && ( newTile.GetCoverCount() == 0 ) && ( SameFruit(tile1: tile, tile2: newTile) ){
                            newTile.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                            cluster.append(newTile)
                            queue.append(newTile)
                        }
                    }
                }
            }
        }
        
        return cluster
    }
    
    func AddTempLine( row1:Int, col1:Int, row2: Int, col2:Int ){
        
        let A = gameModel.GetCellCenter(row: row1, col: col1)
        let B = gameModel.GetCellCenter(row: row2, col: col2)
        
        let path = CGMutablePath()
        path.move(to: A)
        path.addLine(to: B)
        
        let shape = SKShapeNode()
        shape.path = path
        shape.strokeColor = UIColor.darkGray
        shape.lineWidth = 5
        shape.zPosition = Constants.popupZIndex
        m_GameSceneProtocol?.onAddChild(child: shape)
        
        let fadeoutAction = SKAction.fadeOut(withDuration: GameModel.delay )
        let removeAction = SKAction.removeFromParent()
        shape.run(SKAction.sequence([ fadeoutAction, removeAction]))
    }
    
    func OnFruitBasketTouched( tile : TileNode ){
        
        if let selectedTile = gameModel.FindFlag(flag: TileNode.IS_SELECTED, isSet: true) {
            //we have found one
            selectedTile.SetFlag(flag: TileNode.IS_SELECTED, isSet: false)
            selectedTile.sprite?.removeAllActions()
        }
        else {
            tile.SetFlag(flag: TileNode.IS_SELECTED, isSet: true)
            let scaleUp = SKAction.scale(to: 1.15, duration: GameModel.delay)
            let scaleDown = SKAction.scale(to: 1.0, duration: GameModel.delay)
            tile.sprite?.run(SKAction.repeatForever(SKAction.sequence([scaleUp,scaleDown])))
        }
    }
    
    //gets called on tap
    //return true if fruit basket change has been made
    //input: touched tile
    func CheckForFruitBasket( tile: TileNode )->Bool{
        if tile.IsFruit(){
            if let touchedBasket = gameModel.FindFlag(flag: TileNode.IS_SELECTED, isSet: true){
                touchedBasket.Reset()
                touchedBasket.SetID(Id: tile.GetID())
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.PushAgainstTheWall), userInfo: nil, repeats: false)
                return true
            }
        }
        
        return false
    }
    
    func OnBombTouched( bombTile: TileNode){
        //add explosion
        let explosionNode = SKSpriteNode(texture: explosions[0])
        explosionNode.zPosition = 1
        explosionNode.position.x = Constants.cellSize*CGFloat(bombTile.GetCol()) + gameModel.GetViewOffset().x + Constants.cellSize/2
        explosionNode.position.y = Constants.cellSize*CGFloat(bombTile.GetRow()) + gameModel.GetViewOffset().y + Constants.cellSize/2
        
        m_GameSceneProtocol?.onAddChild(child: explosionNode)
        
        let scaleAction = SKAction.scale(by: 0.75, duration: 0.0)
        let explosionAction = SKAction.animate(with: explosions, timePerFrame: 0.25 )
        let remove = SKAction.removeFromParent()
        let doneAction = SKAction.run {
            self.PushAgainstTheWall()
        }
        explosionNode.run(SKAction.sequence([scaleAction,explosionAction,remove,doneAction]))
        
        //Deleting Fruits
        for row in -1...1{
            for col in -1...1{
                if let tile = gameModel.GetTile(row: bombTile.GetRow() + row, col: bombTile.GetCol() + col){
                    if ( tile.GetClusterType() == TileNode.ClusterType.None ){
                        //delete the tile
                        DeleteTile(tile: tile )
                    }
                    else{
                        tile.SetFlag(flag: TileNode.TBP, isSet: true)
                    }
                }
            }
        }
        
        //Deleting Bamboo Horizontal
        for row in -1...0{
            for col in -1...1{
                gameModel.RemoveBamboo(row:bombTile.GetRow() + row, col: bombTile.GetCol() + col, isHorizontal: true)
            }
        }
        
        //Deleting Bamboo Vertical
        for row in -1...1{
            for col in -1...0{
                gameModel.RemoveBamboo(row:bombTile.GetRow() + row, col: bombTile.GetCol() + col, isHorizontal: false)
            }
        }
    }
    
    func ApplySaw()->Bool{
        var sawApplied = false
        
        for tile in gameModel.GetTiles() {
            
            if tile.GetID() == TileNode.HAND_SAW_ID && tile.GetCoverCount() == 0{
                
                if FindAndRemoveBambooNextToTile(tile: tile, direction: m_direction, sawApplied: sawApplied) != nil{
                   
                    sawApplied = true
                }
            }
        
        }
        
        return sawApplied
    }
    
    func FindAndRemoveBambooNextToTile( tile:TileNode,  direction:Direction, sawApplied:Bool )->EdgeNode?
    {
        let halfCellSize = Constants.cellSize/2.0
        
        let actionMoveLeft = SKAction.moveBy(x: -halfCellSize, y: 0.0, duration: Constants.cutDuration)
        let actionMoveRight = SKAction.moveBy(x: halfCellSize, y: 0.0, duration: Constants.cutDuration)
        let actionMoveUp = SKAction.moveBy(x: 0.0, y: halfCellSize, duration: Constants.cutDuration)
        let actionMoveDown = SKAction.moveBy(x: 0.0, y: -halfCellSize, duration: Constants.cutDuration)
        
        var action1 = actionMoveLeft
        var action2 = actionMoveRight
        
        var bamboo: EdgeNode? = nil
        
        switch direction {
        case .Up:
            if let temp = gameModel.GetBamboo(row: tile.GetRow(), col: tile.GetCol(), isHorizontal: true) {
                bamboo = temp
                action1 = actionMoveUp
                action2 = actionMoveDown
                tile.sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "handsawU"))
            }
            break
            
        case .Down:
            if let temp = gameModel.GetBamboo(row: tile.GetRow()-1, col: tile.GetCol(), isHorizontal: true) {
                bamboo = temp
                action1 = actionMoveDown
                action2 = actionMoveUp
                tile.sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "handsawD"))
            }
            break
            
        case .Left:
            if let temp = gameModel.GetBamboo(row: tile.GetRow(), col: tile.GetCol()-1, isHorizontal: false) {
                bamboo = temp
                action1 = actionMoveLeft
                action2 = actionMoveRight
                tile.sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "handsawL"))
            }
            break
            
        case .Right:
            if let temp = gameModel.GetBamboo(row: tile.GetRow(), col: tile.GetCol(), isHorizontal: false) {
                bamboo = temp
                action1 = actionMoveRight
                action2 = actionMoveLeft
                tile.sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "handsawR"))
            }
            break
            
        default:
            break
        }
        
        if bamboo != nil {
            m_direction = .None
            let storedZIndex = tile.sprite?.zPosition
            tile.sprite?.zPosition = Constants.popupZIndex
            gameModel.SoundWoodCut(play: true)
            let actionRepeat = SKAction.repeat(SKAction.sequence([action1,action2]), count: 2)
            let actionDone = SKAction.run {
                tile.sprite?.zPosition = storedZIndex!
                //tile.sprite?.texture = SKTexture(image: #imageLiteral(resourceName: "handsaw"))
                self.gameModel.RemoveBamboo(bamboo: bamboo!)
                if !sawApplied {
                    self.PushAgainstTheWall()
                    self.gameModel.SoundWoodCut(play: false)
                }
            }
            tile.sprite?.run(SKAction.sequence([actionRepeat, actionDone]))

        }
        
        return bamboo
    }
}

