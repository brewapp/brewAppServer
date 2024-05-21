import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    
    let protected = app.grouped(UserAuthenticator())
    
    protected.get("hello") { req async throws in
        
        guard req.auth.has(User.self) else {
            throw Abort(.unauthorized)
        }
        return "Hello, world!"
    }

    try app.register(collection: TodoController())
}
