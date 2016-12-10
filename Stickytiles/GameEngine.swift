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
    
    
    func SetParent( parent: GameSceneProtocol )
    {
        m_GameSceneProtocol = parent
    }
    
    func LoadGame( level:Int ){
        m_move_direction = MOVE_DIRECTION_NONE
        dragging = false
        gameModel.loadGame(level: level)
        
        for tile in gameModel.GetTiles(){
            m_GameSceneProtocol?.onAddChild(child: tile.sprite!)
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
                touchedCell.x = floor(( touchPos.x - gameModel.GetViewOffset().x )/CGFloat(gameModel.GetCellSize()) )
                touchedCell.y = floor(( touchPos.y - gameModel.GetViewOffset().y )/CGFloat(gameModel.GetCellSize()) )
                
                if gameModel.IsValidPosition(pos: touchedCell){
                    if let touchedTile = gameModel.GetTile(pos: touchedCell) {
                        
                        //touching covered ones should do nothing
                        if touchedTile.GetCoverCount() == 0 {
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
                                
                            default:
                                break
                            }
                        }
                    }
                    else{
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
            if ( ( gameModel.AreAdsAvailable() ) && ((gameModel.GetMoveCount()%25) == 0 ) && ( gameModel.GetMoveCount() > 0 )){
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
                    if SameFruit(tile1: tile, tile2: tile2){
                        tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                        
                        if !tile2.GetFlag(flag: TileNode.IS_LOCKED) {
                            if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                                //delete the tile
                                DeleteTile(tile: tile2 )///
                            }
                            else{
                                tile2.SetFlag(flag: TileNode.TBP, isSet: true)
                            }
                        }
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
                
            default:
                break
            }
            
            tile.SetFlag(flag: TileNode.TBP, isSet: false)
            DeleteTile(tile: tile )
            
            if m_direction == .None {
                m_direction = .Down
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEngine.PushAgainstTheWall), userInfo: nil, repeats: false)
                
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
            var tileFound = false
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
            }
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
        shape.zPosition = 2.0
        m_GameSceneProtocol?.onAddChild(child: shape)
        
        let fadeoutAction = SKAction.fadeOut(withDuration: GameModel.delay )
        let removeAction = SKAction.removeFromParent()
        shape.run(SKAction.sequence([ fadeoutAction, removeAction]))
    }
}

