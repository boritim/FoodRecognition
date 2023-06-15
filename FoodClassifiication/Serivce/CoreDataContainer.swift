//
//  CoreDataContainer.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 6.06.2023.
//

import CoreData
import UIKit

final class CoreDataContainer {

	private lazy var container: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "FoodClassifiication")
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()

	private(set) lazy var viewContext = {
		return container.viewContext
	}()

	func fetch<T, R>(_ request: NSFetchRequest<T>, convert: (T) -> R?) -> [R] {
		var result: [R] = []
		let readContext = container.newBackgroundContext()
		readContext.performAndWait {
			do {
				let response = try fetch(request, context: readContext)
				result = response.compactMap(convert)
			} catch { print(error.localizedDescription) }
		}
		return result
	}

	func perfom(_ context: (NSManagedObjectContext) -> Void) {
		let writeContext = container.viewContext
		writeContext.performAndWait {
			context(writeContext)
			do {
				try writeContext.save()
			} catch { print(error.localizedDescription) }
		}
	}

	private func fetch<T>(_ request: NSFetchRequest<T>, context: NSManagedObjectContext) throws -> [T] {
		return try context.fetch(request)
	}

	func savePhoto(image: UIImage, id: Int64) {
		
	}

	private func documentDirectoryPath() -> URL? {
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return path.first
	}
}
