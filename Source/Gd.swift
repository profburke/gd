import CGd

public class Gd {

    let width: Int32
    let height: Int32
    let im: gdImagePtr

    let black: Int32
    let red: Int32
    let yellow: Int32

    // var lineThickness: Int32 = 1 {
    //     didSet {
    //         gdImageSetThickness(im, lineThickness)
    //     }
    // }
    
    public init(width: Int32, height: Int32) {
        self.width = width
        self.height = height
        im = gdImageCreate(width, height)

        black = gdImageColorAllocate(im, 0, 0, 0)
        red = gdImageColorAllocate(im, 255, 0, 0)
        yellow = gdImageColorAllocate(im, 255, 255, 0)
    }

    // public func drawArc(cx: Int32, cy: Int32, w: Int32, h: Int32,
    //                s: Int32, e: Int32, color: Int32 = red) {
    //     gdImageArc(im, cx, cy, w, h, s, e, color)
    // }

    // public func drawString(text: String, x: Int32, y: Int32, color: Int32 = yellow) {
    //     let cString = text.cString(using: NSASCIIStringEncoding)!
    //     let cPtr = UnsafeMutablePointer<UInt8>(cString)
    //     gdImageString(im, gdFontGetMediumBold(), x, y, cPtr, color)
    // }

    // public func pngPtr() -> (C7.Data, Int32) {
    //     var size: Int32 = 0
    //     let p = gdImagePngPtr(im, &size)
    //     let buffer = UnsafeBufferPointer<Byte>(start: UnsafePointer(p), count: Int(size))
    //     let bytes = Array<Byte>(buffer)
    //     let data = Data(bytes)
    //     gdFree(p)
    //     return (data, size)
    // }

    // deinit {
    //     gdImageDestroy(im)
    // }
    
}
