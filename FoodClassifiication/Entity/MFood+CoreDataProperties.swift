//
//  MFood+CoreDataProperties.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 14.06.2023.
//
//

import Foundation
import CoreData


extension MFood {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<MFood> {
		return NSFetchRequest<MFood>(entityName: "MFood")
	}

	@NSManaged public var id: Int64
	@NSManaged public var url: String
	@NSManaged public var foods: [String: [String]]
	@NSManaged public var recommendations: [String: [String]]

}

extension MFood : Identifiable {

}
