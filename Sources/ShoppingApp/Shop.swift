import CartDomain
import CatalogData
public enum CatalogState: Equatable { case idle, loading, loaded([Product]), failed }
public final class Shop {
    public private(set) var catalogState: CatalogState = .idle
    public private(set) var cart = Cart()
    public init(source: any CatalogSource) {}
    public func reload() {}
    public func add(id: String) throws {}
    public func remove(id: String) throws {}
}
