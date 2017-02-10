import Mapper

extension Place: Mappable {

    public init(map: Mapper) throws {
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        type = try map.from("type")
        facebookPlaceId = map.optionalFrom("facebookPlaceId")
        foursquareId = map.optionalFrom("foursquareId")
        foursquareCategoryIds = map.optionalFrom("foursquareCategoryIds")
        location = try map.from("location")
    }

}
