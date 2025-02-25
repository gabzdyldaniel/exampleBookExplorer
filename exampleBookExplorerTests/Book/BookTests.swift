//
// Created with ❤️ by Daniel Gabzdyl.

import Testing
@testable import exampleBookExplorer


@Suite
struct BookTests {
    
    let dataSourceMock = VolumeDataSourceMock()
    let getBooksUseCase: BookUseCase.GetBooks
    
    init() {
        getBooksUseCase = BookUseCase.GetBooks(dataSource: dataSourceMock)
    }
    
    @Test func testGetBooksUseCaseReturnsAllBooks() async throws {
        let books = try await getBooksUseCase(author: "J. K. Rowling")
        
        #expect(books.count == 1)
        #expect(books[0].title == "Harry Potter a Kámen mudrců")
    }
}

