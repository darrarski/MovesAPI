public enum ConfigurationError: Error {
    case missingValue(key: String)
}

public extension Configuration {

    init() throws {
        let movesApiKey = "MovesAPI"
        guard let dict = Bundle.main.infoDictionary?[movesApiKey] as? [String : Any] else {
            throw ConfigurationError.missingValue(key: movesApiKey)
        }

        let schemeKey = "scheme"
        guard let scheme = dict[schemeKey] as? String else {
            throw ConfigurationError.missingValue(key: "\(movesApiKey).\(schemeKey)")
        }
        self.scheme = scheme

        let hostKey = "host"
        guard let host = dict[hostKey] as? String else {
            throw ConfigurationError.missingValue(key: "\(movesApiKey).\(hostKey)")
        }
        self.host = host

        let clientIdKey = "clientId"
        guard let clientId = dict[clientIdKey] as? String else {
            throw ConfigurationError.missingValue(key: "\(movesApiKey).\(clientIdKey)")
        }
        self.clientId = clientId

        let clientSecretKey = "clientSecret"
        guard let clientSecret = dict[clientSecretKey] as? String else {
            throw ConfigurationError.missingValue(key: "\(movesApiKey).\(clientSecretKey)")
        }
        self.clientSecret = clientSecret

        let scopeKey = "scope"
        guard let scope = dict[scopeKey] as? String else {
            throw ConfigurationError.missingValue(key: "\(movesApiKey).\(scopeKey)")
        }
        self.scope = scope

        let redirectUrlKey = "redirectUrl"
        guard let redirectUrl = dict[redirectUrlKey] as? String else {
            throw ConfigurationError.missingValue(key: "\(movesApiKey).\(redirectUrlKey)")
        }
        self.redirectUrl = redirectUrl
    }

}
