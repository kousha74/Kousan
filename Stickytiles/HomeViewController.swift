   //
//  HomeViewController.swift
//  Stickytiles
//
//  Created by Kousha moaveninejad on 9/22/16.
//  Copyright © 2016 Kousha moaveninejad. All rights reserved.
//

import UIKit
import StoreKit

class HomeViewController: UIViewController {

    var products = [SKProduct]()
    
    @IBOutlet weak var removeAdsButton: UIButton!
    
    @IBOutlet weak var restorePurchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.handlePurchaseNotification(_:)),
                                               name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
                                               object: nil)
        reload()
        
        if ( GameModel.sharedInstance.IsProductPurchased(productID: GameProducts.removeAds))
        {
            removeAdsButton.isHidden = true
            restorePurchaseButton.isHidden = true
        }

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
    
    @IBAction func OnRemoveAdsPressed(_ sender: AnyObject) {
        
        if ( products.count > 0 ) {
            
            GameProducts.store.buyProduct(products[0])
        }
        else {
            reload()
            
            let alertController = UIAlertController(title: "Connection Error!", message: "Could not connect to internet.", preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func OnRestorePurchasePressed(_ sender: AnyObject) {
        GameProducts.store.restorePurchases()
    }
    
    func handlePurchaseNotification(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        GameModel.sharedInstance.OnProductPurchased(productID: productID)
        
        if ( GameModel.sharedInstance.IsProductPurchased(productID: GameProducts.removeAds))
        {
            removeAdsButton.isHidden = true
            restorePurchaseButton.isHidden = true
        }

    }

    @IBAction func OnFacebookButtonPressed(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "https://www.facebook.com/ParsPicks/")!)
    }
    
    @IBAction func OnEmailButtonPressed(_ sender: UIButton) {
        let email = "webmaster@parspicks.com"
        UIApplication.shared.openURL(URL(string: "mailto:\(email)")!)
    }
    
    @IBAction func OnTweeterButtonPressed(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "https://twitter.com/KoushaNejad")!)
    }
    
    @IBAction func OnShareButtonPressed(_ sender: UIButton) {
        
        let textToShare = "Pars Picks!  Fun puzzles for your brain!"
        
        if let myWebsite = NSURL(string: "http://www.parspicks.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func reload() {
        products = []
        
        GameProducts.store.requestProducts{success, products in
            if success {
                self.products = products!
            }
        }
    }
}
