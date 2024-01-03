import Foundation

enum Strings {
    enum ErrorLocalizedDescription {
        static let invalidURL: String = NSLocalizedString(
            "LocalizedErrorDescription.invalidURL",
            value: "Неверная ссылка URL",
            comment: "Ошибка преобразования строки в ссылку"
        )
    }

    enum Common {
        static let pretextFrom: String = NSLocalizedString(
            "Common.pretextFrom",
            value: "от",
            comment: "предлог от"
        )
    }

    enum Room {
        enum Button {
            static let more: String = NSLocalizedString(
                "Room.Button.more",
                value: "Подробнее о номере",
                comment: "кнопка подробнее на экране выбора номера"
            )
        }
    }
}
