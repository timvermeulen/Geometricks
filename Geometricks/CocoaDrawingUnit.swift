import AppKit

final class CocoaDrawingUnit {
    typealias RawValue = CGFloat
    
    private static let defaultLineWidth: CGFloat = 2
    private static let defaultCurveColor = NSColor.black
    private static let defaultPointRadius: CGFloat = 6
    private static let defaultPointColor = NSColor.black
    
    private var lineWidths: [ObjectIdentifier: CGFloat] = [:]
    private var pointRadii: [ObjectIdentifier: CGFloat] = [:]
    private var colors: [ObjectIdentifier: NSColor] = [:]
    
    private func lineWidth(of identifier: ObjectIdentifier) -> CGFloat {
        return lineWidths[identifier] ?? CocoaDrawingUnit.defaultLineWidth
    }
    
    private func pointRadius(of identifier: ObjectIdentifier) -> CGFloat {
        return pointRadii[identifier] ?? CocoaDrawingUnit.defaultPointRadius
    }
    
    private func curveColor(of identifier: ObjectIdentifier) -> NSColor {
        return colors[identifier] ?? CocoaDrawingUnit.defaultCurveColor
    }
    
    private func pointColor(of identifier: ObjectIdentifier) -> NSColor {
        return colors[identifier] ?? CocoaDrawingUnit.defaultPointColor
    }
    
    func setLineWidth(_ width: CGFloat, of line: Line<CGFloat>) {
        lineWidths[ObjectIdentifier(line)] = width
    }
    
    func setPointRadius<P: Point>(_ radius: CGFloat, of point: P) {
        pointRadii[ObjectIdentifier(point)] = radius
    }
    
    func setCurveWidth(_ width: CGFloat, of curve: Curve<CGFloat>) {
        lineWidths[ObjectIdentifier(curve)] = width
    }
    
    func setCurveColor(_ color: NSColor, of curve: Curve<CGFloat>) {
        colors[ObjectIdentifier(curve)] = color
    }
    
    func setPointColor<P: Point>(_ color: NSColor, of point: P) {
        colors[ObjectIdentifier(point)] = color
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
