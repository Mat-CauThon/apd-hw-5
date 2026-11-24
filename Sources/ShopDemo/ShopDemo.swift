import SwiftUI
import Foundation
import CartDomain
import CatalogData
import ShoppingApp

// Provided presentation shell. The assignment is to implement its dependencies.
@main struct ShopDemo: App {
    var body: some Scene { WindowGroup { ShopView() } }
}
struct ShopView: View {
    @State private var shop = Shop(source: LocalCatalog(data: Data("""
    [{"id":"apple","name":"Apple","priceCents":125},
     {"id":"tea","name":"Tea","priceCents":340}]
    """.utf8)))
    @State private var revision = 0
    var body: some View {
        VStack(alignment: .leading) {
            Text("Shopping cart").font(.title)
            Button("Reload catalog") { shop.reload(); revision += 1 }
            switch shop.catalogState {
            case .idle: Text("Catalog not loaded")
            case .loading: Text("Loading catalog")
            case .failed: Text("Catalog failed to load")
            case .loaded(let products):
                ForEach(products, id: \.id) { product in
                    HStack {
                        Text("\(product.name): \(product.priceCents) cents")
                        Button("Add") { try? shop.add(id: product.id); revision += 1 }
                    }
                }
            }
            Divider()
            Text("Cart")
            ForEach(shop.cart.lines, id: \.product.id) { line in
                HStack {
                    Text("\(line.product.name) × \(line.quantity)")
                    Button("Remove one") { try? shop.remove(id: line.product.id); revision += 1 }
                }
            }
            Text("Subtotal: \((try? shop.cart.subtotalCents()) ?? 0) cents")
        }.padding().frame(minWidth: 400).id(revision)
    }
}
