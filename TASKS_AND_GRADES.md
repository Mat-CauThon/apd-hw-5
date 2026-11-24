# HW5 — Public Contract and Automatic Rubric

All money is in integer cents. Implement the existing public declarations in the starter without renaming or removing them. You may add private types and functions. Public test inputs follow the rules below; private tests may change values or combine these rules but do not add unpublished requirements. The starter tests are examples, not the full grading suite. No points are awarded for visual polish, class count, prose quality, or a particular architecture diagram.

## Module boundaries — 3 points

The Swift package must retain targets named `CartDomain`, `CatalogData`, and `ShoppingApp`, with direct dependencies exactly as follows. Each row is worth 1 point and is evaluated from `swift package dump-package`:

| Target | Direct target dependencies |
|---|---|
| CartDomain | none |
| CatalogData | CartDomain |
| ShoppingApp | CartDomain and CatalogData |

The staff test target must be able to import and execute the three modules. Keep the provided `ArchitectureTests` target and its dependencies. The package may retain `ShopDemo`; do not add further dependencies to the three graded targets. The manifest is executable Swift and the automated dependency check is a structural check, not a proof of overall architectural quality.

## Cart domain — 3 points

`Product` has immutable `id`, `name`, and `priceCents`; it is equatable and Codable. A `Cart` begins empty. Adding appends a new line in first-addition order with quantity 1. Adding an identical product again increments its quantity. A product is invalid if its ID or name is an empty string, if its price is negative, or if its ID already belongs to a non-identical product in the cart. Invalid adds throw `CartError.invalidProduct` and do not change the cart. Whitespace-only names are allowed; zero prices are allowed.

Removing by ID decrements the quantity, removing the line when it reaches zero. Removing an unknown ID throws `CartError.unknownProduct` and leaves the cart unchanged. Re-adding a removed product puts its line at the end. `subtotalCents()` returns the sum of quantity times price; arithmetic overflow throws `CartError.overflow`. If incrementing quantity would overflow, `add` throws `.overflow` without changing the cart.

- **2 points:** add/remove/order/quantity and subtotal behavior, including unknown removal.
- **1 point:** product validation, unchanged state on failure, and subtotal overflow.

## Data sources — 2 points

`CatalogSource.load()` returns `[Product]` or throws. `LocalCatalog(data:)` decodes the supplied `Data` as a top-level JSON array of products with the exact keys `id`, `name`, and `priceCents`; JSON decoding errors propagate. Preserve array order. `RemoteCatalog(fetch:)` calls the injected closure exactly once per `load()`, then decodes the returned data in the same way. Transport and decoding errors propagate. Neither implementation performs validation beyond Codable decoding, network calls, caching, or retries.

- **1 point:** local decoding and malformed JSON failure.
- **1 point:** remote closure injection, once per load, and transport/decoding failure.

## Presentation state — 3 points

`Shop(source:)` retains the injected `CatalogSource`. Its initial `catalogState` is `.idle` and its cart is empty. Each synchronous `reload()` first sets `.loading`, then invokes the source exactly once; success replaces state with `.loaded(products)` (including an empty array), and any failure sets `.failed`. Reload never modifies the cart. `add(id:)` finds the first product with that ID in the current `.loaded` list and delegates to the cart; if no such product exists, including in `.idle` or `.failed`, it throws `CartError.unknownProduct`. `remove(id:)` delegates to the cart regardless of catalog state. Errors leave the cart as specified above.

- **2 points:** successful load, injected source, and cart updates through the shop.
- **1 point:** loading is observable inside the injected source; source failure produces `.failed` and add from a failed state throws `.unknownProduct`.

The provided SwiftUI shell displays the state and calls these interfaces; it is provided for exploration. It is not scored for appearance or UI behavior.

## Repository evidence — 1 point

`README.md`, `PLAN.md`, and `AGENT_WORKLOG.md` must each exist at the package root and have a nonzero byte count. This is an automated presence check only. Students remain responsible for documenting actual agent use. The starter includes templates to complete.

## Bonus: Inject a discount strategy — 4 points

`checkoutTotal(cart:strategy:)` asks the injected `DiscountStrategy` for the discount once, passing the subtotal in cents. If the discount is negative or greater than the subtotal, throw `CheckoutError.invalidDiscount`; otherwise return subtotal minus discount. Propagate cart overflow. No concrete discount type is prescribed. The grader injects different strategies and invalid discounts. The bonus interface is present in the starter, so leaving its implementation as a stub does not prevent base grading.

## Running and grading

From the package root run `swift test` and `swift run ShopDemo` (macOS). CI should run `swift test` on a clean macOS runner. The staff grader copies the committed package to an isolated workspace, substitutes its own `ArchitectureTests` source, inspects the package manifest, and runs each grading category using XCTest. Tests require no external network; staff must enforce network isolation in the grading environment. Each category is all-or-nothing; one test may check multiple published behaviors. A completed failing test earns zero for its category. A manifest, build, test-discovery, timeout, or infrastructure error produces no score; staff must diagnose and rerun. No manual judgment affects the score. Staff may run grading code only in an isolated, disposable environment because submitted Swift packages execute arbitrary code.
