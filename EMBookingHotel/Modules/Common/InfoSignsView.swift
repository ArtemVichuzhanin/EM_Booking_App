import SwiftUI

// MARK: ViewModel

struct InfoSignsViewModel {
    enum InfoType {
        case info(String)
        case rating(Int, String)
    }

    let info: InfoType
}

// MARK: - View

struct InfoSignsView: View {
    let model: InfoSignsViewModel

    var body: some View {
        HStack(spacing: Static.Layout.spacing) {
            content
        }
        .padding(EdgeInsets(
            top: Static.Layout.verticalInset,
            leading: Static.Layout.horizontalInset,
            bottom: Static.Layout.verticalInset,
            trailing: Static.Layout.horizontalInset
        ))
        .foregroundStyle(foregroundColor)
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: Static.Layout.cornerRadius))
    }

    // MARK: Private

    @ViewBuilder private var content: some View {
        switch model.info {
        case .info(let text):
            Text(text)
                .lineLimit(Static.lineLimit)
                .font(Static.Font.text)

        case .rating(let rating, let name):
            Static.starImage
            Text("\(rating) \(name)")
                .lineLimit(Static.lineLimit)
                .font(Static.Font.text)
        }
    }

    private var foregroundColor: Color {
        switch model.info {
        case .info:
            return Static.Color.infoContent
        case .rating:
            return Static.Color.ratingContent
        }
    }

    private var backgroundColor: Color {
        switch model.info {
        case .info:
            return Static.Color.infoBackground
        case .rating:
            return Static.Color.ratingBackground
        }
    }

    // MARK: Constants

    enum Static {
        enum Layout {
            static let spacing: CGFloat = 2
            static let verticalInset: CGFloat = 5
            static let horizontalInset: CGFloat = 10
            static let cornerRadius: CGFloat = 5
        }

        enum Color {
            static let ratingContent = Assets.Colors.Rating.content.swiftUIColor
            static let ratingBackground = Assets.Colors.Rating.background.swiftUIColor

            static let infoContent = Assets.Colors.InfoSigns.content.swiftUIColor
            static let infoBackground = Assets.Colors.InfoSigns.background.swiftUIColor
        }

        enum Font {
            static let text = Fonts.textMedium
        }

        static let starImage = Assets.Icons.star.swiftUIImage
        static let lineLimit = 1
    }
}

// MARK: - Preview

extension InfoSignsViewModel {
    enum Examples {
        static let rating = InfoSignsViewModel(
            info: .rating(.Examples.Rating.high, .Examples.Text.normal)
        )
        static let textInfo = InfoSignsViewModel(info: .info(.Examples.Text.normal))
    }
}

extension InfoSignsView {
    struct Examples: ViewExamplesProvider {
        let views: [InfoSignsView] = [
            InfoSignsView(model: .Examples.rating),
            InfoSignsView(model: .Examples.textInfo)
        ]
    }
}

struct RatingView_Previews: PreviewProvider {
    private static let examples = InfoSignsView.Examples()
    static var previews: some View {
        examples.previews(colorSchemes: [.light])
    }
}
