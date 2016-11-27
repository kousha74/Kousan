//
//  GameViewController.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/22/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameManager{
    func onHomeButtonPressed( moveCount: Int )
    func onLevelButtonPressed( moveCount: Int )
    func onResetButtonPressed( moveCount: Int )
    
}

class GameViewController: UIViewController,GameManager  {

    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        GameModel.sharedInstance.SetCellSize(deviceSize: view.bounds.size )
        
        print(".. \(view.bounds.size.height) .... \(view.bounds.size.width)")
        let scene = GameScene(size: view.bounds.size)
        scene.gameManager = self
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    override func viewDidDisappear(_ animated: Bool) {
        let skView = view as! SKView
        skView.presentScene(nil)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
/*        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    func onHomeButtonPressed( moveCount: Int ){
        
        if ( moveCount == 0 ){
            GoToHomePage()
        }
        else {
            let alertController = UIAlertController(title: "Your game progress will be lost", message: "Do you want to continue?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("you have pressed OK button")
                self.GoToHomePage()
            }
            alertController.addAction(OKAction)
             
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func GoToHomePage()
    {
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController!.dismiss(animated: true, completion: {})
        })
        
        //performSegue(withIdentifier: "homePage", sender: self)
    }
    
    func GoToLevelSelectorPage()
    {
        dismiss(animated: true, completion: nil )
        //performSegue(withIdentifier: "levelSelector", sender: self)
    }
    
    func onLevelButtonPressed( moveCount: Int ){
        if ( moveCount == 0 ){
            GoToLevelSelectorPage()
        }
        else {
            let alertController = UIAlertController(title: "Your game progress will be lost", message: "Do you want to continue?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
                self.GoToLevelSelectorPage()
            }
            alertController.addAction(OKAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func onResetButtonPressed( moveCount: Int ){
        if ( moveCount == 0 ){
        }
        else{
            let alertController = UIAlertController(title: "Your game progress will be lost", message: "Do you want to continue?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("you have pressed OK button")
                GameEngine.sharedInstance.LoadGame( level: GameModel.sharedInstance.getCurrentLevel() )
            }
            alertController.addAction(OKAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}
