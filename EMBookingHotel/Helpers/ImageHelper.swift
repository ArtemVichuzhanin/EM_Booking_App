import UIKit
import SwiftUI

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension Color {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> Image {
        Image(uiImage: UIColor(self).image(size))
    }
}
