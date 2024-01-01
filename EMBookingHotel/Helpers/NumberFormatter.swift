import Foundation

extension NumberFormatter {
    static func currencyFormatter(for locale: Locale = Locale(identifier: "ru_RU")) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        formatter.alwaysShowsDecimalSeparator = false
        formatter.maximumFractionDigits = 0

        return formatter
    }
}
