//
//  StackViewExtension.swift
//  MusicPlayer
//
//  Created by Tamuna Kakhidze on 10.05.24.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
