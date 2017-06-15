final class ObservableStorage {
	fileprivate var observers: [() -> Observer?]
	
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
			observer()?.update()
		}
	}
}

protocol Observer: class {
	func update()
}

extension Observer {
	func observe(_ observables: Observable...) {
        for observable in observables {
            let closure = { [weak self] in self }
            observable.observableStorage.observers.append(closure)
        }
	}
    
    func stopObserving(_ observables: Observable...) {
        for observable in observables {
            let storage = observable.observableStorage
            storage.observers = storage.observers.filter { $0() !== self }
        }
    }
}

extension Observer where Self: Observable {
	func update() {
		updateObservers()
	}
}
