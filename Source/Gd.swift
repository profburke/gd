import CGd

public class Gd {

    public enum GdRasterFont {
    case giant
    case large
    case mediumBold
    case small
    case tiny
    }
    
    public enum DrawingMode {
    case stroke
    case fill
    }
    
    public let size: Size
    private let gdImage: gdImagePtr

    public var lineThickness: Int32 = 1 {
        didSet {
            gdImageSetThickness(gdImage, lineThickness)
        }
    }

    // Low priority TODO: include (or create separate module for ESR's tng (or what's it called) module
    // TODO: init from from image files

    // FIXME: this segfaults
    public init(image: Gd) {
        size = image.size
        gdImage = gdImageClone(image.gdImage)
    }
    
    public init(size: Size) {
        self.size = size
        gdImage = gdImageCreate(size.width, size.height)
    }

    deinit {
        gdImageDestroy(gdImage)
    }

    public subscript(point: Point) -> Int32 {
        get {
            return gdImageGetPixel(gdImage, point.x, point.y)
        }
        set {
            gdImageSetPixel(gdImage, point.x, point.y, newValue)
        }
    }
    
    public func arc(center: Point, size: Size, start: Int, end: Int, color: Int32, mode: DrawingMode) {
        switch mode {
        case .stroke:
            gdImageArc(gdImage, center.x, center.y,
                       size.width, size.height,
                       Int32(start), Int32(end), color)
        case .fill:
            // TODO: deal with additional fill modes
            gdImageFilledArc(gdImage, center.x, center.y,
                             size.width, size.height,
                             Int32(start), Int32(end), color, gdArc)
        }
    }

    public func rectangle(upperLeft: Point, lowerRight: Point, color: Int32, mode: DrawingMode) {
        switch mode {
        case .stroke:
            gdImageRectangle(gdImage, upperLeft.x, upperLeft.y,
                             lowerRight.x, lowerRight.y, color)
        case .fill:
            gdImageFilledRectangle(gdImage, upperLeft.x, upperLeft.y,
                                   lowerRight.x, lowerRight.y, color)
        }
    }

    public func ellipse(center: Point, size: Size, color: Int32, mode: DrawingMode) {
        switch mode {
        case .stroke:
            gdImageEllipse(gdImage, center.x, center.y,
                           size.width, size.height, color)
        case .fill:
            gdImageFilledEllipse(gdImage, center.x, center.y,
                                 size.width, size.height, color)
        }
    }

    // TODO: replace gdImageDashedLine with use of gdSetStyle
    public func line(from: Point, to: Point, color: Int32, dashed: Bool = false) {
        if dashed {
            gdImageDashedLine(gdImage, from.x, from.y, to.x, to.y, color)
        } else {
            gdImageLine(gdImage, from.x, from.y, to.x, to.y, color)
        }
    }
    
    public func string(text: String, upperLeft: Point, color: Int32, font: GdRasterFont) {
        let cPtr = UnsafeMutablePointer<UInt8>(mutating: text)
        let fontPtr: ()->gdFontPtr!
        switch font {
        case .giant:
            fontPtr = gdFontGetGiant
        case .large:
            fontPtr = gdFontGetLarge
        case .mediumBold:
            fontPtr = gdFontGetMediumBold
        case .small:
            fontPtr = gdFontGetSmall
        case .tiny:
            fontPtr = gdFontGetTiny
        }
            
        gdImageString(gdImage, fontPtr(), upperLeft.x, upperLeft.y, cPtr, color)
    }

    // TODO: string "up" function, replace (or add) true type functions?

    // TODO: polygon functions

    // TODO: fill functions
    
    // TODO: this is a little slapdash...
    public func write(to filename: String) -> Int {
        return Int(gdImageFile(gdImage, filename))
    }
    
    // TODO: find a better (safer and more Swiftier) way of handling colors
    // TODO: implement alpha
    public func allocateColor(r: Int32, g: Int32, b: Int32) -> Int32 {
        let color = gdImageColorAllocate(gdImage, r, g, b)
        return color
    }
    
}

// Swift likes Int, so anything that mucks about with Int32, Int16, etc.
// is a drag. The intent of the following two types is to let us blithely
// deal with Ints in Swift-land, while keeping libgd happy...

public struct Point {
    public let x: Int32
    public let y: Int32

    public init(x: Int, y: Int) {
        self.x = Int32(x)
        self.y = Int32(y)
    }
}

public struct Size {
    public let width: Int32
    public let height: Int32

    public init(width: Int, height: Int) {
        self.width = Int32(width)
        self.height = Int32(height)
    }
}

