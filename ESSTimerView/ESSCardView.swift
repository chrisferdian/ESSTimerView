//
//  ESSCardView.swift
//  TimerProject
//
//  Created by Chris Ferdian on 11/03/19.
//  Copyright © 2019 Chris Ferdian. All rights reserved.
//

import UIKit

/**
 * OnoffCardView class.
 * This class is responsible to create cardView.
 * @author    Chris Ferdian <chrisferdian@onoff.insure>
 */
class ESSCardView: UIView {
    /**
     * Initialized corner radius of cardView
     */
    fileprivate let cornerRadius:CGFloat = 6
    /**
     * Initialized shadow radius of cardView
     */
    var shadowRadius:CGFloat = 6
    /**
     * Initialized shadow offside of cardView
     */
    var shadowOffside = CGSize(width: 0, height: 1)
    
    /**
     * Prepare layer
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    /**
     * Prepare frame
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    /**
     * Prepare interface builder
     */
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupLayer()
    }
    
    /**
     * Create style for cardView
     */
    func setupLayer() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = shadowOffside
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.masksToBounds = false
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = UIColor.hexStringToUIColor(hex: "#333366").cgColor
    }
}
