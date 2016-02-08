//
//  GirlProfile.swift
//  
//
//  Created by Bufni on 9/14/15.
//
//

import UIKit
import Foundation
import CoreData


class GirlProfile: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phoneNumber: String
    @NSManaged var entriesForProfile: NSSet
    
/*    class func createInManagedObjectContext(moc: NSManagedObjectContext, firstN: String, lastN: String, phoneNo: String) -> GirlProfile {
        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        let newGirlProfile = NSEntityDescription.insertNewObjectForEntityForName("GirlProfile", inManagedObjectContext: moc) as! GirlProfile
        newGirlProfile.firstName = firstN
        newGirlProfile.lastName = lastN
        newGirlProfile.phoneNumber = phoneNo
        
        
        return newGirlProfile
    }
*/

}
