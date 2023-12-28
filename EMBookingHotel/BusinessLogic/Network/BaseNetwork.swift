import Foundation
import Combine

enum HTTPMethod: String {
    case GET
}

class BaseNetwork {
    func performRequest<R: Decodable>(type: R.Type, request: NetworkRequest) async throws -> R {
        do {
            let urlRequest = try getURLRequest(from: request)
            let data = try await URLSession.shared.data(from: urlRequest)
            let model = try decoder.decode(R.self, from: data)

            return model
        } catch {
            guard let catchError = error as? NetworkError else {
                throw NetworkError.parsingError(error)
            }
            throw catchError
        }
    }

    // MARK: - Private

    private let decoder = JSONDecoder()

    private func getURLRequest(from request: NetworkRequest) throws -> URLRequest {
        var urlRequest = URLRequest(url: try request.apiMethod.asURL())

        switch request.method {
        case .GET:
            urlRequest.httpMethod = request.method.rawValue
        }

        if let headers = request.headers {
            urlRequest.allHTTPHeaderFields = headers
        }

        return urlRequest
    }
}

// MARK: - URLSession Extension

private extension URLSession {
    func data(from request: URLRequest) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error as? URLError {
                    switch error.code {
                    case .networkConnectionLost, .dataNotAllowed, .notConnectedToInternet:
                        return continuation.resume(throwing: NetworkError.noInternetConnection(error))
                    default:
                        return continuation.resume(throwing: NetworkError.transportError(error))
                    }
                }

                if let response = response as? HTTPURLResponse {
                    let statusCode = response.statusCode
                    guard (200..<300).contains(statusCode) else {
                        var errorText = ""
                        if let responseData = data, let errorString = String(bytes: responseData, encoding: .utf8) {
                            errorText = errorString
                        }
                        let networkError = self.defineErrorType(code: statusCode, errorText: errorText)
                        return continuation.resume(throwing: networkError)
                    }
                }

                guard let dataGotten = data else {
                    return continuation.resume(throwing: NetworkError.unknown(error))
                }
                continuation.resume(returning: (dataGotten))
            }
            task.resume()
        }
    }

    private func defineErrorType(code: Int, errorText: String) -> NetworkError {
        if code == 400 {
            return NetworkError.badRequest(errorText)
        } else if code == 401 {
            return NetworkError.unauthorised(errorText)
        } else if code == 403 {
            return NetworkError.forbidden(errorText)
        } else if (500...599).contains(code) {
            return NetworkError.serverError(errorText)
        } else {
            return NetworkError.invalidStatusCode(code)
        }
    }
}
