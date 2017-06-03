import AppKit

final class CocoaDrawingContext: DrawingContext {
    typealias RawValue = CGFloat
    
    func drawPoint(at location: NSPoint, identifier: ObjectIdentifier) {
        NSBezierPath(ovalIn: NSRect(x: location.x - 6, y: location.y - 6, width: 12, height: 12)).fill()
    }
    
    func drawLine(from start: NSPoint, to end: NSPoint, identifier: ObjectIdentifier) {
        let path = NSBezierPath.line(from: start, to: end)
        path.lineWidth = 2
        path.stroke()
    }
    
    func drawCurve(from start: CGPoint, to end: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint, identifier: ObjectIdentifier) {
        let path = NSBezierPath.curve(from: start, to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.lineWidth = 2
        path.stroke()
    }
}
