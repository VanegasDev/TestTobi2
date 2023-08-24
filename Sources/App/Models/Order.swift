import Vapor
import Fluent

final class Order: Model, Content {
  // 2
  static let schema = "order"
  
  // 3
  @ID(custom: "id")
  var id: Int?
  
  // 4
  @Field(key: "date")
  var date: Date

  @Field(key: "user_id")
  var userId: Int
  

  init() {}
  
  // 6
  init(id: Int, date: Date, userId: Int) {
    self.id = id
    self.date = date
    self.userId = userId
  }
}