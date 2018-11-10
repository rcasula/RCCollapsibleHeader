//
//  CollapsingHeaderViewDelegate.swift
//  RCCollapsibleHeader
//
//  Created by Roberto Casula on 10/11/2018.
//

import UIKit

public protocol CollapsingHeaderViewDelegate: class {
    func onHeaderDidAnimate(with percentage: CGFloat)
}
