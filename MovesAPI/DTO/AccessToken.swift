import Foundation

public struct AccessToken {

    public let accessToken: String
    public let tokenType: String
    public let expirationDate: Date
    public let refreshToken: String
    public let userId: Int64

}
