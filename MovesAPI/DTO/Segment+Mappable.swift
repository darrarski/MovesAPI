import Mapper

extension Segment: Mappable {

    public init(map: Mapper) throws {
        type = try map.from("type")
        startTime = try map.from("startTime", transformation: Date.fromISO8601())
        endTime = try map.from("endTime", transformation: Date.fromISO8601())
        place = map.optionalFrom("place")
        activities = map.optionalFrom("activities")
        lastUpdate = map.optionalFrom("lastUpdate", transformation: Date.fromISO8601())
    }

}
