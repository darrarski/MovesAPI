import Mapper

extension Activity: Mappable {

    public init(map: Mapper) throws {
        activity = try map.from("activity")
        group = map.optionalFrom("group")
        manual = try map.from("manual")
        startTime = map.optionalFrom("startTime", transformation: Date.fromISO8601())
        endTime = map.optionalFrom("endTime", transformation: Date.fromISO8601())
        duration = try map.from("duration")
        distance = map.optionalFrom("distance")
        steps = map.optionalFrom("steps")
        calories = map.optionalFrom("calories")
        trackPoints = map.optionalFrom("trackPoints")
    }

}
