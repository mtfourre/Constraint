//
//  Constraint.swift
//
//  Created by Michael Fourre on 8/28/17.
//

import UIKit

public func constrain(_ attributing: NSLayoutConstraint.Attribute?, of constraining: Any?, _ relation: NSLayoutConstraint.Relation? = nil, to attributed: NSLayoutConstraint.Attribute?, of constrained: Any?, by constant: CGFloat? = nil, multiplier: CGFloat? = nil) {
    guard let constraining = constraining else { return }
    NSLayoutConstraint.activate([NSLayoutConstraint(
        item: constraining,
        attribute: attributing ?? .top,
        relatedBy: relation ?? .equal,
        toItem: constrained,
        attribute: attributed ?? .top,
        multiplier: multiplier ?? 1.0,
        constant: constant ?? 0.0
    )])
}

public func constrain(_ attributes: [NSLayoutConstraint.Attribute], of constraining: Any?, to constrained: Any?, by constant: CGFloat? = nil) {
    attributes.forEach({ constrain($0, of: constraining, to: $0, of: constrained, by: constant) })
}

public func constrain(_ attributes: [NSLayoutConstraint.Attribute], of constraining: Any?, by constant: CGFloat?) {
    attributes.forEach({ constrain($0, of: constraining, by: constant) })
}

public func constrain(_ attributing: NSLayoutConstraint.Attribute?, of constraining: Any?, by constant: CGFloat?) {
    constrain(attributing, of: constraining, to: .notAnAttribute, of: nil, by: constant)
}

public func constrain(_ operation: ConstraintOperation) {
    switch operation {
        case .sides(let constraining, let constrained, let constant):
            constrain([.top, .leading, ], of: constraining, to: constrained, by: constant)
            constrain([.bottom, .trailing, ], of: constraining, to: constrained, by: 0.0 - (constant ?? 0.0))
        case .xSides(let constraining, let constrained, let constant):
            constrain(.leading, of: constraining, to: .leading, of: constrained, by: constant)
            constrain(.trailing, of: constraining, to: .trailing, of: constrained, by: 0.0 - (constant ?? 0.0))
        case .ySides(let constraining, let constrained, let constant):
            constrain(.top, of: constraining, to: .top, of: constrained, by: constant)
            constrain(.bottom, of: constraining, to: .bottom, of: constrained, by: 0.0 - (constant ?? 0.0))
    }
}

public enum ConstraintOperation {
    case sides(of: Any?, to: Any?, by: CGFloat?)
    case xSides(of: Any?, to: Any?, by: CGFloat?)
    case ySides(of: Any?, to: Any?, by: CGFloat?)
}
