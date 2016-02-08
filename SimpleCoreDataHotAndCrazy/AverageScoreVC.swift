//
//  AverageScoreVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 2/1/16.
//  Copyright © 2016 Bufni. All rights reserved.
//

import UIKit
import CoreData

class AverageScoreVC: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var selectedProfile : GirlProfile? = nil
    
    @IBOutlet weak var averageHotScore: UILabel!
    @IBOutlet weak var averageCrazyScore: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let entryFetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        let profilePredicate = NSPredicate(format: "girlProfile == %@", argumentArray: [selectedProfile!])
        entryFetchRequest.predicate = profilePredicate
        if let entriesForSelectedProfile = (try? managedObjectContext.executeFetchRequest(entryFetchRequest)) as? [EntriesForProfile] {
            var hotScoreSum = 0.0
            var crazyScoreSum = 0.0
            for entry in entriesForSelectedProfile {
                hotScoreSum += Double(entry.hotScore)
                crazyScoreSum += Double(entry.crazyScore)
            }
            averageHotScore.text = String(hotScoreSum/Double(entriesForSelectedProfile.count))
            averageCrazyScore.text = String(crazyScoreSum/Double(entriesForSelectedProfile.count))
        }
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
        if segue.identifier == "back" {
            let itemController : OptionsForSelectedProfileVC = segue.destinationViewController as! OptionsForSelectedProfileVC
            let container = selectedProfile!
            itemController.selectedProfile = container
        }
    }
    

}
