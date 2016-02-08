//
//  OptionsForSelectedProfileVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 2/1/16.
//  Copyright © 2016 Bufni. All rights reserved.
//

import UIKit
import CoreData

class OptionsForSelectedProfileVC: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var selectedProfile : GirlProfile? = nil

    @IBAction func contactGirlButtonTapped(sender: UIButton) {
        let alert = UIAlertController(title: "Contact Options", message: "How would you like to connect?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        // Display the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "allScores" {
            let itemController : EntriesForSelectedProfileTableVC = segue.destinationViewController as! EntriesForSelectedProfileTableVC
            itemController.selectedProfile = selectedProfile
        } else if segue.identifier == "averageScore" {
            let itemController : AverageScoreVC = segue.destinationViewController as! AverageScoreVC
            itemController.selectedProfile = selectedProfile
        } else if segue.identifier == "bestScore" {
            let itemController : BestScoreVC = segue.destinationViewController as! BestScoreVC
            itemController.selectedProfile = selectedProfile
        } else if segue.identifier == "editProfile" {
            let itemController : EditProfileVC = segue.destinationViewController as! EditProfileVC
            itemController.selectedProfile = selectedProfile
        }
    }

}
