import Mapper
import Foundation

extension Day {

    public init(map: Mapper, timeZone: TimeZone) throws {
        date = try map.from("date", transformation: Date.fromString(timeZone: timeZone))
        caloriesIdle = map.optionalFrom("caloriesIdle")
        lastUpdate = map.optionalFrom("lastUpdate", transformation: Date.fromISO8601())
        summary = map.optionalFrom("summary")
        segments = map.optionalFrom("segments")
    }

}
