//
//  AllScoresForProfileTableVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 11/21/15.
//  Copyright © 2015 Bufni. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class AllScoresForProfileTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var profile : GirlProfile?
    var optionIdentifier = ""

    let managedObjectContext : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        fetchRequest.predicate = NSPredicate(format: "girlProfile = %@", profile!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "entryDate", ascending: true)]
        //OR:
        //let sortDescriptor = NSSortDescriptor(key: "hotScore", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frc = getFetchedResultsController()
        
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch let error as NSError {
            print("Could not perform fetch for AllScoresForProfileTableVC, \(error), \(error.userInfo)")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        
        let individualProfile = frc.objectAtIndexPath(indexPath) as! EntriesForProfile
        
        // Configure the cell...
        cell.textLabel?.text = String(individualProfile.entryDate)
        let lName = String(individualProfile.hotScore)
        let phoneNo = String(individualProfile.crazyScore)
        
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
        } catch let error as NSError {
            print("Cannot save \(error), \(error.userInfo)")
        }
    }

}
