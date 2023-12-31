import SwiftUI

// MARK: ViewModel

struct CustomIndexViewModel {
    let selectedIndex: Int
    let numberOfPages: Int
}

// MARK: - View

struct CustomIndexView: View {
    let model: CustomIndexViewModel

    var body: some View {
        HStack(spacing: Static.Layout.dotSpacing) {
            ForEach(0..<model.numberOfPages, id: \.self) { index in
                if shouldShowIndex(index) {
                    Circle()
                        .fill(color(for: index))
                        .frame(width: Static.Layout.dotSize, height: Static.Layout.dotSize)
                }
            }
        }
        .padding(EdgeInsets(
            top: Static.Layout.dotVerticalInsets,
            leading: Static.Layout.dotHorizontalInsets,
            bottom: Static.Layout.dotVerticalInsets,
            trailing: Static.Layout.dotHorizontalInsets
        ))
        .background(Static.Color.background)
        .clipShape(.rect(cornerRadius: Static.Layout.cornerRadius))
    }

    // MARK: Private

    private func shouldShowIndex(_ index: Int) -> Bool {
        var start: Int
        var end: Int

        if model.selectedIndex == 0 {
            start = model.selectedIndex
            end = Static.maxNumberOfIndexDots - 1
        } else if model.selectedIndex == model.numberOfPages - 1 {
            start = model.numberOfPages - Static.maxNumberOfIndexDots
            end = model.selectedIndex
        } else {
            start = model.selectedIndex - Static.showingIndexOffset
            end = model.selectedIndex + Static.showingIndexOffset

            if start < 0 {
                end += 1
            } else if end > model.numberOfPages - 1 {
                start -= 1
            }
        }

        return (start...end).contains(index)
    }

    private func color(for index: Int) -> Color {
        if model.selectedIndex == index {
            return Static.Color.dot
        } else {
            let distance = abs(index - model.selectedIndex)

            switch distance {
            case 1:
                return Static.Color.dot.opacity(Static.dotOpacity1)
            case 2:
                return Static.Color.dot.opacity(Static.dotOpacity2)
            case 3:
                return Static.Color.dot.opacity(Static.dotOpacity3)
            case 4:
                return Static.Color.dot.opacity(Static.dotOpacity4)

            default:
                assertionFailure()
                return Color.clear
            }
        }
    }

    // MARK: Constants

    private enum Static {
        enum Layout {
            static let dotSpacing: CGFloat = 5
            static let dotSize: CGFloat = 7
            static let dotVerticalInsets: CGFloat = 5
            static let dotHorizontalInsets: CGFloat = 10

            static let cornerRadius: CGFloat = 5
        }

        enum Color {
            static let dot = Assets.Colors.Index.dot.swiftUIColor
            static let background = Assets.Colors.Index.background.swiftUIColor
        }

        static let showingIndexOffset = 2
        static let maxNumberOfIndexDots = 5

        static let dotOpacity1 = 0.22
        static let dotOpacity2 = 0.17
        static let dotOpacity3 = 0.1
        static let dotOpacity4 = 0.05
    }
}

// MARK: - Preview

extension CustomIndexViewModel {
    enum Examples {
        static let firstIndex = CustomIndexViewModel(selectedIndex: 0, numberOfPages: 6)
        static let middleIndex = CustomIndexViewModel(selectedIndex: 2, numberOfPages: 6)
        static let lastIndex = CustomIndexViewModel(selectedIndex: 5, numberOfPages: 6)
    }
}

extension CustomIndexView {
    struct Examples: ViewExamplesProvider {
        let views: [CustomIndexView] = [
            CustomIndexView(model: .Examples.firstIndex),
            CustomIndexView(model: .Examples.middleIndex),
            CustomIndexView(model: .Examples.lastIndex)
        ]
    }
}

struct CustomIndexView_Previews: PreviewProvider {
    private static let examples = CustomIndexView.Examples()
    static var previews: some View {
        examples.previews(colorSchemes: [.light])
    }
}
