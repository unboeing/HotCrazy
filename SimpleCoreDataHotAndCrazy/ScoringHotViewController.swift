//
//  ScoringHotViewController.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 9/14/15.
//  Copyright (c) 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ScoringHotViewController: UIViewController {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var newEntry : EntriesForProfile? = nil
    
    @IBOutlet weak var hotScoreLabel: UILabel!
    @IBOutlet weak var hotScoreSlider: UISlider!
    
    @IBAction func hotScoreSlider(sender: UISlider) {
        hotScoreLabel.text = String.localizedStringWithFormat("%.2f", sender.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hotScoreLabel.text = String.localizedStringWithFormat("%.2f", hotScoreSlider.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "hotSaved" {
            let itemController : ScoringCrazyViewController = segue.destinationViewController as! ScoringCrazyViewController
            newEntry!.hotScore = hotScoreSlider.value
            do {
                try managedObjectContext!.save()
            } catch _ {
            }
            itemController.newEntryHotIn = newEntry!
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
