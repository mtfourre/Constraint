//
//  Constraint.swift
//
//  Created by Michael Fourre on 8/28/17.
//

import UIKit

public func constrain(_ attributing: NSLayoutAttribute?, of constraining: UIView?, _ relation: NSLayoutRelation?, to attributed: NSLayoutAttribute?, of constrained: UIView?, in hierarchy: UIView?, by constant: CGFloat?, multiplier: CGFloat? = nil) {
    guard let constraining = constraining else { return }
    let constraint = NSLayoutConstraint(
        item: constraining,
        attribute: attributing ?? .top,
        relatedBy: relation ?? .equal,
        toItem: constrained,
        attribute: attributed ?? .top,
        multiplier: multiplier ?? 1.0,
        constant: constant ?? 0.0
    )
    let hierarchy = hierarchy ?? constrained ?? constraining
    hierarchy.addConstraint(constraint)
}

public func constrain(_ attributing: NSLayoutAttribute?, of constraining: UIView?, to attributed: NSLayoutAttribute?, of constrained: UIView?, in hierarchy: UIView?, by constant: CGFloat?, multiplier: CGFloat? = nil) {
    constrain(attributing, of: constraining, nil, to: attributed, of: constrained, in: hierarchy, by: constant, multiplier: multiplier)
}

public func constrain(_ attributing: NSLayoutAttribute?, of constraining: UIView?, _ relation: NSLayoutRelation?, to attributed: NSLayoutAttribute?, of constrained: UIView?, by constant: CGFloat?, multiplier: CGFloat? = nil) {
    constrain(attributing, of: constraining, relation, to: attributed, of: constrained, in: nil, by: constant, multiplier: multiplier)
}

public func constrain(_ attributing: NSLayoutAttribute?, of constraining: UIView?, to attributed: NSLayoutAttribute?, of constrained: UIView?, by constant: CGFloat?, multiplier: CGFloat? = nil) {
    constrain(attributing, of: constraining, nil, to: attributed, of: constrained, in: nil, by: constant, multiplier: multiplier)
}

public func constrain(_ attributes: [NSLayoutAttribute], of constraining: UIView?, to constrained: UIView?, in hierarchy: UIView?, by constant: CGFloat?) {
    attributes.forEach({ constrain($0, of: constraining, to: $0, of: constrained, in: hierarchy, by: constant) })
}

public func constrain(_ attributes: [NSLayoutAttribute], of constraining: UIView?, to constrained: UIView?, by constant: CGFloat?) {
    attributes.forEach({ constrain($0, of: constraining, to: $0, of: constrained, by: constant) })
}

public func constrain(_ attributes: [NSLayoutAttribute], of constraining: UIView?, by constant: CGFloat?) {
    attributes.forEach({ constrain($0, of: constraining, by: constant) })
}

public func constrain(_ attributing: NSLayoutAttribute?, of constraining: UIView?, by constant: CGFloat?) {
    constrain(attributing, of: constraining, to: .notAnAttribute, of: nil, by: constant)
}

public func constrain(_ operation: ConstraintOperation) {
    switch operation {
        case .sides(let constraining, let constrained, let constant):
            constrain([.top, .leading, ], of: constraining, to: constrained, by: constant)
            constrain([.bottom, .trailing, ], of: constraining, to: constrained, by: 0.0 - (constant ?? 0.0))
            break
        case .xSides(let constraining, let constrained, let constant):
            constrain(.top, of: constraining, to: .top, of: constrained, by: constant)
            constrain(.bottom, of: constraining, to: .bottom, of: constrained, by: 0.0 - (constant ?? 0.0))
            break
        case .ySides(let constraining, let constrained, let constant):
            constrain(.leading, of: constraining, to: .leading, of: constrained, by: constant)
            constrain(.trailing, of: constraining, to: .trailing, of: constrained, by: 0.0 - (constant ?? 0.0))
            break
    }
}

public enum ConstraintOperation {
    case sides(of: UIView?, to: UIView?, by: CGFloat?)
    case xSides(of: UIView?, to: UIView?, by: CGFloat?)
    case ySides(of: UIView?, to: UIView?, by: CGFloat?)
}

