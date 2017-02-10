import Mapper

extension Int64: Convertible {

    public static func fromMap(_ value: Any) throws -> Int64 {
        guard let int64value = (value as? NSNumber)?.int64Value else {
            throw MapperError.convertibleError(value: value, type: NSNumber.self)
        }
        return int64value
    }

}
