protocol Polynomial: TextOutputStreamable {
    associatedtype Input: Real
    associatedtype Output: Real
    
    static var degree: Int { get }
	func evaluated(at x: Input) -> Output
	
    var realRoots: [Input]? { get }
    var leadingCoefficient: Input { get }
    var constant: Input { get }
}
