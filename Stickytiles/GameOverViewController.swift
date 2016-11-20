//
//  GameOverViewController.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/27/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        theView.backgroundColor = UIColor.lightGray
        theView.layer.cornerRadius = 10
        theView.layer.borderWidth = 1
        
        theLabel.text = "You've finished level \(GameModel.sharedInstance.getCurrentLevel()+1) successfully"
        
        //if ( GameModel.sharedInstance.getCurrentLevel() > 30 ){
        //    Chartboost.showInterstitial(CBLocationHomeScreen)
        //}
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

    @IBOutlet weak var theView: UIView!
    @IBOutlet weak var theLabel: UILabel!
    
    @IBAction func OnButtonClick(_ sender: UIButton) {
        print("button clicked ...")
        
        switch (sender.tag){
        case 1:
            performSegue(withIdentifier: "homeSegue", sender: self)
            break;
        case 2:
            performSegue(withIdentifier: "levelSceneSegue", sender: self)
            break;
        case 3:
            GameModel.sharedInstance.IncreaseCurrentLevel()
            performSegue(withIdentifier: "gameSceneSegue", sender: self)
            break;
        case 4:
            performSegue(withIdentifier: "gameSceneSegue", sender: self)
            break;
       default:
            print("UNKNOWN button pressed")
            break;
        }
    }
}
