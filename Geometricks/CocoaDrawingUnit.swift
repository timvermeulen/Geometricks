import AppKit

final class CocoaDrawingUnit {
    typealias RawValue = CGFloat
    
    private let defaultStrokeWidth: CGFloat
    private let defaultPointRadius: CGFloat
	private let defaultStrokeColor: NSColor
    private let defaultFillColor: NSColor
	
    init(defaultStrokeWidth: CGFloat = 2, defaultStrokeColor: NSColor = .black, defaultPointRadius: CGFloat = 6, defaultFillColor: NSColor = .white) {
        self.defaultStrokeWidth = defaultStrokeWidth
        self.defaultStrokeColor = defaultStrokeColor
        self.defaultPointRadius = defaultPointRadius
        self.defaultFillColor = defaultFillColor
    }
    
    private var strokeWidths: [Identifier: CGFloat] = [:]
    private var pointRadii:   [Identifier: CGFloat] = [:]
    private var strokeColors: [Identifier: NSColor] = [:]
    private var fillColors:   [Identifier: NSColor] = [:]
}

extension CocoaDrawingUnit {
	private func strokeWidth(of identifier: Identifier) -> CGFloat {
		return strokeWidths[identifier] ?? defaultStrokeWidth
	}
	
	func strokeWidth<T: Identifiable>(of x: T) -> CGFloat {
		return strokeWidth(of: x.identifier)
	}
	
	func setStrokeWidth<T: Identifiable>(_ width: CGFloat, of x: T) {
		strokeWidths[x.identifier] = width
	}
}

extension CocoaDrawingUnit {
	private func pointRadius(of identifier: Identifier) -> CGFloat {
		return pointRadii[identifier] ?? defaultPointRadius
	}
	
	func pointRadius<P: Point>(of point: P) -> CGFloat {
		return pointRadius(of: point.identifier)
	}
	
	func setPointRadius<P: Point>(_ radius: CGFloat, of point: P) {
		pointRadii[point.identifier] = radius
	}
}

extension CocoaDrawingUnit {
	private func strokeColor(of identifier: Identifier) -> NSColor {
		return strokeColors[identifier] ?? defaultStrokeColor
	}
	
	func strokeColor<T: Identifiable>(of x: T) -> NSColor {
		return strokeColor(of: x.identifier)
	}
	
	func setStrokeColor<T: Identifiable>(_ color: NSColor, of x: T) {
		strokeColors[x.identifier] = color
	}
}

extension CocoaDrawingUnit {
	private func fillColor(of identifier: Identifier) -> NSColor {
		return fillColors[identifier] ?? defaultFillColor
	}
	
	func fillColor<T: Identifiable>(of x: T) -> NSColor {
		return fillColor(of: x.identifier)
	}
	
	func setFillColor<T: Identifiable>(_ color: NSColor, of x: T) {
		fillColors[x.identifier] = color
	}
}

extension CocoaDrawingUnit: DrawingUnit {
    func drawPoint(at location: NSPoint, identifier: Identifier) {
        strokeColor(of: identifier).setStroke()
        fillColor(of: identifier).setFill()
        
        let radius = pointRadius(of: identifier)
        let path = NSBezierPath(ovalIn: NSRect(x: location.x - radius, y: location.y - radius, width: radius * 2, height: radius * 2))
        path.lineWidth = strokeWidth(of: identifier)
        
        path.fill()
        path.stroke()
    }
	
	func drawLine(from start: NSPoint, to end: NSPoint, identifier: Identifier) {
		strokeColor(of: identifier).setStroke()
		
		let path = NSBezierPath.line(from: start, to: end)
		path.lineWidth = strokeWidth(of: identifier)
		path.stroke()
	}
    
    func drawCurve(from start: NSPoint, to end: NSPoint, controlPoint1: NSPoint, controlPoint2: NSPoint, identifier: Identifier) {
		strokeColor(of: identifier).setStroke()
		
        let path = NSBezierPath.curve(from: start, to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.lineWidth = strokeWidth(of: identifier)
        path.stroke()
    }
	
	func drawCircle(center: NSPoint, radius: CGFloat, identifier: Identifier) {
		strokeColor(of: identifier).setStroke()
		
		let path = NSBezierPath(ovalIn: NSRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
		path.lineWidth = strokeWidth(of: identifier)
		path.stroke()
	}
    
    func drawCircleCircleIntersectionArea(center0: CGPoint, radius0: CGFloat, startAngle0: CGFloat, endAngle0: CGFloat, center1: CGPoint, radius1: CGFloat, startAngle1: CGFloat, endAngle1: CGFloat, identifier: Identifier) {
        fillColor(of: identifier).setFill()
        
        let path = NSBezierPath()
        path.appendArc(withCenter: center0, radius: radius0, startAngle: startAngle0, endAngle: startAngle1)
        path.appendArc(withCenter: center1, radius: radius1, startAngle: startAngle0, endAngle: endAngle1)
        path.fill()
    }
}
