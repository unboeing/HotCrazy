//
//  NewProfileViewController.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 9/14/15.
//  Copyright (c) 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class NewProfileViewController: UIViewController {
    
    var newProfileScoresIn : EntriesForProfile? = nil
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBAction func saveNewProfileButtonTapped(sender: AnyObject) {
        
        if (firstNameTextField.text == "") && (lastNameTextField.text == "") {
            let alert = UIAlertController(title: "Invalid", message: "You need a name for the girl, you creep!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            // Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            let fetchRequest = NSFetchRequest(entityName: "GirlProfile")
            if let fetchResults = (try? managedObjectContext!.executeFetchRequest(fetchRequest)) as? [GirlProfile] {
                for profile in fetchResults {
                    if (profile.firstName == firstNameTextField.text) && (profile.lastName == lastNameTextField.text) {
                        let alert = UIAlertController(title: "Duplicate", message: "There is already someone with the same name in Blackbook", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        // Display the alert
                        self.presentViewController(alert, animated: true, completion: nil)
                        firstNameTextField.text = ""
                        lastNameTextField.text = ""
                        phoneNumberTextField.text = ""
                    }
                }
                if (firstNameTextField.text != "") && (lastNameTextField.text != ""){
                    let moc = self.managedObjectContext
                    let ent = NSEntityDescription.entityForName("GirlProfile", inManagedObjectContext: moc!)
                    let newProfile = GirlProfile(entity: ent!, insertIntoManagedObjectContext: moc)
                    newProfile.firstName = firstNameTextField.text!
                    newProfile.lastName = lastNameTextField.text!
                    newProfile.phoneNumber = phoneNumberTextField.text!
                    newProfileScoresIn!.entryDate = NSDate()
                    newProfileScoresIn!.girlProfile = newProfile
                    }
                    do {
                        try managedObjectContext!.save()
                    } catch let error1 as NSError {
                        print("Could not save \(error1), \(error1.userInfo)")
                    }
                    firstNameTextField.text = ""
                    lastNameTextField.text = ""
                    phoneNumberTextField.text = ""
            }
        }
    }    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

    

