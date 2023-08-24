import Vapor
import Fluent

final class User: Model, Content {
  // 2
  static let schema = "user"
  
  // 3
  @ID(custom: "id")
  var id: Int?
  
  // 4
  @Field(key: "name")
  var name: String
  
  // 5
  init() {}
  
  // 6
  init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}