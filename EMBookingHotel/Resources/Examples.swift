import Foundation
import SwiftUI

extension String {
    enum Examples {
        enum Text {
            static let empty = ""
            static let short = "pi"
            static let normal = "Normal Text"
            static let medium = """
            blandit volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque in dictum non consectetur a
            """
            static let long = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \
            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \
            Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. \
            Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            """
        }

        enum Email {
            static let empty = ""
            static let short = "a@vf.ru"
            static let normal = "weirdfreak@vf.ru"
            static let long = "Lorem.ipsum.dolor.sit.amet.consectetur.adipiscing@gmail.com"
        }

        enum Price {
            static let short = "99 ₽"
            static let normal = "999 ₽"
            static let long = "99999 ₽"
        }
    }
}

extension Image {
    enum Examples {
        enum Icon {
            static let plus = Image(systemName: "plus")
            static let chevronForward = Image(systemName: "chevron.forward")
        }
    }
}

extension URL {
    enum Examples {
        static let sampleImageURLs: [URL] = {
            let prefix =
            "https://raw.githubusercontent.com/onevcat/Kingfisher-TestImages/master/DemoAppImage/Loading"
            return (1...10).compactMap { URL(string: "\(prefix)/kingfisher-\($0).jpg") }
        }()
    }
}
