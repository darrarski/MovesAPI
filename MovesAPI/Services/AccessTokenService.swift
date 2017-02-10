import RxSwift
import Alamofire
import RxAlamofire
import Mapper

public enum AccessTokenServiceError: Error {
    case invalidResponse
}

public class AccessTokenService {

    private let apiConfig: Configuration

    public init(apiConfig: Configuration) {
        self.apiConfig = apiConfig
    }

    public func fetchAccessToken(authCode: String) -> Observable<AccessToken> {
        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.host
        urlComponents.path = "/oauth/v1/access_token"

        let params: [String : String] = [
            "grant_type": "authorization_code",
            "code": authCode,
            "client_id": apiConfig.clientId,
            "client_secret": apiConfig.clientSecret,
            "redirect_uri": apiConfig.redirectUrl
        ]

        return Alamofire.request(urlComponents, method: .post, parameters: params)
            .rx.json()
            .map { json -> AccessToken in
                guard let json = json as? [String: AnyObject] else {
                    throw AccessTokenServiceError.invalidResponse
                }
                return try AccessToken(map: Mapper(JSON: json as NSDictionary))
            }
    }

}
