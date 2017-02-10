import Foundation
import Mapper

extension TrackPoint: Mappable {

    public init(map: Mapper) throws {
        lat = try map.from("lat")
        lon = try map.from("lon")
        time = try map.from("time", transformation: Date.fromISO8601())
    }

}
