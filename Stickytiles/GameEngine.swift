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
    var touchedTile:TileNode?
    var m_move_direction:Int
    var m_upper_bound:CGFloat = 0
    var m_lower_bound:CGFloat = 0
    var direction_vector = [ CGPoint(x: 0, y: 1), CGPoint(x: 0, y: -1), CGPoint(x: -1, y: 0), CGPoint(x: 1, y: 0)];
    var moveCount:Int = 0
    let isStickyOn = true
    
    func LoadGame( level:Int, gameSceneProtocol:GameSceneProtocol ){
        m_move_direction = MOVE_DIRECTION_NONE
        dragging = false
        moveCount = 0
        gameModel.loadGame(level: level)
        m_GameSceneProtocol = gameSceneProtocol
    }
    
    func OnTouch(pos:CGPoint){
        
        touchPos.x = pos.x
        touchPos.y = pos.y
        
        if !isProcessing && !dragging
        {
            touchedCell.x = floor(( touchPos.x - gameModel.GetViewOffset().x )/CGFloat(gameModel.GetCellSize()) )
            touchedCell.y = floor(( touchPos.y - gameModel.GetViewOffset().y )/CGFloat(gameModel.GetCellSize()) )
            
            touchedTile = gameModel.GetTile(pos: touchedCell)
            
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
                    touchedTile = gameModel.GetTile(pos: pos)
                    
                    if ( touchedTile != nil ){
                        touchedTile?.Moveto(
                            delta_row: targetRow,
                            delta_col: targetCol,
                            cellSize: CGFloat(gameModel.GetCellSize()),
                            viewOffset: gameModel.GetViewOffset())
                        targetCol -= 1
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
                    touchedTile = gameModel.GetTile(pos: pos)
                    
                    if ( touchedTile != nil ){
                        touchedTile?.Moveto(
                            delta_row: targetRow,
                            delta_col: targetCol,
                            cellSize: CGFloat(gameModel.GetCellSize()),
                            viewOffset: gameModel.GetViewOffset())
                        targetCol += 1
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
                    touchedTile = gameModel.GetTile(pos: pos)
                    
                    if ( touchedTile != nil ){
                        touchedTile?.Moveto(
                            delta_row: targetRow,
                            delta_col: targetCol,
                            cellSize: CGFloat(gameModel.GetCellSize()),
                            viewOffset: gameModel.GetViewOffset())
                        targetRow -= 1
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
                    touchedTile = gameModel.GetTile(pos: pos)
                    
                    if ( touchedTile != nil ){
                        
                        if ( row != targetRow ) || ( col != targetCol ) {
                        
                        touchedTile?.Moveto(
                            delta_row: targetRow,
                            delta_col: targetCol,
                            cellSize: CGFloat(gameModel.GetCellSize()),
                            viewOffset: gameModel.GetViewOffset())
                        }
                        
                        targetRow += 1
                    }
                }
            }
            break
            
        default:
            break
        }
        
        Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay ), target: self, selector:#selector(GameEnagin.FindClusters), userInfo: nil, repeats: false)
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
        

        if ( clusterFound ){
            
            if (!specialClusterFound){
                gameModel.SoundWave()
            }
            
            if ( gameModel.FindFlag(flag: TileNode.TBP, isSet: true) != nil ){
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay + 0.1 /*TBD*/), target: self, selector:#selector(GameEnagin.ProcessSpecialNodes), userInfo: nil, repeats: false)
                MarkSpecialNodes()
            }
            else{
                Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay + 0.1 /*TBD*/), target: self, selector:#selector(GameEnagin.PushAgainstTheWall), userInfo: nil, repeats: false)
            }
        }
        else if shouldAddTile {
            shouldAddTile = false
            AddTile()
        }
        else{
            isProcessing = false
        }
    }
    
    func DeleteTile(tile:TileNode){
        gameModel.RemoveTile(tile: tile)
        let fadeoutAction = SKAction.fadeOut(withDuration: GameModel.delay)
        let actionMoveDone = SKAction.removeFromParent()
        tile.sprite?.run( SKAction.sequence([fadeoutAction,actionMoveDone]))
    }
    
    @objc func ProcessSpecialNodes(){
        
        if  let temp = gameModel.FindFlag(flag: TileNode.TBP, isSet: true) {
            
            let tile = temp
            
            let clusterType = tile.GetClusterType()
            
            switch ( clusterType ){
            case .Row:
                for col in 0...gameModel.boardSize-1{
                    
                    if let temp = gameModel.GetTile(pos: CGPoint(x:CGFloat(col), y:tile.pos.y)) {
                        let tile2 = temp
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
                
            case .Col:
                for row in 0...gameModel.boardSize-1{
                    
                    if let temp = gameModel.GetTile(pos: CGPoint(x:tile.pos.x, y: CGFloat(row))) {
                        let tile2 = temp
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
                
            case .Four:
                for tile2 in gameModel.GetTiles(){
                    
                    if ( tile2.GetID() == tile.GetID()) /*TBD*/
                    {
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
                
            default:
                break
            }
            
            tile.SetFlag(flag: TileNode.TBP, isSet: false)
            DeleteTile(tile: tile )
            ProcessSpecialNodes()

        }
        else{
            Timer.scheduledTimer(timeInterval: TimeInterval( GameModel.delay + 0.1 /*TBD*/), target: self, selector:#selector(GameEnagin.PushAgainstTheWall), userInfo: nil, repeats: false)
        }
    }

    /* TBD special case: cascading delete*/
    @objc func MarkSpecialNodes(){
        
        for tile in gameModel.FindFlags(flag: TileNode.TBP, isSet: true) {
            
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
                    
                    if ( tile2.GetID() == tile.GetID()) /*TBD*/
                    {
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
                
            default:
                break
            }
        }
    }

    func AddTile(){
        
        if let tile = gameModel.AddTile() {
            m_GameSceneProtocol?.onNewTile(tile: tile)
            tile.sprite?.alpha = 0.0
            
            let fadeinAction = SKAction.fadeIn(withDuration: GameModel.delay )
            let clusterAction = SKAction.run { self.FindClusters() }
            tile.sprite?.run( SKAction.sequence( [ fadeinAction, clusterAction] ))
        }
    }
    
    func GetClusterType(cluster:[TileNode])->TileNode.ClusterType{
        
        if cluster.count == 4{
            
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
        }
        
        return .None
    }
    
    func FindClusterAtTile( tile:TileNode )->[TileNode]{
        
        var cluster = [TileNode]()
        var queue = [TileNode]()
        
        tile.SetFlag(flag: TileNode.IS_VISITED, isSet: true )
        cluster.append(tile)
        queue.append(tile)
        
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
        
        let fadeoutAction = SKAction.fadeOut(withDuration: 2)
        let removeAction = SKAction.removeFromParent()
        shape.run(SKAction.sequence([ fadeoutAction, removeAction]))
    }
}

