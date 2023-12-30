import Foundation

enum ViewExamplesLayout: RawRepresentable {
    typealias RawValue = String

    enum Device: String {
        case iPhoneSE = "iPhone SE (1st generation)"
        case iPhone8 = "iPhone 8"
        case iPhone13 = "iPhone 13"
        case iPhone13Mini = "iPhone 13 mini"
        case iPhone13ProMax = "iPhone 13 Pro Max"
    }

    enum Orientation: String {
        case landscape
        case portrait
    }

    case device(Device, Orientation = .portrait)
    case sizeThatFits
    case fixed(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        layoutDevice: Device? = nil,
        orientation: Orientation? = .portrait
    )

    init?(rawValue: String) {
        assertionFailure()
        return nil
    }

    var rawValue: String {
        switch self {
        case .device(let device, let orientation):
            let orientationSuffix = orientation == .landscape ? "-landscape" : ""
            return "device-\(device)\(orientationSuffix)"
        case .sizeThatFits:
            return "sizeThatFits"
        case .fixed(width: let width, height: let height, _, let orientation):
            let widthLabel = width.map { String(format: "%.0f", $0) } ?? "any"
            let heightLabel = height.map { String(format: "%.0f", $0) } ?? "any"
            let orientationSuffix = orientation == .landscape ? "-landscape" : ""

            return "fixed-\(widthLabel)-\(heightLabel)\(orientationSuffix)"
        }
    }
}

extension ViewExamplesLayout.Device {
    var size: CGSize {
        switch self {
        case .iPhoneSE:
            return CGSize(width: 320, height: 568)
        case .iPhone8:
            return CGSize(width: 375, height: 667)
        case .iPhone13:
            return CGSize(width: 390, height: 844)
        case .iPhone13Mini:
            return CGSize(width: 375, height: 812)
        case .iPhone13ProMax:
            return CGSize(width: 428, height: 926)
        }
    }
}

extension ViewExamplesLayout {
    static func fixedWidth(_ device: Device, orientation: Orientation = .portrait) -> ViewExamplesLayout {
        return .fixed(
            width: device.size.width,
            height: nil,
            layoutDevice: device,
            orientation: orientation
        )
    }
}

extension ViewExamplesLayout {
    static func fixed(
        size: CGSize,
        device: Device = .iPhone8,
        orientation: Orientation = .portrait
    ) -> ViewExamplesLayout {
        return .fixed(
            width: size.width,
            height: size.height,
            layoutDevice: device,
            orientation: orientation
        )
    }
}
