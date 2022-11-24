// swift-tools-version: 5.7
import PackageDescription

// MARK: - Package

let OPFoundation: BuildItem = .init(name: "OPFoundation")
let OPCombine: BuildItem = .init(name: "OPCombine")
let OPTypography: BuildItem = .init(name: "OPTypography", dependencies: [OPFoundation])
let OPSwiftUI: BuildItem = .init(name: "OPSwiftUI", dependencies: [OPFoundation])
let OPUIKit: BuildItem = .init(name: "OPUIKit")

let items: [BuildItem] = [
  OPFoundation, OPCombine,
  OPTypography, OPSwiftUI,
  OPUIKit
]

let package = Package(
  name: "OPCore",
  platforms: [.iOS(.v15), .macOS(.v12)],
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
}
