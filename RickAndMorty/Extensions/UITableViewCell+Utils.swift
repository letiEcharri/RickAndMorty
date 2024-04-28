//
//  UITableViewCell+Utils.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 29/4/24.
//

import UIKit

extension UITableViewCell {
    @objc func clearCell() {
        contentView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }

    static var identifier: String {
        String(describing: self)
    }
}
