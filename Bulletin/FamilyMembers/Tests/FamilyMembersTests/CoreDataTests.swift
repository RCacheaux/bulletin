import XCTest
@testable import FamilyMembers

final class CoreDataTests: XCTestCase {
    func testCreateFamilyMember() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(Chores().text, "Hello, World!")
        let mumName = "Mum"
        
        let coreDataStore = FamilyMembersCoreDataStore(inMemory: true)
        
        let initialFamilyMembers = coreDataStore.getAllFamilyMembers()
        XCTAssertEqual(initialFamilyMembers.count, 0)
        
        let familyMember = FamilyMember(id: UUID(), name: mumName)
        coreDataStore.persist(familyMember)
        let familyMembers = coreDataStore.getAllFamilyMembers()
        XCTAssertEqual(familyMembers.count, 1)
        
        let mum = familyMembers[0]
        XCTAssertEqual(mum.name, mumName)
    }
}
