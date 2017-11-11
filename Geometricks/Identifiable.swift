struct Identifier {
    fileprivate let _identifier: ObjectIdentifier
    
    fileprivate init(_ anyObject: AnyObject) {
        _identifier = ObjectIdentifier(anyObject)
    }
}

extension Identifier: Equatable {
    static func == (left: Identifier, right: Identifier) -> Bool {
        return left._identifier == right._identifier
    }
}

extension Identifier: Hashable {
    var hashValue: Int {
        return _identifier.hashValue
    }
}

protocol Identifiable {
    var identifier: Identifier { get }
}

extension Identifiable where Self: AnyObject {
    var identifier: Identifier {
        return Identifier(self)
    }
}
