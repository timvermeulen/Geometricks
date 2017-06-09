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
}

protocol Observer {
	func update()
}

extension Observer {
	func observe(_ observables: Observable...) {
		observables.forEach { $0.observableStorage.observers.append(self) }
	}
}

extension Observer where Self: Observable {
	func update() {
		updateObservers()
	}
}
