public struct Activity {

    public let activity: String
    public let group: String?
    public let manual: Bool
    public let startTime: Date?
    public let endTime: Date?
    public let duration: Int
    public let distance: Int?
    public let steps: Int?
    public let calories: Int?
    public let trackPoints: [TrackPoint]?

}
