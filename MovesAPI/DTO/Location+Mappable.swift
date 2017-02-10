import Mapper

extension Location: Mappable {

    public init(map: Mapper) throws {
        lat = try map.from("lat")
        lon = try map.from("lon")
    }

}
