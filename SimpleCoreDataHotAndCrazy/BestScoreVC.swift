
//
//  BestScoreVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 2/1/16.
//  Copyright © 2016 Bufni. All rights reserved.
//

import UIKit
import CoreData

class BestScoreVC: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var selectedProfile : GirlProfile? = nil
    var datesCoefficients : [Double] = []
    var datesForSelectedProfile : [EntriesForProfile] = []
    
    @IBOutlet weak var bestDateHotScore: UILabel!
    @IBOutlet weak var bestDateCrazyScore: UILabel!
    @IBOutlet weak var bestDateDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let entryFetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        let profilePredicate = NSPredicate(format: "girlProfile == %@", argumentArray: [selectedProfile!])
        entryFetchRequest.predicate = profilePredicate
        if let entriesForSelectedProfile = (try? managedObjectContext.executeFetchRequest(entryFetchRequest)) as? [EntriesForProfile] {
            for entry in entriesForSelectedProfile {
                let dateCoefficient = Double(entry.hotScore)/Double(entry.crazyScore)
                datesCoefficients.append(dateCoefficient)
                datesForSelectedProfile.append(entry)
                }
        }
        var bestDateCoefficient = 0.4
        for dateCoefficient in datesCoefficients {
            if dateCoefficient > bestDateCoefficient {
                bestDateCoefficient = dateCoefficient
            }
        }
        for date in datesForSelectedProfile {
            if Double(date.hotScore)/Double(date.crazyScore) == bestDateCoefficient {
                bestDateHotScore.text = String(date.hotScore)
                bestDateCrazyScore.text = String(date.crazyScore)
                bestDateDate.text = String(date.entryDate)
            }
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
