import AppKit

final class CocoaDrawingUnit {
    typealias RawValue = CGFloat
    
    private let defaultLineWidth: CGFloat
    private let defaultCurveColor: NSColor
    private let defaultPointRadius: CGFloat
    private let defaultPointBorderWidth: CGFloat
    private let defaultPointBorderColor: NSColor
    private let defaultPointFillColor: NSColor
    
    init(defaultLineWidth: CGFloat = 2, defaultCurveColor: NSColor = .black, defaultPointRadius: CGFloat = 6, defaultPointBorderWidth: CGFloat = 1, defaultPointBorderColor: NSColor = .black, defaultPointFillColor: NSColor = .white) {
        self.defaultLineWidth = defaultLineWidth
        self.defaultCurveColor = defaultCurveColor
        self.defaultPointRadius = defaultPointRadius
        self.defaultPointBorderWidth = defaultPointBorderWidth
        self.defaultPointBorderColor = defaultPointBorderColor
        self.defaultPointFillColor = defaultPointFillColor
    }
    
    private var lineWidths:   [ObjectIdentifier: CGFloat] = [:]
    private var pointRadii:   [ObjectIdentifier: CGFloat] = [:]
    private var strokeColors: [ObjectIdentifier: NSColor] = [:]
    private var fillColors:   [ObjectIdentifier: NSColor] = [:]
}

extension CocoaDrawingUnit {
    func setLineWidth(_ width: CGFloat, of line: Line<CGFloat>) {
        lineWidths[ObjectIdentifier(line)] = width
    }
    
    private func lineWidth(of identifier: ObjectIdentifier) -> CGFloat {
        return lineWidths[identifier] ?? defaultLineWidth
    }
    
    func lineWidth(of line: Line<CGFloat>) -> CGFloat {
        return lineWidth(of: ObjectIdentifier(line))
    }
}

extension CocoaDrawingUnit {
    func setCurveWidth(_ width: CGFloat, of curve: Curve<CGFloat>) {
        lineWidths[ObjectIdentifier(curve)] = width
    }
    
    func curveWidth(of curve: Curve<CGFloat>) -> CGFloat {
        return lineWidth(of: ObjectIdentifier(curve))
    }
}

extension CocoaDrawingUnit {
    func setCurveColor(_ color: NSColor, of curve: Curve<CGFloat>) {
        strokeColors[ObjectIdentifier(curve)] = color
    }
    
    private func curveColor(of identifier: ObjectIdentifier) -> NSColor {
        return strokeColors[identifier] ?? defaultCurveColor
    }
    
    func curveColor(of curve: Curve<CGFloat>) -> NSColor {
        return curveColor(of: ObjectIdentifier(curve))
    }
}

extension CocoaDrawingUnit {
    func setPointRadius<P: Point>(_ radius: CGFloat, of point: P) {
        pointRadii[point.identifier] = radius
    }
    
    private func pointRadius(of identifier: ObjectIdentifier) -> CGFloat {
        return pointRadii[identifier] ?? defaultPointRadius
    }
    
    func pointRadius<P: Point>(of point: P) -> CGFloat {
        return pointRadius(of: point.identifier)
    }
}

extension CocoaDrawingUnit {
    func setPointBorderWidth<P: Point>(_ width: CGFloat, of point: P) {
        lineWidths[point.identifier] = width
    }
    
    private func pointBorderWidth(of identifier: ObjectIdentifier) -> CGFloat {
        return lineWidths[identifier] ?? defaultPointBorderWidth
    }
    
    func pointBorderWidth<P: Point>(of point: P) -> CGFloat {
        return pointBorderWidth(of: point.identifier)
    }
}

extension CocoaDrawingUnit {
    func setPointBorderColor<P: Point>(_ color: NSColor, of point: P) {
        strokeColors[point.identifier] = color
    }
    
    private func pointBorderColor(of identifier: ObjectIdentifier) -> NSColor {
        return strokeColors[identifier] ?? defaultPointBorderColor
    }
    
    func pointBorderColor<P: Point>(of point: P) -> NSColor {
        return pointBorderColor(of: point.identifier)
    }
}

extension CocoaDrawingUnit {
    func setPointFillColor<P: Point>(_ color: NSColor, of point: P) {
        fillColors[point.identifier] = color
    }
    
    private func pointFillColor(of identifier: ObjectIdentifier) -> NSColor {
        return fillColors[identifier] ?? defaultPointFillColor
    }
    
    func pointFillColor<P: Point>(of point: P) -> NSColor {
        return pointFillColor(of: point.identifier)
    }
}

extension CocoaDrawingUnit: DrawingUnit {
    func drawPoint(at location: NSPoint, identifier: ObjectIdentifier) {
        pointBorderColor(of: identifier).setStroke()
        pointFillColor(of: identifier).setFill()
        
        let radius = pointRadius(of: identifier)
        let path = NSBezierPath(ovalIn: NSRect(x: location.x - radius, y: location.y - radius, width: radius * 2, height: radius * 2))
        path.lineWidth = pointBorderWidth(of: identifier)
        
        path.fill()
        path.stroke()
    }
    
    func drawLine(from start: NSPoint, to end: NSPoint, identifier: ObjectIdentifier) {
        let path = NSBezierPath.line(from: start, to: end)
        path.lineWidth = lineWidth(of: identifier)
        path.stroke()
    }
    
    func drawCurve(from start: CGPoint, to end: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint, identifier: ObjectIdentifier) {
        let path = NSBezierPath.curve(from: start, to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.lineWidth = lineWidth(of: identifier)
        curveColor(of: identifier).setStroke()
        path.stroke()
    }
}
