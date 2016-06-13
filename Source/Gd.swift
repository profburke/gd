import Foundation
import CGd

public typealias Byte = UInt8


public class Gd {

    public let width: Int32
    public let height: Int32
    let im: gdImagePtr

    public let black: Int32
    public let red: Int32
    public let yellow: Int32

    public var lineThickness: Int32 = 1 {
        didSet {
            gdImageSetThickness(im, lineThickness)
        }
    }
    
    public init(width: Int32, height: Int32) {
        self.width = width
        self.height = height
        im = gdImageCreate(width, height)

        black = gdImageColorAllocate(im, 0, 0, 0)
        red = gdImageColorAllocate(im, 255, 0, 0)
        yellow = gdImageColorAllocate(im, 255, 255, 0)
    }

    public func drawArc(cx: Int32, cy: Int32, w: Int32, h: Int32,
                   s: Int32, e: Int32, color: Int32) {
        gdImageArc(im, cx, cy, w, h, s, e, color)
    }

    public func drawString(text: String, x: Int32, y: Int32, color: Int32) {
        let cString = text.cString(using: NSASCIIStringEncoding)!
        let cPtr = UnsafeMutablePointer<UInt8>(cString)
        gdImageString(im, gdFontGetMediumBold(), x, y, cPtr, color)
    }

    public func pngPtr() -> ([Byte], Int32) {
        var size: Int32 = 0
        let p = gdImagePngPtr(im, &size)
        let buffer = UnsafeBufferPointer<Byte>(start: UnsafePointer(p), count: Int(size))
        let bytes = Array<Byte>(buffer)
        gdFree(p)
        return (bytes, size)
    }

    public func allocateColor(r: Int32, g: Int32, b: Int32) -> Int32 {
        let color = gdImageColorAllocate(im, r, g, b)
        return color
    }
    
    deinit {
        gdImageDestroy(im)
    }
    
}
