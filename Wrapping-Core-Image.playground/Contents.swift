//: Playground - noun: a place where people can play

import Cocoa

typealias Filter = CIImage -> CIImage

/*
func myFilter(/*parameters*/) -> Filter {
    
}
*/

// 模糊
func blur(radius: Double) -> Filter {
    return { image in
        let parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
        
    }
}

// 颜色叠层
// 1. 颜色生成
func colorGenerator(color: NSColor) -> Filter {
    return {_ in
        guard let c = CIColor(color: color) else { fatalError() }
        let parameters = [kCIInputColorKey: c]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
    }
}