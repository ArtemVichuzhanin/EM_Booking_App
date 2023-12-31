import SwiftUI

// MARK: ViewModel

struct ActionButtonViewModel {
    enum InfoType {
        case text(String)
        case textWithChevron(String)
        case collapsed(Bool)
        case add
    }

    let info: InfoType
    let disabled: Bool
    let onTap: () -> Void

    init(info: InfoType, disabled: Bool = false, onTap: @escaping () -> Void = {}) {
        self.info = info
        self.disabled = disabled
        self.onTap = onTap
    }
}

// MARK: - View

struct ActionButtonView: View {
    let model: ActionButtonViewModel

    var body: some View {
        Button(
            action: model.onTap,
            label: { content }
        )
        .disabled(model.disabled)
        .background(backgroundColor(for: model.info))
        .clipShape(.rect(cornerRadius: cornerRadius))
    }

    // MARK: Private

    private var cornerRadius: CGFloat {
        switch model.info {
        case .text:
            Static.Layout.textCornerRadius
        case .textWithChevron:
            Static.Layout.textWithChevronCornerRadius
        case .collapsed, .add:
            Static.Layout.iconCornerRadius
        }
    }

    @ViewBuilder private var content: some View {
        switch model.info {
        case .text(let text):
            textView(text)
        case .textWithChevron(let text):
            textWithChevronView(text)
        case .collapsed(let isCollapsed):
            collapseView(isCollapsed)
        case .add:
            addView()
        }
    }

    @ViewBuilder
    private func textView(_ text: String) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Text(text)
                .font(Static.Font.primary)
                .lineLimit(Static.textLineLimit)
            Spacer()
        }
        .foregroundStyle(Static.Color.contentPrimary)
        .padding(.top, Static.Layout.textVerticalInset)
        .padding(.bottom, Static.Layout.textVerticalInset)
    }

    @ViewBuilder
    private func textWithChevronView(_ text: String) -> some View {
        HStack(spacing: Static.Layout.textWithChevronSpacing) {
            Text(text)
                .font(Static.Font.primary)
                .lineLimit(Static.textLineLimit)
            iconView(Static.Icon.chevronForward)
        }
        .foregroundStyle(Static.Color.contentSecondary)
        .padding(EdgeInsets(
            top: Static.Layout.textWithChevronVerticalInset,
            leading: Static.Layout.textWithChevronLeadingInset,
            bottom: Static.Layout.textWithChevronVerticalInset,
            trailing: Static.Layout.textWithChevronTrailingInset
        ))
    }

    @ViewBuilder
    private func collapseView(_ isCollapsed: Bool) -> some View {
        iconView(isCollapsed ? Static.Icon.chevronDown : Static.Icon.chevronUp)
            .foregroundStyle(Static.Color.contentSecondary)
            .padding(Static.Layout.imageInset)
    }

    @ViewBuilder
    private func addView() -> some View {
        iconView(Static.Icon.plus)
            .foregroundStyle(Static.Color.contentPrimary)
            .padding(Static.Layout.imageInset)
    }

    @ViewBuilder
    private func iconView(_ image: Image) -> some View {
        image
            .frame(width: Static.Layout.imageSize, height: Static.Layout.imageSize, alignment: .center)
    }

    private func backgroundColor(for type: ActionButtonViewModel.InfoType) -> Color {
        switch type {
        case .text, .add:
            Static.Color.backgroundPrimary
        case .textWithChevron, .collapsed:
            Static.Color.backgroundSecondary
        }
    }

    // MARK: Constants

    private enum Static {
        enum Layout {
            static let textVerticalInset: CGFloat = 15

            static let imageSize: CGFloat = 24
            static let imageInset: CGFloat = 4

            static let textWithChevronSpacing: CGFloat = 2
            static let textWithChevronLeadingInset: CGFloat = 10
            static let textWithChevronTrailingInset: CGFloat = 2
            static let textWithChevronVerticalInset: CGFloat = 5

            static let textCornerRadius: CGFloat = 15
            static let iconCornerRadius: CGFloat = 6
            static let textWithChevronCornerRadius: CGFloat = 5
        }

        enum Color {
            static let backgroundPrimary = Assets.Colors.Button.Background.primary.swiftUIColor
            static let backgroundSecondary = Assets.Colors.Button.Background.secondary.swiftUIColor
            static let contentPrimary = Assets.Colors.Button.Content.primary.swiftUIColor
            static let contentSecondary = Assets.Colors.Button.Content.secondary.swiftUIColor
        }

        enum Icon {
            static let plus = Assets.Icons.plus.swiftUIImage
            static let chevronUp = Assets.Icons.arrowUp.swiftUIImage
            static let chevronDown = Assets.Icons.arrowDown.swiftUIImage
            static let chevronForward = Assets.Icons.arrowRight.swiftUIImage
        }

        enum Font {
            static let primary = Fonts.textMedium
        }

        static let textLineLimit = 1
    }
}

// MARK: - Preview

extension ActionButtonViewModel {
    enum Examples {
        static let shortText = ActionButtonViewModel(info: .text(.Examples.Text.short))
        static let normalText = ActionButtonViewModel(info: .text(.Examples.Text.normal))
        static let mediumText = ActionButtonViewModel(info: .text(.Examples.Text.medium))

        static let collapsedIcon = ActionButtonViewModel(info: .collapsed(true))
        static let expandedIcon = ActionButtonViewModel(info: .collapsed(false))
        static let addIcon = ActionButtonViewModel(info: .add)

        static let normalTextChevron = ActionButtonViewModel(
            info: .textWithChevron(.Examples.Text.normal)
        )
    }
}

extension ActionButtonView {
    struct Examples: ViewExamplesProvider {
        let views: [ActionButtonView] = [
            .init(model: .Examples.normalText),
            .init(model: .Examples.mediumText),
            .init(model: .Examples.shortText),
            .init(model: .Examples.collapsedIcon),
            .init(model: .Examples.expandedIcon),
            .init(model: .Examples.addIcon),
            .init(model: .Examples.normalTextChevron)
        ]
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    private static let examples = ActionButtonView.Examples()
    static var previews: some View {
        examples.previews(colorSchemes: [.light])
    }
}
