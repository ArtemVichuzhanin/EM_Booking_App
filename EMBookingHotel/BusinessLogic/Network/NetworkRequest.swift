import Foundation

struct NetworkRequest {
    let method: HTTPMethod
    let apiMethod: APIMethods
    let headers: HTTPHeaders?
}
