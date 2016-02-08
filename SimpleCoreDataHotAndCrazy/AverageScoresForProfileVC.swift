//
//  AverageScoresForProfileVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 11/26/15.
//  Copyright © 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData

class AverageScoresForProfileVC: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var profile : GirlProfile?
    
    
    @IBOutlet weak var averageHotScoreLabel: UILabel!
    
    @IBOutlet weak var averageCrazyScoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let scoresFetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        scoresFetchRequest.predicate = NSPredicate(format: "girlProfile = %@", profile!)
        if let scoresFetchResults = (try? managedObjectContext!.executeFetchRequest(scoresFetchRequest)) as? [EntriesForProfile] {
            var sumOfHotScores = 0.0
            var sumOfCrazyScores = 0.0
            for setOfScores in scoresFetchResults {
                sumOfHotScores = sumOfHotScores + Double(setOfScores.hotScore)
                sumOfCrazyScores += Double(setOfScores.crazyScore)
            }
            averageHotScoreLabel.text = String(sumOfHotScores/Double(scoresFetchResults.count))
            averageCrazyScoreLabel.text = String(sumOfCrazyScores/Double(scoresFetchResults.count))
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
