import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    // MARK: - UserController
    let userController = UsersController(userService: ProjectServices.userService)
    try app.register(collection: userController)
}
