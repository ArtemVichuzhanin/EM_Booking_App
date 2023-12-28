import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noInternetConnection(Error)
    case badRequest(String)
    case unauthorised(String)
    case forbidden(String)
    case serverError(String)
    case transportError(Error)
    case invalidStatusCode(Int)
    case parsingError(Error)
    case unknown(Error?)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return Strings.ErrorLocalizedDescription.invalidURL
        case .noInternetConnection(let error):
            return error.localizedDescription
        case .badRequest(let text):
            return text
        case .unauthorised(let text):
            return text
        case .forbidden(let text):
            return text
        case .serverError(let text):
            return text
        case .transportError(let error):
            return error.localizedDescription
        case .invalidStatusCode(let code):
            return String(code)
        case .parsingError(let error):
            return error.localizedDescription
        case .unknown(let error):
            return error?.localizedDescription
        }
    }
}
