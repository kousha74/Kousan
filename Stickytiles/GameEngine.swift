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

class GameEnagin {
    
    enum Direction {
        case Up, Down, Right, Left, None
    }
    
    class var sharedInstance: GameEnagin {
        struct Static {
            static let instance: GameEnagin = GameEnagin()
        }
        return Static.instance
    }
    
    private init() {
        m_move_direction = MOVE_DIRECTION_NONE
    }
    
    private var m_direction: Direction = .None
    
    private var m_GameSceneProtocol:GameSceneProtocol?
    
    private var isProcessing = false
    
    private var shouldAddTile = false
    
    static let MIN_CLUSTER_SIZE = 3
    
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
    
    func LoadGame( level:Int, gameSceneProtocol:GameSceneProtocol ){
        m_move_direction = MOVE_DIRECTION_NONE
        dragging = false
        gameModel.loadGame(level: level)
        m_GameSceneProtocol = gameSceneProtocol
    }
    
    
    
    func OnTouch(pos:CGPoint){
        
        touchPos.x = pos.x
        touchPos.y = pos.y
        
        if !isProcessing && !dragging
        {
            dragging = true
        }
    }
    
    func IsSolved()->Bool{
        
        return false
        
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
                        if touchedTile.IsBlock(){
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
                        if touchedTile.IsBlock(){
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
                        if touchedTile.IsBlock(){
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
                        
                        if touchedTile.IsBlock(){
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
        
        Timer.scheduledTimer(timeInterval: TimeInterval( ( m_direction != .None ) ? GameModel.delay : 0.0 ), target: self, selector:#selector(GameEnagin.FindClusters), userInfo: nil, repeats: false)
        
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
    
    func OnRelease(pos:CGPoint)->Bool{
        
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
                        switch touchedTile.GetID() {
                        case TileNode.STAR5_ID:
                            touchedTile.SetFlag(flag: TileNode.TBP, isSet: true)
                            isProcessing = true
                            shouldAddTile = true
                            MarkSpecialNodes(tile: touchedTile)
                            Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEnagin.ProcessSpecialNodes), userInfo: nil, repeats: false)
                            gameModel.ChangeMoveCount(delta: 1)
                            break
                            
                        case TileNode.STAR7_ID:
                            touchedTile.SetFlag(flag: TileNode.TBP, isSet: true)
                            isProcessing = true
                            shouldAddTile = true
                            MarkSpecialNodes(tile: touchedTile)
                            Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEnagin.ProcessSpecialNodes), userInfo: nil, repeats: false)
                            gameModel.ChangeMoveCount(delta: 1)
                            break
                        
                        case TileNode.BLOCKER_ID: //touching a blocker removes it
                            DeleteTile(tile: touchedTile)
                            break
                            
                        case TileNode.BUBBLE_ID: //pop the balloon
                            gameModel.SoundWave()
                            DeleteTile(tile: touchedTile)
                            gameModel.ChangeMoveCount(delta: 1)
                            break
                            
                        default:
                            break
                        }
                    }
                    else{
                        RemoveBlockers() //At most one blocker is allowed
                        AddTile(id: TileNode.BLOCKER_ID, pos: touchedCell)
                        gameModel.ChangeMoveCount(delta: 1)
                    }
                }
            }
        }
        
        return false
    }
    
    @objc func FindClusters(){
        
        var clusterFound = false
        
        var specialClusterFound = false
        
        if ( gameModel.GetTileCount() > 0){
            
            // reset the visited flag
            gameModel.SetFlag(flag: TileNode.IS_VISITED, isSet: false)
            gameModel.SetFlag(flag: TileNode.TBP, isSet: false)
            
            var gameTiles = [TileNode]()
            
            for tile in gameModel.GetGameTiles(){
                gameTiles.append(tile)
            }
            
            for tile in gameTiles{
                if ( !tile.GetFlag(flag: TileNode.IS_VISITED))
                {
                    let cluster = FindClusterAtTile(tile: tile)
                    
                    if ( cluster.count >= GameEnagin.MIN_CLUSTER_SIZE )
                    {
                        var clusterType = GetClusterType(cluster: cluster)
                        
                        for tile2 in cluster{
                            
                            if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                                
                                //if the cluster has a special type, then one of the regular tiles must be converted accordingly
                                if ( clusterType != TileNode.ClusterType.None ){
                                    gameModel.SoundChime()
                                    specialClusterFound = true
                                    tile2.SetClusterType(type: clusterType)
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
                }
            }
        }
        
        let tile2 = gameModel.FindFlag(flag: TileNode.TBP, isSet: true)
        
        if ( clusterFound ) || ( tile2 != nil ) {
            
            if (!specialClusterFound){
                gameModel.SoundWave()
            }
            
            if ( tile2 != nil ){
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEnagin.ProcessSpecialNodes), userInfo: nil, repeats: false)
                MarkSpecialNodes( tile: tile2! )
            }
            else{
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEnagin.PushAgainstTheWall), userInfo: nil, repeats: false)
            }
        }
        else if shouldAddTile {
            shouldAddTile = false
            AddTile()
        }
        else{
            isProcessing = false
            RemoveBlockers()
        }
    }
    
    func RemoveBlockers(){
        //TBD removes one blocker
        for tile in gameModel.GetTiles(){
            if tile.GetID() == TileNode.BLOCKER_ID {
                DeleteTile(tile: tile)
            }
        }
    }
    
    func SameColor(tile1:TileNode, tile2:TileNode)->Bool{
        return ( tile1.GetID() == tile2.GetID() ) && ( tile1.GetID() < TileNode.BUBBLE_ID )
    }
    
    func DeleteTile(tile:TileNode){
        gameModel.RemoveTile(tile: tile)
        m_GameSceneProtocol?.UpdateLabels()
        let fadeoutAction = SKAction.fadeOut(withDuration: GameModel.delay)
        let actionMoveDone = SKAction.removeFromParent()
        tile.sprite?.run( SKAction.sequence([fadeoutAction,actionMoveDone]))
    }
    
    func DeleteRow( row:Int ){
        for col in 0...gameModel.boardSize-1{
            
            if let temp = gameModel.GetTile(pos: CGPoint(x:CGFloat(col), y: CGFloat(row))) {
                let tile2 = temp
                tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                    //delete the tile
                    if !tile2.IsBlock(){
                        DeleteTile(tile: tile2 )
                    }
                }
                else{
                    tile2.SetFlag(flag: TileNode.TBP, isSet: true)
                }
            }
        }
    }
    
    func DeleteCol( col:Int ){
        for row in 0...gameModel.boardSize-1{
            
            if let temp = gameModel.GetTile(pos: CGPoint(x:CGFloat(col), y: CGFloat(row))) {
                let tile2 = temp
                tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                    //delete the tile
                    if !tile2.IsBlock(){
                        DeleteTile(tile: tile2 )
                    }
                }
                else{
                    tile2.SetFlag(flag: TileNode.TBP, isSet: true)
                }
            }
        }
    }
    
    func DeleteDiagonally( tile: TileNode ){
        for tile2 in gameModel.GetTiles(){
            let deltaRow = abs( tile.GetRow() - tile2.GetRow() )
            let deltaCol = abs( tile.GetCol() - tile2.GetCol() )
            if deltaRow == deltaCol{
                tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                    //delete the tile
                    if !tile2.IsBlock(){
                        DeleteTile(tile: tile2 )
                    }
                }
                else{
                    tile2.SetFlag(flag: TileNode.TBP, isSet: true)
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
                    
                    if SameColor(tile1: tile, tile2: tile2){
                        tile2.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
                        if ( tile2.GetClusterType() == TileNode.ClusterType.None ){
                            //delete the tile
                            DeleteTile(tile: tile2 )
                        }
                        else{
                            tile2.SetFlag(flag: TileNode.TBP, isSet: true)
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
            
            if let tile2 = gameModel.FindFlag(flag: TileNode.TBP, isSet: true) {
                //We have more to process
                MarkSpecialNodes(tile: tile2)
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEnagin.ProcessSpecialNodes), userInfo: nil, repeats: false)
            }
            else{
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEnagin.PushAgainstTheWall), userInfo: nil, repeats: false)
                
            }
        }
    }

    /* TBD special case: cascading delete*/
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
                
                if SameColor(tile1: tile, tile2: tile2 ){
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

    func AddTile(){
        
        if let tile = gameModel.AddTile() {
            m_GameSceneProtocol?.onNewTile(tile: tile)
            tile.sprite?.alpha = 0.0
            
            let fadeinAction = SKAction.fadeIn(withDuration: GameModel.delay )
            let clusterAction = SKAction.run { self.FindClusters() } //TBD have the caller call this action
            tile.sprite?.run( SKAction.sequence( [ fadeinAction, clusterAction] ))
        }
    }
    
    func AddTile(id: Int, pos:CGPoint){
        if let tile = gameModel.AddTile(id: id, pos: pos) {
            m_GameSceneProtocol?.onNewTile(tile: tile)
            tile.sprite?.alpha = 0.0
            tile.sprite?.run( SKAction.fadeIn(withDuration: GameModel.delay ) )
        }
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
        if ( tile.GetID() < TileNode.BUBBLE_ID ){
            var newTilePos = CGPoint(x: 0, y: 0)
            
            let id = tile.GetID()
            
            while ( !queue.isEmpty )
            {
                let currentTile = queue[0]
                queue.remove(at: 0)
                
                for pos in direction_vector {
                    
                    newTilePos.x = currentTile.pos.x + pos.x
                    newTilePos.y = currentTile.pos.y + pos.y
                
                    if let newTile = gameModel.GetTile(pos: newTilePos){
                        if ( !newTile.GetFlag(flag: TileNode.IS_VISITED ) ) && ( newTile.GetID() == id )
                        {
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

