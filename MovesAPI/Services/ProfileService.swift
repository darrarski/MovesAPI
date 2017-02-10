import RxSwift
import Alamofire
import RxAlamofire
import Mapper

public enum ProfileServiceError: Error {
    case invalidResponse
}

public class ProfileService {

    private let apiConfig: Configuration

    public init(apiConfig: Configuration) {
        self.apiConfig = apiConfig
    }

    public func fetchProfile(token: AccessToken) -> Observable<Profile> {
        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.host
        urlComponents.path = "/api/1.1/user/profile"

        let headers = [
            "Authorization": "Bearer \(token.accessToken)"
        ]

        return Alamofire.request(urlComponents, method: .get, headers: headers)
            .rx.json()
            .map { json -> Profile in
                guard let json = json as? [String: AnyObject] else {
                    throw ProfileServiceError.invalidResponse
                }
                return try Profile(map: Mapper(JSON: json as NSDictionary))
            }
    }

}
