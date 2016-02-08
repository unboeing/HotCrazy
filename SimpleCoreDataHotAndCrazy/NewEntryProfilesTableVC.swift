//
//  NewEntryProfilesTableVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 9/14/15.
//  Copyright (c) 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class NewEntryProfilesTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    var scoresIn : EntriesForProfile? = nil
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "GirlProfile")
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        
        let profileList = frc.objectAtIndexPath(indexPath) as! GirlProfile
        
        // Configure the cell...
        cell.textLabel?.text = profileList.firstName
        let lName = profileList.lastName
        let phoneNo = profileList.phoneNumber
        
        cell.detailTextLabel?.text = "Detail: \(lName) - \(phoneNo)."
        
        
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext.deleteObject(managedObject)
        do {
            try managedObjectContext.save()
        } catch _ {
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "existingProfile" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController : CoreDataTestVC = segue.destinationViewController as! CoreDataTestVC
            let currentProfile : GirlProfile = frc.objectAtIndexPath(indexPath!) as! GirlProfile
            scoresIn!.entryDate = NSDate()
            scoresIn!.girlProfile = currentProfile
            itemController.currentProfile = currentProfile
            do {
                try managedObjectContext.save()
            } catch _ {
            }
            itemController.scoresForCurrentProfile = scoresIn
        } else if segue.identifier == "newProfile" {
            let itemController : NewProfileViewController = segue.destinationViewController as! NewProfileViewController
            itemController.newProfileScoresIn = scoresIn
    }
    }
}
    










