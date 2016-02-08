//
//  EditProfileVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 2/1/16.
//  Copyright © 2016 Bufni. All rights reserved.
//

import UIKit
import CoreData

class EditProfileVC: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var selectedProfile : GirlProfile? = nil

    @IBOutlet weak var firstNameEdit: UITextField!
    @IBOutlet weak var lastNameEdit: UITextField!
    @IBOutlet weak var phoneNumberEdit: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let profileFetchRequest = NSFetchRequest(entityName: "GirlProfile")
        if let profiles = (try? managedObjectContext.executeFetchRequest(profileFetchRequest)) as? [GirlProfile] {
            for profile in profiles {
                if profile == selectedProfile! {
                    firstNameEdit.text = profile.firstName
                    lastNameEdit.text = profile.lastName
                    phoneNumberEdit.text = profile.phoneNumber
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearTapped(sender: UIButton) {
        firstNameEdit.text = ""
        lastNameEdit.text = ""
        phoneNumberEdit.text = ""
    }
    
    @IBAction func saveTapped(sender: UIButton) {
        if (firstNameEdit.text != "") && (lastNameEdit.text != "") {
            selectedProfile?.firstName = firstNameEdit.text!
            selectedProfile?.lastName = lastNameEdit.text!
            selectedProfile?.phoneNumber = phoneNumberEdit.text!
            do {
                try managedObjectContext.save()
            } catch let error1 as NSError {
                print("Could not save \(error1), \(error1.userInfo)")
            }
            firstNameEdit.text = ""
            lastNameEdit.text = ""
            phoneNumberEdit.text = ""
        } else {
            let alert = UIAlertController(title: "Invalid", message: "You need a name for the girl, you creep!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            // Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
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
