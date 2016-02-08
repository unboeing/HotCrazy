//
//  CoreDataTestVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 9/15/15.
//  Copyright (c) 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataTestVC: UIViewController {
    
    var currentProfile : GirlProfile? = nil
    var scoresForCurrentProfile : EntriesForProfile? = nil
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var newOrOldRecord: UILabel!
    @IBOutlet weak var profileFirstName: UILabel!
    
    @IBOutlet weak var profileLastName: UILabel!

    @IBOutlet weak var profilePhoneNumber: UILabel!

    @IBOutlet weak var currentHotScore: UILabel!

    @IBOutlet weak var currentCrazyScore: UILabel!

    @IBOutlet weak var currentDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thisProfilePredicate = NSPredicate(format: "girlProfile == %@", argumentArray: [currentProfile!])
        let entriesFetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        entriesFetchRequest.predicate = thisProfilePredicate
        if let entriesForThisProfile = (try? managedObjectContext?.executeFetchRequest(entriesFetchRequest)) as? [EntriesForProfile] {
            newOrOldRecord.text = "Congrats, this is date number \(entriesForThisProfile.count) with her"
            profileFirstName.text = currentProfile?.firstName
            profileLastName.text = currentProfile?.lastName
            profilePhoneNumber.text = currentProfile?.phoneNumber
            currentHotScore.text = String(scoresForCurrentProfile!.hotScore)
            currentCrazyScore.text = String(scoresForCurrentProfile!.crazyScore)
            currentDate.text = String(scoresForCurrentProfile!.entryDate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
