import SwiftUI

// MARK: ViewModel

struct PeculiaritiesViewModel {
    let peculiarities: [String]
    let shouldShowMoreButton: Bool

    init(peculiarities: [String], shouldShowMoreButton: Bool = false) {
        self.peculiarities = peculiarities
        self.shouldShowMoreButton = shouldShowMoreButton
    }
}

// MARK: - View

struct PeculiaritiesView: View {
    let model: PeculiaritiesViewModel

    var body: some View {
        FlowLayout(alignment: .leading, spacing: Static.spacing) {
            ForEach(model.peculiarities, id: \.self) { text in
                gridItem(text)
            }

            if model.shouldShowMoreButton {
                moreButton()
            }
        }
    }

    // MARK: Private

    @ViewBuilder
    private func gridItem(_ text: String) -> some View {
        InfoSignsView(model: InfoSignsViewModel(info: .info(text)))
    }

    @ViewBuilder
    private func moreButton() -> some View {
        ActionButtonView(model: ActionButtonViewModel(info: .textWithChevron(Strings.Room.Button.more)))
    }

    // MARK: Constants

    private enum Static {
        static let spacing: CGFloat = 8
    }
}

// MARK: - Preview

extension PeculiaritiesViewModel {
    enum Examples {
        static let normal = PeculiaritiesViewModel(
            peculiarities: .Examples.arrayOfSomeText
        )
        static let normalWithMoreButton = PeculiaritiesViewModel(
            peculiarities: .Examples.arrayOfSomeText,
            shouldShowMoreButton: true
        )
    }
}

extension PeculiaritiesView {
    struct Examples: ViewExamplesProvider {
        let views: [PeculiaritiesView] = [
            PeculiaritiesView(model: .Examples.normal),
            PeculiaritiesView(model: .Examples.normalWithMoreButton)
        ]
    }
}

struct PeculiaritiesView_Previews: PreviewProvider {
    private static let examples = PeculiaritiesView.Examples()
    static var previews: some View {
        examples.previews(colorSchemes: [.light])
    }
}
