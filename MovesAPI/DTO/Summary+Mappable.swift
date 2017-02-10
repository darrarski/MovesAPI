import Mapper

extension Summary: Mappable {

    public init(map: Mapper) throws {
        activity = try map.from("activity")
        group = map.optionalFrom("group")
        duration = try map.from("duration")
        distance = map.optionalFrom("distance")
        steps = map.optionalFrom("steps")
        calories = map.optionalFrom("calories")
    }

}
