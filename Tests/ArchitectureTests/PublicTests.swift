import XCTest
import CartDomain
import CatalogData
import ShoppingApp

final class PublicTests: XCTestCase {
    func testAddingSameProductIncrementsQuantity() throws {
        var cart = Cart()
        let product = Product(id: "a", name: "Apple", priceCents: 125)
        try cart.add(product)
        try cart.add(product)
        XCTAssertEqual(cart.lines, [CartLine(product: product, quantity: 2)])
        XCTAssertEqual(try cart.subtotalCents(), 250)
    }
    func testInjectedCatalogPopulatesShop() {
        struct Source: CatalogSource {
            func load() throws -> [Product] { [Product(id: "a", name: "Apple", priceCents: 125)] }
        }
        let shop = Shop(source: Source())
        shop.reload()
        XCTAssertEqual(shop.catalogState, .loaded([Product(id: "a", name: "Apple", priceCents: 125)]))
    }
}
