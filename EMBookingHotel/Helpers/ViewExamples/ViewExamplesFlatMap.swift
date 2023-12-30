import Foundation

final class ViewExamplesFlatMap<InputProvider: ViewExamplesProvider, OutputView>: ViewExamplesProvider {
    typealias InputView = InputProvider.ViewType
    typealias ViewType = OutputView

    init(_ inputProvider: InputProvider, transform: @escaping (InputView) -> [OutputView]) {
        self.inputProvider = inputProvider
        self.transform = transform
    }

    // MARK: - ViewExampleProvider

    var views: [OutputView] {
        inputProvider.views.flatMap(transform)
    }

    // MARK: - Private

    private let inputProvider: InputProvider
    private let transform: (InputView) -> [OutputView]
}

extension ViewExamplesProvider {
    func flatMap<OutputView>(
        _ transform: @escaping (Self.ViewType) -> [OutputView]
    ) -> ViewExamplesFlatMap<Self, OutputView> {
        return ViewExamplesFlatMap(self, transform: transform)
    }
}
