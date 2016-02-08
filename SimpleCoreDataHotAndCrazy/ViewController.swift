//
//  ViewController.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 9/14/15.
//  Copyright (c) 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

let testEntry: EntriesForProfile? = nil

class ViewController: UIViewController {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let entryFetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        if let entries = (try? managedObjectContext!.executeFetchRequest(entryFetchRequest)) as? [EntriesForProfile] {
            for entry in entries {
                if entry.girlProfile == testEntry?.girlProfile {
                    self.managedObjectContext?.deleteObject(entry)
                }
            }
        }
        
        
        do {
            try managedObjectContext!.save()
        } catch let error1 as NSError {
            print("Could not save \(error1), \(error1.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func printProfilesButtonTapped(sender: AnyObject) {
        let fetchRequest = NSFetchRequest(entityName: "GirlProfile")
        if let fetchResults = (try? managedObjectContext!.executeFetchRequest(fetchRequest)) as? [GirlProfile] {
            for profile in fetchResults {
                print(profile.firstName)
                print(profile)
            }
        }
        
        let scoresFetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        if let scoresFetchResults = (try? managedObjectContext!.executeFetchRequest(scoresFetchRequest)) as? [EntriesForProfile] {
            print(scoresFetchResults.count)
            for setOfScores in scoresFetchResults {
                print(setOfScores.crazyScore)
                print(setOfScores)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newEntry" {
            let moc = self.managedObjectContext
            let ent = NSEntityDescription.entityForName("EntriesForProfile", inManagedObjectContext: moc!)
            let newEntry = EntriesForProfile(entity: ent!, insertIntoManagedObjectContext: moc)
            let itemController : ScoringHotViewController = segue.destinationViewController as! ScoringHotViewController
            itemController.newEntry = newEntry
        } 
    
    }


}

