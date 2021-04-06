import Foundation

public struct Article: Codable, Identifiable, Equatable {
    public var id: Int
    public var title: String
    public var description: String
    public var author: String
    public var release_date: String
    public var image: String
    
    public init(id: Int, title: String, description: String, author: String, release_date: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.author = author
        self.release_date = release_date
        self.image = image
    }
}
