//
//  EntriesForSelectedProfileTableVC.swift
//  SimpleCoreDataHotAndCrazy
//
//  Created by Bufni on 1/29/16.
//  Copyright © 2016 Bufni. All rights reserved.
//

import UIKit
import CoreData

class EntriesForSelectedProfileTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var selectedProfile : GirlProfile? = nil
    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "EntriesForProfile")
        let sortDescriptor = NSSortDescriptor(key: "entryDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let profilePredicate = NSPredicate(format: "girlProfile == %@", argumentArray: [selectedProfile!])
        fetchRequest.predicate = profilePredicate
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
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        
        let entry = frc.objectAtIndexPath(indexPath) as! EntriesForProfile
        
        // Configure the cell...
        cell.textLabel?.text = String(entry.entryDate)
        let howHot = entry.hotScore
        let howCrazy = entry.crazyScore
        
        cell.detailTextLabel?.text = "Detail: \(howHot) - \(howCrazy)."
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext.deleteObject(managedObject)
        do {
            try managedObjectContext.save()
        } catch _ {
        }
    }
    
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
