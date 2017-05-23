import AppKit

extension NSBezierPath {
    static func line(from start: NSPoint, to end: NSPoint) -> NSBezierPath {
        let path = NSBezierPath()
        path.move(to: start)
        path.line(to: end)
        return path
    }
    
    static func curve(from start: NSPoint, to end: NSPoint, controlPoint1: NSPoint, controlPoint2: NSPoint) -> NSBezierPath {
        let path = NSBezierPath()
        path.move(to: start)
        path.curve(to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return path
    }
}
