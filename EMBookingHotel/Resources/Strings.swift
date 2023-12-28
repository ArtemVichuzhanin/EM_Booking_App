import Foundation

enum Strings {
    enum ErrorLocalizedDescription {
        static let invalidURL: String = NSLocalizedString(
            "LocalizedErrorDescription.invalidURL",
            value: "Неверная ссылка URL",
            comment: "Ошибка преобразования строки в ссылку"
        )
    }
}
