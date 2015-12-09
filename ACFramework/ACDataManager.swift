//
//  ACDataManager.swift
//  AppExtensiton_CoreData
//
//  Created by Taku Inoue on 2015/12/09.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit
import CoreData

public class ACDataManager: NSObject {
    public static func createMemo(title : String) {
        let context = ACCoreDataMamager.sharedInstance.managedObjectContext
        let entity : NSEntityDescription = NSEntityDescription.entityForName("Memo", inManagedObjectContext: context!)!

        var memo : ACMemoEntity = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context!) as! ACMemoEntity
        memo.title = title
        memo.date = NSDate().timeIntervalSince1970

        ACCoreDataMamager.sharedInstance.saveContext()
    }

    public static func getMemo() -> Array<ACMemoEntity>{

        let fetchRequest : NSFetchRequest = NSFetchRequest()
        let context = ACCoreDataMamager.sharedInstance.managedObjectContext
        let entity : NSEntityDescription = NSEntityDescription.entityForName("Memo", inManagedObjectContext: context!)!
        fetchRequest.entity = entity

        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors

        var result : Array<ACMemoEntity> = Array()
        var error : NSError? = nil
        if let sortedArray = context?.executeFetchRequest(fetchRequest, error: &error){
            for object in sortedArray {
                if let memo = object as? ACMemoEntity{
                    result.append(memo)
                }
            }
        }

        return result
    }
}
