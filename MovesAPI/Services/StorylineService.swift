import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import Mapper

public class StorylineService {

    public enum Error: Swift.Error {
        case invalidResponse
    }

    public enum Period {
        case singleDay(date: Date)
        case specificWeek(date: Date)
        case specificMonth(date: Date)
        case dateRange(from: Date, to: Date)
        case pastDays(count: Int)
    }

    private let apiConfig: Configuration

    public init(apiConfig: Configuration) {
        self.apiConfig = apiConfig
    }

    public func fetchDaily(token: AccessToken,
                           period: Period,
                           timeZone: TimeZone,
                           trackPoints: Bool,
                           updatedSince: Date? = nil) -> Observable<[MovesAPI.Day]> {
        var url = self.url(period: period,
                           timeZone: timeZone)
        url.queryItems = queryItems(period: period,
                                    timeZone: timeZone,
                                    trackPoints: trackPoints,
                                    updatedSince: updatedSince)
        let headers = self.headers(token: token)

        return Alamofire.request(url, method: .get, headers: headers)
            .rx.json()
            .map { json -> [MovesAPI.Day] in
                guard let json = json as? [[String: AnyObject]] else {
                    throw Error.invalidResponse
                }
                return try json.map { try MovesAPI.Day(map: Mapper(JSON: $0 as NSDictionary), timeZone: timeZone) }
        }
    }

    private func url(period: Period, timeZone: TimeZone) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = apiConfig.scheme
        urlComponents.host = apiConfig.host
        var path = "/api/1.1/user/storyline/daily"
        let dateString = self.dateString(period: period, timeZone: timeZone)
        if dateString.isEmpty == false {
            path.append("/\(dateString)")
        }
        urlComponents.path = path
        return urlComponents
    }

    private func dateString(period: Period, timeZone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        switch period {
        case .singleDay(let date):
            formatter.dateFormat = "yyyyMMdd"
            return formatter.string(from: date)
        case .specificWeek(let date):
            formatter.dateFormat = "yyyy-'W'ww"
            return formatter.string(from: date)
        case .specificMonth(let date):
            formatter.dateFormat = "yyyyMM"
            return formatter.string(from: date)
        case .dateRange, .pastDays:
            return ""
        }
    }

    private func queryItems(period: Period,
                            timeZone: TimeZone,
                            trackPoints: Bool,
                            updatedSince: Date?) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "timeZone", value: timeZone.identifier))
        queryItems.append(URLQueryItem(name: "trackPoints", value: trackPoints ? "true" : "false"))
        if let updatedSince = updatedSince {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd'T'HHmmssZ"
            formatter.timeZone = timeZone
            queryItems.append(URLQueryItem(name: "updatedSince", value: formatter.string(from: updatedSince)))
        }
        if case .pastDays(let count) = period {
            queryItems.append(URLQueryItem(name: "pastDays", value: "\(count)"))
        } else if case .dateRange(let from, let to) = period {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            formatter.timeZone = timeZone
            queryItems.append(URLQueryItem(name: "from", value: formatter.string(from: from)))
            queryItems.append(URLQueryItem(name: "to", value: formatter.string(from: to)))
        }
        return queryItems
    }

    private func headers(token: AccessToken) -> [String : String] {
        return ["Authorization": "Bearer \(token.accessToken)"]
    }

}
