import AppKit

final class CocoaDrawingContext {
    typealias RawValue = CGFloat
    
    private static let defaultLineWidth: CGFloat = 2
    private static let defaultCurveColor = NSColor.black
    
    private var lineWidths: [ObjectIdentifier: CGFloat] = [:]
    private var colors: [ObjectIdentifier: NSColor] = [:]
    
    private func lineWidth(of identifier: ObjectIdentifier) -> CGFloat {
        return lineWidths[identifier] ?? CocoaDrawingContext.defaultLineWidth
    }
    
    func setLineWidth(_ width: CGFloat, of line: Line<CGFloat>) {
        lineWidths[ObjectIdentifier(line)] = width
    }
    
    func setCurveWidth(_ width: CGFloat, of curve: Curve<CGFloat>) {
        lineWidths[ObjectIdentifier(curve)] = width
    }
    
    private func curveColor(of identifier: ObjectIdentifier) -> NSColor {
        return colors[identifier] ?? CocoaDrawingContext.defaultCurveColor
    }
    
    func setCurveColor(_ color: NSColor, of curve: Curve<CGFloat>) {
        colors[ObjectIdentifier(curve)] = color
    }
}

extension CocoaDrawingContext: DrawingContext {
    func drawPoint(at location: NSPoint, identifier: ObjectIdentifier) {
        NSBezierPath(ovalIn: NSRect(x: location.x - 6, y: location.y - 6, width: 12, height: 12)).fill()
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
