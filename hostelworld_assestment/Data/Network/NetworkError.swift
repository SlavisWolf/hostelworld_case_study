

enum NetworkError: Error {
    case serverError(Int)
    case requestError(Int)
    case unknow(Int)
    case noResponse
    case invalidUrl
}
