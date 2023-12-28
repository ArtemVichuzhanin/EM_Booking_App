typealias HTTPHeaders = [String: String]

final class APIConfiguration {
    static let shared = APIConfiguration()

    var baseURL: String {
        "https://run.mocky.io/v3"
    }

    var contentHeaders: HTTPHeaders {
        ["Content-Type": "application/json"]
    }

    private init() {}
}
