import SwiftUI

extension ViewExamplesProvider where ViewType: View {
    func usingColorSchemes(_ colorSchemes: [ColorScheme]) -> ViewExamplesFlatMap<Self, some View> {
        return flatMap { view in
            colorSchemes.map {
                view.environment(\.colorScheme, $0)
                    .colorScheme($0)
                    .preferredColorScheme($0)
            }
        }
    }

    func usingLayouts(_ styles: [ViewExamplesLayout]) -> ViewExamplesFlatMap<Self, AnyView> {
        return flatMap { view in
            styles.map {
                switch $0 {
                case .device(let device, let orientation):
                    return AnyView(
                        view.previewLayout(.device)
                            .previewDevice(.init(device))
                            .previewInterfaceOrientation(.init(orientation: orientation))
                    )
                case .sizeThatFits:
                    return AnyView(view.previewLayout(.sizeThatFits))
                case .fixed(let width, let height, _, _):
                    return AnyView(
                        view.frame(width: width, height: height)
                            .previewLayout(.sizeThatFits)
                    )
                }
            }
        }
    }

    func previews(
        layouts: [ViewExamplesLayout] = [.sizeThatFits],
        colorSchemes: [ColorScheme] = [.light, .dark],
        addNavigationView: Bool = false
    ) -> some View {
        let views = usingLayouts(layouts)
            .usingColorSchemes(colorSchemes)
            .views

        return Group {
            ForEach(0..<views.count, id: \.self) { offset in
                if addNavigationView {
                    NavigationView {
                        views[offset]
                    }
                } else {
                    views[offset]
                }
            }
        }
    }
}

extension SwiftUI.PreviewDevice {
    init(_ device: ViewExamplesLayout.Device) {
        self.init(rawValue: device.rawValue)
    }
}

extension SwiftUI.InterfaceOrientation {
    init(orientation: ViewExamplesLayout.Orientation) {
        switch orientation {
        case .portrait:
            self = .portrait
        case .landscape:
            self = .landscapeLeft
        }
    }
}
