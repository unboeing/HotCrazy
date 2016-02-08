//
//  EntriesForProfile.swift
//  
//
//  Created by Bufni on 9/14/15.
//
//

import Foundation
import CoreData


class EntriesForProfile: NSManagedObject {

    @NSManaged var hotScore: NSNumber
    @NSManaged var crazyScore: NSNumber
    @NSManaged var entryDate: NSDate
    @NSManaged var girlProfile: NSManagedObject

    class func createInManagedObjectContext(moc: NSManagedObjectContext, hotGrade: Double, crazyGrade: Double, recordDate: NSDate) -> EntriesForProfile {
        let newEntryForProfile = NSEntityDescription.insertNewObjectForEntityForName("EntriesForProfile", inManagedObjectContext: moc) as! EntriesForProfile
        newEntryForProfile.hotScore = hotGrade
        newEntryForProfile.crazyScore = crazyGrade
        newEntryForProfile.entryDate = recordDate
        
        
        return newEntryForProfile
    }

}
