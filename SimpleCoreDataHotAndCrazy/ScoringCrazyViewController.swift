//
//  ScoringCrazyViewController.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 9/14/15.
//  Copyright (c) 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ScoringCrazyViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var newEntryHotIn: EntriesForProfile? = nil
    
    @IBOutlet weak var crazyScoreLabel: UILabel!
    @IBOutlet weak var crazyScoreSlider: UISlider!
    
    @IBAction func crazyScoreSlider(sender: UISlider) {
        crazyScoreLabel.text = String.localizedStringWithFormat("%.2f", sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        crazyScoreLabel.text = String.localizedStringWithFormat("%.2f", crazyScoreSlider.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "scoresIn" {
            newEntryHotIn?.crazyScore = crazyScoreSlider.value
            do {
                try managedObjectContext!.save()
            } catch _ {
            }
            let itemController : NewEntryProfilesTableVC = segue.destinationViewController as! NewEntryProfilesTableVC
            itemController.scoresIn = newEntryHotIn
            }
    }
    
    @IBAction func printProfilesButtonTapped(sender: AnyObject) {
        let scoresFetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        if let scoresFetchResults = (try? managedObjectContext!.executeFetchRequest(scoresFetchRequest)) as? [EntriesForProfile] {
            print(scoresFetchResults.count)
            for setOfScores in scoresFetchResults {
                print(setOfScores.crazyScore)
                print(setOfScores)
            }
        }
    }

}

