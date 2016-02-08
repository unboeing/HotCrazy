//
//  ProfileOptionsTableVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 11/21/15.
//  Copyright © 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ProfileOptionsVC: UIViewController {
    
    let managedObjectContext : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    
    var forProfile : GirlProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "allScores" {
            let itemController : AllScoresForProfileTableVC = segue.destinationViewController as! AllScoresForProfileTableVC
            itemController.profile = forProfile
        } else if segue.identifier == "average" {
            let itemController : AverageScoresForProfileVC = segue.destinationViewController as! AverageScoresForProfileVC
            itemController.profile = forProfile
        }
    }
    

}
