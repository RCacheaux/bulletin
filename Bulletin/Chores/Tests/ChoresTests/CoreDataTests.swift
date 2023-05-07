import XCTest
@testable import Chores

final class CoreDataTests: XCTestCase {
    func testCreateChore() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(Chores().text, "Hello, World!")
        
        let coreDataStore = ChoresCoreDataStore(inMemory: true)
        
        let familyMembers = coreDataStore.getAllFamilyMembers()
        XCTAssertEqual(familyMembers.count, 0)
        
        let chore = Chore(id: UUID(), name: "Trash", assigneeId: nil)
        coreDataStore.persist(chore)
        let chores = coreDataStore.getAllChores()
        XCTAssertEqual(chores.count, 1)
    }
}
