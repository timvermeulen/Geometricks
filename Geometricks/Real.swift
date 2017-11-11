protocol Real: FloatingPoint {
    var sin: Self { get }
    var cos: Self { get }
    var tan: Self { get }
    
    var asin: Self { get }
    var acos: Self { get }
    var atan: Self { get }
    
    func cubeRoot() -> Self
    func atan2(_ x: Self) -> Self
    
    static var pi: Self { get }
    static var tau: Self { get }
}

extension Real {
    func mod(_ x: Self) -> Self {
        let rem = remainder(dividingBy: x)
        return rem < 0 ? rem + x : rem
    }
    
    func squared() -> Self {
        return self * self
    }
}
