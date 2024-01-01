import SwiftUI

// MARK: ViewModel

struct HotelMainInfoViewModel {
    let rating: InfoSignsViewModel
    let name: String
    let address: String
}

// MARK: - View
struct HotelMainInfoView: View {
    let model: HotelMainInfoViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: Static.Layout.spacing) {
            InfoSignsView(model: model.rating)
            hotelName
            address
        }
    }

    // MARK: Private

    @ViewBuilder private var hotelName: some View {
        Text(model.name)
            .font(Static.Font.title)
            .foregroundStyle(Static.Color.title)
    }

    @ViewBuilder private var address: some View {
        Button(model.address) {}
            .lineLimit(Static.addressLineLimit)
            .font(Static.Font.address)
            .foregroundStyle(Static.Color.address)
    }

    // MARK: Constants

    private enum Static {
        enum Layout {
            static let spacing: CGFloat = 8
        }

        enum Color {
            static let title = Assets.Colors.Text.primary.swiftUIColor
            static let address = Assets.Colors.Button.Content.secondary.swiftUIColor
        }

        enum Font {
            static let title = Fonts.titleMedium
            static let address = Fonts.bodyMedium
        }

        static let addressLineLimit = 1
    }
}

// MARK: - Preview

extension HotelMainInfoViewModel {
    enum Examples {
        static let normal = HotelMainInfoViewModel(
            rating: .Examples.rating,
            name: .Examples.Text.normal,
            address: .Examples.Text.normal
        )
        static let medium = HotelMainInfoViewModel(
            rating: .Examples.rating,
            name: .Examples.Text.medium,
            address: .Examples.Text.medium
        )
    }
}

extension HotelMainInfoView {
    struct Examples: ViewExamplesProvider {
        let views: [HotelMainInfoView] = [
            HotelMainInfoView(model: .Examples.normal),
            HotelMainInfoView(model: .Examples.medium)
        ]
    }
}

struct HotelMainInfoView_Previews: PreviewProvider {
    private static let examples = HotelMainInfoView.Examples()
    static var previews: some View {
        examples.previews(colorSchemes: [.light])
    }
}
