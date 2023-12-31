import SwiftUI
import Kingfisher

// MARK: ViewModel

struct ImageCarouselViewModel {
    struct ImageCarouselItem: Identifiable {
        let id = UUID()
        let imageUrl: URL
    }

    let items: [ImageCarouselItem]
}

// MARK: - View

struct ImageCarouselView: View {
    let model: ImageCarouselViewModel

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $selectedTab) {
                ForEach(Array(model.items.enumerated()), id: \.offset) { index, item in
                    imageView(item.imageUrl, size: geometry.size)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .aspectRatio(Static.aspectRatio, contentMode: .fit)
            .clipShape(.rect(cornerRadius: Static.cornerRadius))
            .overlay(indexView(), alignment: .bottom)
            .animation(.default,value: selectedTab)
        }
    }

    // MARK: Private

    @State private var selectedTab = 0

    @ViewBuilder
    private func imageView(_ url: URL, size: CGSize) -> some View {
        KFImage(url)
            .placeholder(Static.placeholder.scaledToFill)
            .downsampling(size: size)
            .resizable()
            .retry(maxCount: Static.maxRetryCount)
            .cacheOriginalImage()
    }

    @ViewBuilder
    private func indexView() -> some View {
        CustomIndexView(
            model: CustomIndexViewModel(selectedIndex: selectedTab, numberOfPages: model.items.count)
        )
        .padding(.bottom, Static.indexViewBottomInset)
    }

    // MARK: Constants

    private enum Static {
        static let cornerRadius: CGFloat = 15
        static let aspectRatio = CGSize(width: 343, height: 257)
        static let indexViewBottomInset: CGFloat = 8

        static let maxRetryCount = 3

        static let placeholder = Color.gray
    }
}

// MARK: - Preview

extension ImageCarouselViewModel {
    enum Examples {
        static let model = ImageCarouselViewModel(
            items: URL.Examples.sampleImageURLs.map { ImageCarouselItem(imageUrl: $0) }
        )
    }
}

extension ImageCarouselView {
    struct Examples: ViewExamplesProvider {
        let views: [ImageCarouselView] = [
            ImageCarouselView(model: .Examples.model)
        ]
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    private static let examples = ImageCarouselView.Examples()
    static var previews: some View {
        examples.previews(colorSchemes: [.light])
    }
}
