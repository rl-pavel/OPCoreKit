// swift-tools-version: 5.6
import PackageDescription

extension BuildItem {
  static let opFoundation: BuildItem = .init(name: "OPFoundation")
  static let opCombine: BuildItem = .core(name: "OPCombine")

  static let opTypography: BuildItem = .core(name: "OPTypography")
  static let opSwiftUI: BuildItem = .core(name: "OPSwiftUI")
  static let opUIKit: BuildItem = .core(name: "OPUIKit")
}

var items: [BuildItem] = [
  .opFoundation, .opCombine,
  .opTypography, .opSwiftUI,
]

#if os(iOS)
items.append(contentsOf: [
  .opUIKit
])
#elseif os(macOS)
items.append(contentsOf: [
  
])
#endif

let package = Package(
  name: "OPCore",
  platforms: [.iOS(.v14), .macOS(.v12)],
  products: items.map(\.library),
  targets: items.map(\.target)
)


// MARK: - Helpers

struct BuildItem {
  let name: String
  let dependency: Target.Dependency
  let dependencies: [Target.Dependency]
  let resources: [Resource]
  
  var library: Product { .library(name: name, targets: [name]) }
  var target: Target { .target(name: name, dependencies: dependencies, resources: resources) }
  
  init(
    name: String,
    dependency: Target.Dependency? = nil,
    dependencies: [Target.Dependency] = [],
    resources: [Resource] = []) {
      self.name = name
      self.dependency = dependency ?? .init(stringLiteral: name)
      self.dependencies = dependencies
      self.resources = resources
    }
  
  init(name: String, dependencies: [BuildItem], resources: [Resource] = []) {
    self.init(name: name, dependency: nil, dependencies: dependencies.map(\.dependency), resources: resources)
  }
  
  static func core(name: String, adding extras: [BuildItem] = [], resources: [Resource] = []) -> BuildItem {
    .init(name: name, dependencies: [.opFoundation] + extras, resources: resources)
  }
}
