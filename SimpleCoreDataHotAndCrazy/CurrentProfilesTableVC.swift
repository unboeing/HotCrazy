//
//  CurrentProfilesTableVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 9/14/15.
//  Copyright (c) 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation
    
    class CurrentProfilesTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
        
        let moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        var frc : NSFetchedResultsController = NSFetchedResultsController()
        
        func getFetchedResultsController() -> NSFetchedResultsController {
            frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
            return frc
        }
        
        func listFetchRequest() -> NSFetchRequest {
            let fetchRequest = NSFetchRequest(entityName: "GirlProfile")
            let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            return fetchRequest
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            frc = getFetchedResultsController()
            
            frc.delegate = self
            do {
                try frc.performFetch()
            } catch _ {
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func controllerDidChangeContent(controller: NSFetchedResultsController) {
            tableView.reloadData()
        }
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Potentially incomplete method implementation.
            // Return the number of sections.
            let numberOfSections = frc.sections?.count
            return numberOfSections!
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete method implementation.
            // Return the number of rows in the section.
            let numberOfRowsInSection = frc.sections?[section].numberOfObjects
            return numberOfRowsInSection!
        }
        
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath)
            
            let profileList = frc.objectAtIndexPath(indexPath) as! GirlProfile
            
            // Configure the cell...
            cell.textLabel?.text = profileList.firstName
            let lName = profileList.lastName
            let phoneNo = profileList.phoneNumber
            
            cell.detailTextLabel?.text = "Detail: \(lName) - \(phoneNo)."
            
            
            
            return cell
        }
        
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            
            let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
            moc.deleteObject(managedObject)
            do {
                try moc.save()
            } catch _ {
            }
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "optionsForProfile" {
                let cell = sender as! UITableViewCell
                let indexPath = tableView.indexPathForCell(cell)
                let itemController : OptionsForSelectedProfileVC = segue.destinationViewController as! OptionsForSelectedProfileVC
                let tappedProfile : GirlProfile = frc.objectAtIndexPath(indexPath!) as! GirlProfile
                itemController.selectedProfile = tappedProfile
            }
        }

}
