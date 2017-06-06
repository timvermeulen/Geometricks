import AppKit

final class CocoaDrawingUnit {
    typealias RawValue = CGFloat
    
    // TODO: add to init
    private static let defaultLineWidth: CGFloat = 2
    private static let defaultCurveColor = NSColor.black
    private static let defaultPointRadius: CGFloat = 6
    private static let defaultPointColor = NSColor.black
    
    private var lineWidths: [ObjectIdentifier: CGFloat] = [:]
    private var pointRadii: [ObjectIdentifier: CGFloat] = [:]
    private var colors: [ObjectIdentifier: NSColor] = [:]
}

extension CocoaDrawingUnit {
    func setLineWidth(_ width: CGFloat, of line: Line<CGFloat>) {
        lineWidths[ObjectIdentifier(line)] = width
    }
    
    private func lineWidth(of identifier: ObjectIdentifier) -> CGFloat {
        return lineWidths[identifier] ?? CocoaDrawingUnit.defaultLineWidth
    }
    
    func lineWidth(of line: Line<CGFloat>) -> CGFloat {
        return lineWidth(of: ObjectIdentifier(line))
    }
}

extension CocoaDrawingUnit {
    func setPointRadius<P: Point>(_ radius: CGFloat, of point: P) {
        pointRadii[point.identifier] = radius
    }
    
    private func pointRadius(of identifier: ObjectIdentifier) -> CGFloat {
        return pointRadii[identifier] ?? CocoaDrawingUnit.defaultPointRadius
    }
    
    func pointRadius<P: Point>(of point: P) -> CGFloat {
        return pointRadius(of: point.identifier)
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
        colors[ObjectIdentifier(curve)] = color
    }
    
    private func curveColor(of identifier: ObjectIdentifier) -> NSColor {
        return colors[identifier] ?? CocoaDrawingUnit.defaultCurveColor
    }
    
    func curveColor(of curve: Curve<CGFloat>) -> NSColor {
        return curveColor(of: ObjectIdentifier(curve))
    }
}

extension CocoaDrawingUnit {
    func setPointColor<P: Point>(_ color: NSColor, of point: P) {
        colors[point.identifier] = color
    }
    
    private func pointColor(of identifier: ObjectIdentifier) -> NSColor {
        return colors[identifier] ?? CocoaDrawingUnit.defaultPointColor
    }
    
    func pointColor<P: Point>(of point: P) -> NSColor {
        return pointColor(of: point.identifier)
    }
}

extension CocoaDrawingUnit: DrawingUnit {
    func drawPoint(at location: NSPoint, identifier: ObjectIdentifier) {
        let radius = pointRadius(of: identifier)
        pointColor(of: identifier).setFill()
        NSBezierPath(ovalIn: NSRect(x: location.x - radius, y: location.y - radius, width: radius * 2, height: radius * 2)).fill()
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
