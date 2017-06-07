final class ObservableStorage {
	fileprivate var observers: [Observer]
	
	init() {
		observers = []
	}
}

protocol Observable {
	var observableStorage: ObservableStorage { get }
}

extension Observable {
	func updateObservers() {
		for observer in observableStorage.observers {
			observer.update()
		}
	}
	
	func keepUpdated(_ other: Observer) {
		observableStorage.observers.append(other)
	}
}

protocol Observer {
	func update()
}
