//
//  LevelSelectorViewController.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/22/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import UIKit

class LevelSelectorViewController: UIViewController {
    
    
    // MARK: Controls
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var btn16: UIButton!
    @IBOutlet weak var btn17: UIButton!
    @IBOutlet weak var btn18: UIButton!
    @IBOutlet weak var btn19: UIButton!
    @IBOutlet weak var btn20: UIButton!
    @IBOutlet weak var btn21: UIButton!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var btn23: UIButton!
    @IBOutlet weak var btn24: UIButton!
    @IBOutlet weak var btn25: UIButton!
    
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var theView: UIView!
    
    @IBOutlet weak var levelLabel: UILabel!
    // MARK: Variables
    let gamesPerPage : Int = 25
    var currentPage : Int = 0
    var buttons = [UIButton]()

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        theView.backgroundColor = UIColor.brown.withAlphaComponent(0.5)
        theView.layer.cornerRadius = 10
        theView.layer.borderWidth = 1

        // Do any additional setup after loading the view.
        buttons.append(btn1)
        buttons.append(btn2)
        buttons.append(btn3)
        buttons.append(btn4)
        buttons.append(btn5)
        buttons.append(btn6)
        buttons.append(btn7)
        buttons.append(btn8)
        buttons.append(btn9)
        buttons.append(btn10)
        buttons.append(btn11)
        buttons.append(btn12)
        buttons.append(btn13)
        buttons.append(btn14)
        buttons.append(btn15)
        buttons.append(btn16)
        buttons.append(btn17)
        buttons.append(btn18)
        buttons.append(btn19)
        buttons.append(btn20)
        buttons.append(btn21)
        buttons.append(btn22)
        buttons.append(btn23)
        buttons.append(btn24)
        buttons.append(btn25)
        
        let maxCompleted = GameModel.sharedInstance.getMaxLevelCompleted()
        
        if maxCompleted < GameModel.maxLevel {
            currentPage = ( GameModel.sharedInstance.getMaxLevelCompleted() + 1 )/gamesPerPage
        }
        else{
            currentPage = ( GameModel.maxLevel )/gamesPerPage
        }
        
        for button in buttons
        {
            button.titleLabel!.font =  UIFont(name: Constants.fontName, size: Constants.fontSizeLevels)
            button.contentVerticalAlignment = .bottom;
        }
        
        SetButtonLabels()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SetButtonLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   
    @IBAction func OnButtonClicked(_ sender: UIButton) {
        
        if ( sender.tag + currentPage*gamesPerPage <= GameModel.sharedInstance.getMaxLevelCompleted() + 1 )
        {
            GameModel.sharedInstance.setCurrentLevel(_currentLevel: sender.tag + currentPage*gamesPerPage)
            performSegue(withIdentifier: "gameSceneSegue", sender: self)
            print("button clicked")
        }
    }
    
    @IBAction func OnNextButtonPress(_ sender: UIButton) {
        if ( (currentPage+1)*gamesPerPage < GameModel.maxLevel ) {
            currentPage += 1
            SetButtonLabels()
            
        }
    }
    
    @IBAction func OnPrevButtonPressed(_ sender: UIButton) {
        if ( currentPage > 0 ) {
            currentPage -= 1
            SetButtonLabels()
            
        }

    }
    
    func SetButtonLabels(){
        
        let maxLevelCompleted : Int = GameModel.sharedInstance.getMaxLevelCompleted()
        
        let levelOffset : Int = currentPage*gamesPerPage
        
        
        for button in buttons
        {
            if  ( (button.tag + levelOffset ) <= maxLevelCompleted ) {
                button.setBackgroundImage(#imageLiteral(resourceName: "checkImage"),for: .normal)
                button.setTitle(String(button.tag+levelOffset+1), for: .normal)
            }
            else if ( (button.tag + levelOffset) == (maxLevelCompleted + 1) ) {
                button.setBackgroundImage(#imageLiteral(resourceName: "questionImage"),for: .normal)
                button.setTitle(String(button.tag+levelOffset+1), for: .normal)
            }
            else {
                button.setBackgroundImage(#imageLiteral(resourceName: "locked"),for: .normal)
                button.setTitle("", for: .normal)
            }
        }
        
        levelLabel.text = "Level " + String(levelOffset+1) + " - " + String(levelOffset+gamesPerPage)
       
    }
    
}
