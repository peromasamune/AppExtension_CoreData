//
//  MemoEntity.swift
//  AppExtensiton_CoreData
//
//  Created by Taku Inoue on 2015/12/09.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit
import CoreData

public class ACMemoEntity: NSManagedObject {
    @NSManaged public var title : String
    @NSManaged public var date : NSTimeInterval
}
