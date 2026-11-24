import Foundation
import CartDomain
public protocol CatalogSource { func load() throws -> [Product] }
public struct LocalCatalog: CatalogSource {
    public init(data: Data) {}
    public func load() throws -> [Product] { [] }
}
public struct RemoteCatalog: CatalogSource {
    public init(fetch: @escaping () throws -> Data) {}
    public func load() throws -> [Product] { [] }
}
