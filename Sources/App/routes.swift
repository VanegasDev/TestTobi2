import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("users") { req -> EventLoopFuture<[User]> in
        User.query(on: req.db).all()
    }

    app.get("orders") { req -> EventLoopFuture<[Order]> in 
        Order.query(on: req.db).all()
    }

    app.get("getOrderDetailsByUserId", ":id") { req async throws -> [Order] in
        let users = try await Order.query(on: req.db).all()
        guard let userId = req.parameters.get("id").flatMap(Int.init(_:)) else {
            throw Abort(.badRequest)
        }
        
        return users.filter { $0.userId == userId }
    }

    app.get("getUsersFilteredByString", ":name") { req throws -> EventLoopFuture<[User]> in 
        guard let name = req.parameters.get("name") else {
            throw Abort(.internalServerError)
        }

        return User.query(on: req.db)
            .filter(\.$name ~~ name)
            .all()
    }

    app.get("getAdditionCalculated", ":startIndex", ":finalIndex") { req async throws -> Int in
        guard let startIndex = req.parameters.get("startIndex").flatMap(Int.init(_:)),
            let finalIndex = req.parameters.get("finalIndex").flatMap(Int.init(_:)) else {
                throw Abort(.badRequest)
            }

        var sum = 0

        for number in startIndex...finalIndex {
            sum += number
        } 

        return sum
    }
}