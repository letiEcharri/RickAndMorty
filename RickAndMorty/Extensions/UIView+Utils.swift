//
//  UIView+Utils.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 29/4/24.
//

import UIKit

public struct ConstraintsConstants {
    public var top: CGFloat
    public var bottom: CGFloat
    public var leading: CGFloat
    public var trailing: CGFloat

    public init(top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
    }

    public init(constant: CGFloat) {
        self.top = constant
        self.bottom = constant
        self.leading = constant
        self.trailing = constant
    }
}

enum ViewPosition {
    /// Notice: It should already  have a height constraint
    case top
    /// Notice: It should already  have a height constraint
    case bottom
    case free
}

extension UIView {
    
    func fit(to view: UIView, constant: CGFloat = 0, safeAreaLayout: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: safeAreaLayout ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor,
                                 constant: constant),
            bottomAnchor.constraint(equalTo: safeAreaLayout ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor,
                                    constant: -constant),
            leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                     constant: constant),
            trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                      constant: -constant)
        ])
    }
    
    func fit(to view: UIView, with constants: ConstraintsConstants, position: ViewPosition = .free, safeAreaLayout: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        var constraints = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                     constant: constants.leading),
            trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                      constant: -constants.trailing)
        ]
        switch position {
        case .top:
            constraints.append(topAnchor.constraint(equalTo: safeAreaLayout ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor,
                                                    constant: constants.top))
        case .bottom:
            constraints.append(bottomAnchor.constraint(equalTo: safeAreaLayout ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor,
                                                      constant: -constants.bottom))
        case .free:
            constraints.append(contentsOf: [
                topAnchor.constraint(equalTo: safeAreaLayout ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor,
                                     constant: constants.top),
                bottomAnchor.constraint(equalTo: safeAreaLayout ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor,
                                        constant: -constants.bottom)
            ])
        }
        NSLayoutConstraint.activate(constraints)
    }

    func fit(to view: UIView, with constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate(constraints)
    }
}
