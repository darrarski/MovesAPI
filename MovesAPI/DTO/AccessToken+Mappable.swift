import Mapper
import Foundation

extension AccessToken: Mappable {

    public init(map: Mapper) throws {
        accessToken = try map.from("access_token")
        tokenType = try map.from("token_type")
        expirationDate = try map.from("expires_in", transformation: { (object) -> Date in
            guard let expiresIn = object as? Int else {
                throw MapperError.convertibleError(value: object, type: Int.self)
            }
            return Date(timeInterval: TimeInterval(expiresIn), since: Date())
        })
        refreshToken = try map.from("refresh_token")
        userId = try map.from("user_id")
    }

}
