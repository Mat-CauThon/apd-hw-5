import Foundation

public struct Product: Equatable, Codable {
    public let id: String
    public let name: String
    public let priceCents: Int
    public init(id: String, name: String, priceCents: Int) {
        self.id = id; self.name = name; self.priceCents = priceCents
    }
}
public enum CartError: Error, Equatable { case invalidProduct, unknownProduct, overflow }
public struct CartLine: Equatable {
    public let product: Product
    public let quantity: Int
    public init(product: Product, quantity: Int) { self.product = product; self.quantity = quantity }
}
public struct Cart {
    public private(set) var lines: [CartLine] = []
    public init() {}
    public mutating func add(_ product: Product) throws { }
    public mutating func remove(id: String) throws { }
    public func subtotalCents() throws -> Int { 0 }
}
public protocol DiscountStrategy { func discountCents(for subtotalCents: Int) -> Int }
public enum CheckoutError: Error, Equatable { case invalidDiscount }
public func checkoutTotal(cart: Cart, strategy: any DiscountStrategy) throws -> Int { 0 }
