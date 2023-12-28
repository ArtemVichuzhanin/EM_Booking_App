import Foundation

enum APIMethods: String {
    case hotel = "/d144777c-a67f-4e35-867a-cacc3b827473"
    case room = "/8b532701-709e-4194-a41c-1a903af00195"
    case booking = "/63866c74-d593-432c-af8e-f279d1a8d2ff"

    func asURL() throws -> URL {
        var urlComponents = URLComponents(string: APIConfiguration.shared.baseURL)
        urlComponents?.path = self.rawValue

        guard let url = urlComponents?.url else { throw NetworkError.invalidUrl }
        return url
    }
}
