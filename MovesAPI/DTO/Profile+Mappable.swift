import Mapper
import Foundation

extension Profile: Mappable {

    public init(map: Mapper) throws {
        userId = try map.from("userId")
        caloriesAvailable = try map.from("profile.caloriesAvailable")
        platform = try map.from("profile.platform")
        timeZone = try map.from("profile.currentTimeZone.id")
        firstDate = try map.from("profile.firstDate", transformation: Date.fromString(timeZone: timeZone))
        language = try map.from("profile.localization.language")
        firstWeekDay = try map.from("profile.localization.firstWeekDay")
        metric = try map.from("profile.localization.metric")
        locale = try map.from("profile.localization.locale")
    }

}
