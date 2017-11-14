# Constraint
Small module for performing basic autolayout constraint operations in application code

AutoLayout operations are almost always performed in the Interface Builder. However, sometimes it is necessary to perform some constraint operations in application code. Consider for example the following example where a nib is instantiated inside a UIView initializer:

    import UIKit
    
    class ExampleView: UIView {
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            let views = Bundle.main.loadNibNamed("ExampleView", owner: self, options: nil)
            if let view = views?.first as? UIView {
                self.addSubview(view)
            }
        }
    }

In this instance, the newly added subview is not constrained in any way to the parent view. Generally, this would be solved by manually adding some amount of constraints to solidify the parent/child view relationship. In many cases, this would be achieved by setting space constraints of 0 to Top, Trailing, Bottom, and Leading sides. Using the standard API, this can be achieved in the following way:

    ...
    
    if let view = views?.first as? UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        self.addConstraint(top)
        let trailing = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        self.addConstraint(trailing)
        let bottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.addConstraint(bottom)
        let leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        self.addConstraint(leading)
    }
    
    ...

The Constraint module simplifies this interaction by initializing and applying the constraints automatically, accessible by an API which covers the majority of the common cases with some customization. For example, the previous example would be reduced to:

    ...
    
    if let view = views?.first as? UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        constrain(.sides(of: view, to: self, by: 0.0))
    }
    
    ...

The API supports some variation with these. Included is an example of a function in another module which helps constrain programmatically generated views:

    func constrainViews(in top: UIView) {
        constrain(.width, of: container, to: .width, of: top, by: 0.0, multiplier: 0.8)
        constrain(.bottom, of: container, to: .bottom, of: top, by: -30.0)
        constrain(.centerX, of: container, to: .centerX, of: top, by: 0.0)
        constrain(.width, of: background, .lessThanOrEqual, to: .width, of: container, by: 0.0)
        constrain(.centerX, of: background, to: .centerX, of: container, by: 0.0)
        constrain(.xSides(of: background, to: container, by: 0.0))
        constrain(.sides(of: label, to: background, by: 8.0))
    }

As can be seen in the example above, there is support for many different types of constraint operations, simply provided in a more streamlined API.
