import AppKit

final class CocoaDrawingContext: DrawingContext {
    typealias RawValue = CGFloat
    
    func drawPoint(at location: NSPoint) {
        NSBezierPath(ovalIn: NSRect(x: location.x - 6, y: location.y - 6, width: 12, height: 12)).fill()
    }
    
    func drawLine(from start: NSPoint, to end: NSPoint) {
        let path = NSBezierPath()
        path.move(to: start)
        path.line(to: end)
        path.lineWidth = 2
        path.stroke()
    }
}
