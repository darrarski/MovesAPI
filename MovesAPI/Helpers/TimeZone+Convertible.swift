import Foundation
import Mapper

extension TimeZone: Convertible {

    public static func fromMap(_ value: Any) throws -> TimeZone {
        guard let timeZoneId = value as? String, let timeZone = TimeZone(identifier: timeZoneId) else {
            throw MapperError.convertibleError(value: value, type: String.self)
        }
        return timeZone
    }

}
