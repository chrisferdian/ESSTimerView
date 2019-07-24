//
//  ESSTimerView.swift
//  TimerProject
//
//  Created by Chris Ferdian on 11/03/19.
//  Copyright © 2019 Chris Ferdian. All rights reserved.
//
import UIKit

/**
 * ESSTimerView class.
 * This class is responsible to create and run timer view.
 * @author    Chris Ferdian <chrisferdian@onoff.insure>
 */
@IBDesignable
class ESSTimerView: UIView {
    
    @IBInspectable var timerFont:UIFont = UIFont.preferredFont(forTextStyle: .body) {
        didSet {
            setupLabelView()
        }
    }
    /**
     * Initialize active Color
     */
    @IBInspectable var activeColor:UIColor = UIColor.hexStringToUIColor(hex: "#00C853") {
        didSet {
            setupLabelView()
        }
    }
    
    /**
     * Initialize inactive color
     */
    @IBInspectable var inactiveColor:UIColor = UIColor.hexStringToUIColor(hex: "#E0E0E0") {
        didSet {
            setupLabelView()
        }
    }
    
    /**
     * Initialize warning color
     */
    @IBInspectable var warningColor:UIColor = UIColor.hexStringToUIColor(hex: "#a83a32") {
        didSet {
            setupLabelView()
        }
    }
    
    /**
     * Initialize text Color
     */
    @IBInspectable var textColor:UIColor = .white {
        didSet {
            setupLabelView()
        }
    }
    
    /**
     * Timerview protocol
     */
    var timerDelegate:ESSTimerDelegate?
    
    /**
     * Initialize labels array
     */
    var labels = [UILabel]()
    /**
     * Initialize Timer object.
     */
    var timer = Timer()
    /**
     * Initialze timer state
     */
    var isTimerRunning = false
    /**
     * Dummy number of seconds
     */
    var seconds = 10
    /**
     * Initialze timeInterval object
     */
    var time:TimeInterval?
    /**
     * Initialize Stackview
     */
    let stackView = UIStackView(frame: .zero)
    
    /**
     * Preapre coder layer
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabelView()
    }
    
    /**
     * Prepare for storyboard
     */
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupLabelView()
    }
    
    /**
     * Preapre view frame
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabelView()
    }
    
    /**
     * Run timer with interval 1 second
     */
    func runTimer() {
        time = TimeInterval(seconds)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(timerUpdate)), userInfo: nil, repeats: true)
    }
    
    /**
     * Trigger function when interval has done
     */
    @objc func timerUpdate() {
        if seconds > 0 {
            seconds -= 1
            time = TimeInterval(seconds)
            timeString()
        } else {
            timer.invalidate()
            resetCountTimer()
        }
    }
    
    /**
     * Convert time to hourm minutes, and second
     */
    func timeString() {
        let hours = Int(time!) / 3600
        let minutes = Int(time!) / 60 % 60
        let seconds = Int(time!) % 60

        if hours > 0 {
            labels[0].text = String(format: "%02d", hours)
            labels[1].text = String(format: "%02d", minutes)
            labels[2].text = String(format: "%02d", seconds)
            updateColor()
        } else if hours == 0 && minutes > 0 {
            labels[0].text = "00"
            labels[1].text = String(format: "%02d", minutes)
            labels[2].text = String(format: "%02d", seconds)
            updateColor()
        } else {
            labels[0].text = "00"
            labels[1].text = "00"
            labels[2].text = String(format: "%02d", seconds)
            updateColor()
        }
    }
    
    /**
     * trigger when interval done
     */
    private func updateColor() {
        for i in 0...4 {
            UIView.animate(withDuration: 0.2, animations: {
                let baseView = self.stackView.arrangedSubviews[i] as? ESSCardView
                baseView?.backgroundColor = self.stateColor()
            })
        }
    }
    
    /**
     * Getting color per state
     */
    private func stateColor() -> UIColor {
        if seconds >= 1800 {
            return activeColor
        } else if seconds <= 1800 && seconds >= 600 {
            return .red
        } else if seconds <= 600 && seconds > 0 {
            return .red
        }
        
        return inactiveColor
    }
    
    /**
     * Reset countdown timer
     */
    private func resetCountTimer() {
        for i in 0...4 {
            UIView.animate(withDuration: 0.2, animations: {
                let baseView = self.stackView.arrangedSubviews[i] as? ESSCardView
                baseView?.backgroundColor = self.inactiveColor
            })
        }
    }
    
    /**
     * setup stackview and labels
     */
    func setupLabelView() {
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        for i in 0...2 {
            let containerNumber = ESSCardView(frame: .zero)
            containerNumber.translatesAutoresizingMaskIntoConstraints = false
            containerNumber.backgroundColor = self.inactiveColor
            
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "0\(i)"
            label.font = timerFont
            label.textColor = textColor
            
            containerNumber.addSubview(label)
            label.leadingAnchor.constraint(equalTo: containerNumber.leadingAnchor, constant: 5).isActive = true
            label.trailingAnchor.constraint(equalTo: containerNumber.trailingAnchor, constant: -5).isActive = true
            label.topAnchor.constraint(equalTo: containerNumber.topAnchor, constant: 5).isActive = true
            label.bottomAnchor.constraint(equalTo: containerNumber.bottomAnchor, constant: -5).isActive = true
            self.labels.append(label)
            
            stackView.addArrangedSubview(containerNumber)
            if i < 2 {
                let label = UILabel(frame: .zero)
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = ":"
                label.font = timerFont
                label.textColor = .gray
                stackView.addArrangedSubview(label)
            }
        }
        DispatchQueue.main.async {
            self.addSubview(self.stackView)
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
}
