import Vapor
import FluentProvider
import HTTP

final class Post: Model {
    let storage = Storage()
    
    // MARK: Properties and database keys
    
    /// The content of the post
    static let idType: IdentifierType = .uuid
    var content: String
    var receiverName: String
    var receiverMobileNo: String
    var receiverAddress: String
    var receiverCountry: String
    var receiverPincode: String
    var senderName: String
    var senderMobileNo: String
    var senderAddress: String
    var senderCountry: String
    var senderPincode: String
    var senderDescription: String
    var senderWeight: String
    
    /// The column names for `id` and `content` in the database
    static let idKey = "id"
    static let contentKey = "content"
    static let receiverNameKey = "receiverName"
    static let receiverMobileNoKey = "receiverMobileNo"
    static let receiverAddressKey = "receiverAddress"
    static let receiverCountryKey = "receiverCountry"
    static let receiverPincodeKey = "receiverPincode"
    static let senderNameKey = "senderName"
    static let senderMobileNoKey = "senderMobileNo"
    static let senderAddressKey = "senderAddress"
    static let senderCountryKey = "senderCountry"
    static let senderPincodeKey = "senderPincode"
    static let senderDescriptionKey = "senderDescription"
    static let senderWeightKey = "senderWeight"

    /// Creates a new Post
    init(content: String,
         receiverName: String,
         receiverMobileNo: String,
         receiverAddress: String,
         receiverCountry: String,
         receiverPincode: String,
         senderName: String,
         senderMobileNo: String,
         senderAddress: String,
         senderCountry: String,
         senderPincode: String,
         senderDescription: String,
         senderWeight: String) {
        self.content = content
        self.receiverName = receiverName
        self.receiverMobileNo = receiverMobileNo
        self.receiverAddress = receiverAddress
        self.receiverCountry = receiverCountry
        self.receiverPincode = receiverPincode
        self.senderName = senderName
        self.senderMobileNo = senderMobileNo
        self.senderAddress = senderAddress
        self.senderCountry = senderCountry
        self.senderPincode = senderCountry
        self.senderDescription = senderDescription
        self.senderWeight = senderWeight
    }

    // MARK: Fluent Serialization

    /// Initializes the Post from the
    /// database row
    init(row: Row) throws {
        content = try row.get(Post.contentKey)
        receiverName = try row.get(Post.receiverNameKey)
        receiverMobileNo = try row.get(Post.receiverMobileNoKey)
        receiverAddress = try row.get(Post.receiverAddressKey)
        receiverCountry = try row.get(Post.receiverCountryKey)
        receiverPincode = try row.get(Post.receiverPincodeKey)
        senderName = try row.get(Post.senderNameKey)
        senderMobileNo = try row.get(Post.senderMobileNoKey)
        senderAddress = try row.get(Post.senderAddressKey)
        senderCountry = try row.get(Post.senderCountryKey)
        senderPincode = try row.get(Post.senderPincodeKey)
        senderDescription = try row.get(Post.senderDescriptionKey)
        senderWeight = try row.get(Post.senderWeightKey)
    }

    // Serializes the Post to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Post.contentKey, content)
        try row.set(Post.receiverNameKey, receiverName)
        try row.set(Post.receiverMobileNoKey, receiverMobileNo)
        try row.set(Post.receiverAddressKey, receiverAddress)
        try row.set(Post.receiverCountryKey, receiverCountry)
        try row.set(Post.receiverPincodeKey, receiverPincode)
        try row.set(Post.senderNameKey, senderName)
        try row.set(Post.senderMobileNoKey, senderMobileNo)
        try row.set(Post.senderAddressKey, senderAddress)
        try row.set(Post.senderCountryKey, senderCountry)
        try row.set(Post.senderPincodeKey, senderPincode)
        try row.set(Post.senderDescriptionKey, senderDescription)
        try row.set(Post.senderWeightKey, senderWeight)
        return row
    }
}

// MARK: Fluent Preparation

extension Post: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Posts
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Post.contentKey)
            builder.string(Post.receiverNameKey)
            builder.string(Post.receiverMobileNoKey)
            builder.string(Post.receiverAddressKey)
            builder.string(Post.receiverCountryKey)
            builder.string(Post.receiverPincodeKey)
            builder.string(Post.senderNameKey)
            builder.string(Post.senderMobileNoKey)
            builder.string(Post.senderAddressKey)
            builder.string(Post.senderCountryKey)
            builder.string(Post.senderPincodeKey)
            builder.string(Post.senderDescriptionKey)
            builder.string(Post.senderWeightKey)
        }
    }

    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: JSON

// How the model converts from / to JSON.
// For example when:
//     - Creating a new Post (POST /posts)
//     - Fetching a post (GET /posts, GET /posts/:id)
//
extension Post: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(content: json.get(Post.contentKey),
                      receiverName: json.get(Post.receiverNameKey),
                      receiverMobileNo: json.get(Post.receiverMobileNoKey),
                      receiverAddress: json.get(Post.receiverAddressKey),
                      receiverCountry: json.get(Post.receiverCountryKey),
                      receiverPincode: json.get(Post.receiverPincodeKey),
                      senderName: json.get(Post.senderNameKey),
                      senderMobileNo: json.get(Post.senderMobileNoKey),
                      senderAddress: json.get(Post.senderAddressKey),
                      senderCountry: json.get(Post.senderCountryKey),
                      senderPincode: json.get(Post.senderPincodeKey),
                      senderDescription: json.get(Post.senderDescriptionKey),
                      senderWeight: json.get(Post.senderWeightKey)
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Post.idKey, id)
        try json.set(Post.receiverNameKey, receiverName)
        try json.set(Post.receiverMobileNoKey, receiverMobileNo)
        try json.set(Post.receiverAddressKey, receiverAddress)
        try json.set(Post.receiverCountryKey, receiverCountry)
        try json.set(Post.receiverPincodeKey, receiverPincode)
        try json.set(Post.senderNameKey, senderName)
        try json.set(Post.senderMobileNoKey, senderMobileNo)
        try json.set(Post.senderAddressKey, senderAddress)
        try json.set(Post.senderCountryKey, senderCountry)
        try json.set(Post.senderPincodeKey, senderPincode)
        try json.set(Post.senderDescriptionKey, senderDescription)
        try json.set(Post.senderWeightKey, senderWeight)
        
        return json
    }
}

// MARK: HTTP

// This allows Post models to be returned
// directly in route closures
extension Post: ResponseRepresentable { }

// MARK: Update

// This allows the Post model to be updated
// dynamically by the request.
extension Post: Updateable {
    // Updateable keys are called when `post.update(for: req)` is called.
    // Add as many updateable keys as you like here.
    public static var updateableKeys: [UpdateableKey<Post>] {
        return [
            // If the request contains a String at key "content"
            // the setter callback will be called.
            UpdateableKey(Post.contentKey, String.self) { post, content in
                post.content = content
            }
        ]
    }
}
