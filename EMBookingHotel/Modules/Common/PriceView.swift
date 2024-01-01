import SwiftUI
import Foundation

// MARK: ViewModel

struct PriceViewModel {
    enum PriceType {
        case minimalPrice(price: Int, description: String)
        case price(price: Int, description: String)
    }

    let info: PriceType
    let formatter = NumberFormatter.currencyFormatter()
}

// MARK: View

struct PriceView: View {
    let model: PriceViewModel

    var body: some View {
        switch model.info {
        case .minimalPrice(let price, let description):
            HStack(alignment: .lastTextBaseline, spacing: Static.spacing) {
                priceView(price, isMinimal: true)
                descriptionView(description)
            }

        case .price(let price, let description):
            HStack(alignment: .lastTextBaseline, spacing: Static.spacing) {
                priceView(price, isMinimal: false)
                descriptionView(description)
            }
        }
    }

    // MARK: Private

    @ViewBuilder
    private func priceView(_ price: Int, isMinimal: Bool) -> some View {
        Text(formatPrice(price, isMinimal: isMinimal))
            .lineLimit(Static.lineLimit)
            .foregroundStyle(Static.Color.price)
            .font(Static.Font.price)
    }

    @ViewBuilder
    private func descriptionView(_ description: String) -> some View {
        Text(description)
            .lineLimit(Static.lineLimit)
            .foregroundStyle(Static.Color.description)
            .font(Static.Font.description)
    }

    private func formatPrice(_ price: Int, isMinimal: Bool) -> String {
        var formattedPrice = model.formatter.string(from: price as NSNumber) ?? String(price)

        if isMinimal {
            formattedPrice = "\(Strings.Common.pretextFrom) \(formattedPrice)"
        }

        return formattedPrice
    }

    // MARK: Constants

    private enum Static {
        enum Color {
            static let price = Assets.Colors.Text.primary.swiftUIColor
            static let description = Assets.Colors.Text.secondary.swiftUIColor
        }

        enum Font {
            static let price = Fonts.Price.primary
            static let description = Fonts.textRegular
        }

        static let spacing: CGFloat = 8
        static let lineLimit = 1
    }
}

// MARK: - Preview

extension PriceViewModel {
    enum Examples {
        static let normalMinimalPrice = PriceViewModel(
            info: .minimalPrice(price: .Examples.Price.normal, description: .Examples.Text.normal)
        )
        static let longMinimalPrice = PriceViewModel(
            info: .minimalPrice(price: .Examples.Price.long, description: .Examples.Text.medium)
        )
        static let normalPrice = PriceViewModel(
            info: .price(price: .Examples.Price.normal, description: .Examples.Text.normal)
        )
        static let longPrice = PriceViewModel(
            info: .price(price: .Examples.Price.long, description: .Examples.Text.medium)
        )
    }
}

extension PriceView {
    struct Examples: ViewExamplesProvider {
        let views: [PriceView] = [
            PriceView(model: .Examples.normalMinimalPrice),
            PriceView(model: .Examples.longMinimalPrice),
            PriceView(model: .Examples.normalPrice),
            PriceView(model: .Examples.longPrice)
        ]
    }
}

struct PriceView_Previews: PreviewProvider {
    private static let examples = PriceView.Examples()
    static var previews: some View {
        examples.previews(colorSchemes: [.light])
    }
}
