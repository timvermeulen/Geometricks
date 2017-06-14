protocol NonConstantPolynomial: Polynomial {
    associatedtype Derivative where Derivative: Polynomial, Derivative.Input == Input, Derivative.Output == Output
    
    var derivative: Derivative { get }
    var popped: Derivative { get }
    var shifted: Derivative { get }
}

extension NonConstantPolynomial {
	static var degree: Int {
		return Derivative.degree + 1
	}
	
	func write<Target: TextOutputStream>(to target: inout Target) {
		if !leadingCoefficient.isZero {
			target.write("\(leadingCoefficient) x^\(Self.degree) + ")
		}
		
		popped.write(to: &target)
	}
	
	var criticalPoints: [Input]? {
		return derivative.realRoots
	}
	
	func approximatedRealRoots(error: Output = 1 / 1000) -> [Input]? {
        let criticalPoints = self.criticalPoints ?? []
        let firstCriticalPoint = criticalPoints.first ?? 0
        let lastCriticalPoint = criticalPoints.last ?? 0
        
        let upperBoundIsPositive = leadingCoefficient > 0
        let lowerBoundIsPositive = upperBoundIsPositive == (Self.degree % 2 == 0)
        
        guard !criticalPoints.isEmpty || upperBoundIsPositive != lowerBoundIsPositive else { return nil }
        
        func isZero(_ x: Output) -> Bool {
            return abs(x - 0) < error
        }
        
        func isARoot(_ x: Input) -> Bool {
            return isZero(evaluated(at: x))
        }
        
        func findRoot(between start: Input, and end: Input) -> Input? {
            guard !isARoot(start) && !isARoot(end) && (evaluated(at: start) > 0) != (evaluated(at: end) > 0) else { return nil }
            let isIncreasing = evaluated(at: start) < 0
            
            func _findRoot(between start: Input, and end: Input) -> Input {
                let midPoint = (start + end) / 2
                let value = evaluated(at: midPoint)
                
                if isZero(value) {
                    return midPoint
                } else if (value > 0) == isIncreasing {
                    return _findRoot(between: start, and: midPoint)
                } else {
                    return _findRoot(between: midPoint, and: end)
                }
            }
            
            return _findRoot(between: start, and: end)
        }
        
        let lowerBound: Input = {
            var bound = firstCriticalPoint
            var delta: Input = 1
            
            while (evaluated(at: bound) < 0) == lowerBoundIsPositive {
                bound -= delta
                delta *= 2
            }
            
            return bound
        }()
        
        let upperBound: Input = {
            var bound = lastCriticalPoint
            var delta: Input = 1
            
            while (evaluated(at: bound) < 0) == upperBoundIsPositive {
                bound += delta
                delta *= 2
            }
            
            return bound
        }()
        
        let boundaryRoots = [lowerBound, upperBound].filter(isARoot)
        let criticalRoots = criticalPoints.filter(isARoot)
        let otherRoots = zip([lowerBound] + criticalPoints, criticalPoints + [upperBound]).flatMap { findRoot(between: $0.0, and: $0.1) }
        
        return (boundaryRoots + criticalRoots + otherRoots).sorted()
	}
	
	var realRoots: [Input]? {
		return approximatedRealRoots()
	}
}
