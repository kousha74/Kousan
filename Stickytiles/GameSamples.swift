//
//  GameSamples.swift
//  Magictiles
//
//  Created by Kousha moaveninejad on 12/26/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import Foundation

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
    
    static func GenerateSamples()->[GameSample]{

    var gameSamples = [GameSample]()
    
    //fruits [id,x,y]
    //goals [Chcolate, targetScore, maxMoves, targetApples, targetSpecial, targetStars, colorCount, baloon frequency]
    
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
    
    //Level 107
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
    
    
    //Level 108
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
    
    
    //Level 109
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
    
    
    //Level 110
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
    
    //Level 111
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
    
    //Level 112
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
    
    //Level 113
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
    
    
    
    //Level 114
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
    
    
    //Level 115
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
    
    //Level 116
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
    
    //Level 117
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
    
    [GameModel.STAR7_ID,2,2]
    ],
    goals: [0,0,0,0,0,0,6,6]
    ) )
    
    //Level 118
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
    
    //Level 119
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
    
    
    
    //Level 120
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
    
    //Level 121
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
    
    //Level 122
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
    
    //Level 123
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
    
    //Level 127
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
    [GameModel.FRUIT_BASKET_ID,2,0],
    [1,4,0],
    [1,5,0]
    ],
    goals: [16,0,0,0,0,0,6,4]
    ) )
    
    
    //Level 128
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
    
    [GameModel.HAND_SAW_ID,0,0,1],
    [1,1,0],
    [1,2,0],
    [1,4,0],
    [1,5,0]
    
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
    
    
    
    
    
    // Level 132
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
    [1,4,0],
    [1,5,0]
    
    ],
    goals: [2,0,0,0,0,0,6,0]
    ) )
    
    
    // Level 133
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
    
    //level 134
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
    [1,4,0],
    [1,5,0]
    
    ],
    goals: [2,0,0,0,0,0,6,0]
    ) )
    
    //level 135
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
    
    //level 136
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
    
    [GameModel.HAND_SAW_ID,0,0],
    [1,4,0],
    [1,5,0]
    
    ],
    goals: [2,0,0,0,0,0,6,0]
    ) )
    
    //level 137
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
    
    // level 138
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
    
    [GameModel.HAND_SAW_ID,0,0],
    [1,4,0],
    [1,5,0]
    ],
    goals: [6,0,0,0,0,0,6,0]
    ) )
    
    //level 139
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
    
    //Level 140
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
    
    // level 141
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
    [1,4,0],
    [1,5,0]
    
    ],
    goals: [2,0,0,0,0,0,6,5]
    ) )
    
    // level 142
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
    [GameModel.FRUIT_BASKET_ID,2,0],
    [1,4,0],
    [1,5,0]
    ],
    goals: [16,0,0,0,0,0,6,4]
    ) )
    
    //level 143
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
    
    //level 144
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
    
    [GameModel.HAND_SAW_ID,0,0,1],
    [1,4,0],
    [1,5,0]
    
    ],
    goals: [2,0,0,0,0,0,6,0]
    ) )
    
    //level 145
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
    
    //level 146
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
    
    [GameModel.HAND_SAW_ID,0,0],
    [1,4,0],
    [1,5,0]
    ],
    goals: [6,0,0,0,0,0,6,0]
    ) )
    
    //level 147
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
    
    
    //level 148
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
    
    //level 149
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
    [4,5,4,2],
    [1,4,0],
    [1,5,0]
    ],
    goals: [2,0,0,0,0,0,6,0]
    ) )
    
    
    
    //level 150
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

    return gameSamples
    }
}

