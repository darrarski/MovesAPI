import Foundation
import Mapper

extension Date {

    static func fromString(timeZone: TimeZone) -> ((Any) throws -> Date) {
        return Date.fromString(format: "yyyyMMdd", timeZone: timeZone)
    }

    static func fromISO8601() -> ((Any) throws -> Date) {
        guard let timeZone = TimeZone(abbreviation: "UTC") else { fatalError() }
        return Date.fromString(format: "yyyyMMdd'T'HHmmssZ", timeZone: timeZone)
    }

    static func fromString(format: String, timeZone: TimeZone) -> ((Any) throws -> Date) {
        return { value in
            guard let string = value as? String else {
                throw MapperError.convertibleError(value: value, type: String.self)
            }

            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = timeZone

            guard let date = formatter.date(from: string) else {
                throw MapperError.convertibleError(value: string, type: String.self)
            }

            return date
        }
    }

}
