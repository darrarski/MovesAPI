import Foundation
import Mapper

extension NSLocale: Convertible {

    public static func fromMap(_ value: Any) throws -> NSLocale {
        guard let identifier = value as? String else {
            throw MapperError.convertibleError(value: value, type: String.self)
        }
        return NSLocale(localeIdentifier: identifier)
    }

}
