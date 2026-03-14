//
//  SettingsViewController.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import UIKit

// MARK: - ResizableButton
public class ResizableButton: UIButton {
    public override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.width, height: .greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(
            width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right,
            height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
        )
        return desiredButtonSize
    }
}

// MARK: - CustomButton
@IBDesignable open class DiginableButton: UIButton {
    public var customButtonSize: DiginableButtonSize = .large {
        didSet { updateSize() }
    }
    
    @IBInspectable private var etSize: Int {
        get { customButtonSize.rawValue }
        set { customButtonSize = DiginableButtonSize(rawValue: newValue) ?? .large }
    }
    
    public var customButtonType: DiginableButtonType = .primary {
        didSet { updateTypeAndState() }
    }
    
    @IBInspectable private var etType: Int {
        get { customButtonType.rawValue }
        set { customButtonType = DiginableButtonType(rawValue: newValue) ?? .primary }
    }
    
    public var customButtonState: DiginableButtonState = .default1 {
        didSet { updateTypeAndState() }
    }
    
    @IBInspectable private var etState: Int {
        get { customButtonState.rawValue }
        set { customButtonState = DiginableButtonState(rawValue: newValue) ?? .default1 }
    }
    
    public init(customButtonSize: DiginableButtonSize = .large, customButtonType: DiginableButtonType = .primary, customButtonState: DiginableButtonState = .default1) {
        super.init(frame: .zero)
        self.customButtonSize = customButtonSize
        self.customButtonType = customButtonType
        self.customButtonState = customButtonState
        setup()
    }
    
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override public func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        if widthConstraint == nil {
            widthConstraint = NSLayoutConstraint.addWidthConstraint(view: self, withWidth: customButtonSize.getWidth(for: self))
            widthConstraint?.priority = .init(999)
            widthConstraint?.isActive = true
        } else {
            widthConstraint?.constant = customButtonSize.getWidth(for: self)
        }
        layoutIfNeeded()
    }
    
    internal func setup() {
        layer.cornerRadius = frame.height / 2
    }
    
    private func updateSize() {
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint.addHeightConstraint(view: self, withHeight: customButtonSize.getHeight())
            heightConstraint?.priority = .init(999)
            heightConstraint?.isActive = true
        } else {
            heightConstraint?.constant = customButtonSize.getHeight()
        }
        
        if widthConstraint == nil {
            widthConstraint = NSLayoutConstraint.addWidthConstraint(view: self, withWidth: customButtonSize.getWidth(for: self))
            widthConstraint?.priority = .init(999)
            widthConstraint?.isActive = true
        } else {
            widthConstraint?.constant = customButtonSize.getWidth(for: self)
        }
        
        updateTypeAndState()
        self.titleLabel?.font = customButtonSize.getTextFont()
    }
    
    private func updateTypeAndState() {
        self.titleLabel?.numberOfLines = 1
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        layer.borderWidth = customButtonType.getBorderWidth(for: customButtonState)
        layer.borderColor = customButtonType.getBorderColor(for: customButtonState)
        backgroundColor = customButtonType.getBackgroundColor(for: customButtonState)
        layer.cornerRadius = customButtonState.getCornerRadius(size: customButtonSize)
        
        let textColor = customButtonType.getTextColor(for: customButtonState)
        setTitleColor(textColor, for: .normal)
        tintColor = textColor
    }
}

// MARK: - ETCustomButtonSize
@objc public enum DiginableButtonSize: Int {
    case large = 1, medium = 2, small = 3
    
    func getHeight() -> CGFloat {
        switch self {
        case .large: return 48.0
        case .medium: return 36.0
        case .small: return 24.0
        }
    }
    
    func getWidth(for button: UIButton) -> CGFloat {
        if let text = button.title(for: .normal) {
            let labelSize = text.size(withAttributes: [.font: self.getTextFont()])
            let imageWidth = button.imageView?.frame.width ?? 0.0
            let padding = button.titleEdgeInsets.left + button.titleEdgeInsets.right + imageWidth + button.imageEdgeInsets.left + button.imageEdgeInsets.right
            return labelSize.width + padding + 24.0
        }
        return 0.0
    }
    
    func getTextFont() -> UIFont {
        switch self {
        case .large:
            return UIFont(name: Constants.FontNames.ProximaSemiBold, size: 16.0) ?? UIFont.boldSystemFont(ofSize: 16.0)
        case .medium:
            return UIFont(name: Constants.FontNames.ProximaSemiBold, size: 14.0) ?? UIFont.boldSystemFont(ofSize: 14.0)
        case .small:
            return UIFont(name: Constants.FontNames.ProximaRegular, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
        }
    }
}

// MARK: - ETCustomButtonType
@objc public enum DiginableButtonType: Int {
    case primary = 1
    case secondary = 2
    
    func getBorderWidth(for state: DiginableButtonState) -> CGFloat{
        switch self {
        case .primary:
            switch state {
            case .default2:
                return 1.0
            default: return 0.0
            }
        case .secondary:
            return 1.0
        }
    }
    
    func getBorderColor(for state: DiginableButtonState) -> CGColor {
            switch self {
            case .primary:
                switch state {
                case .disabled: return UIColor(hex: "dddddd").cgColor
                case .default2: return UIColor(hex: "2563EB").cgColor
                default: return UIColor.clear.cgColor
                }
            case .secondary:
                switch state {
                default: return UIColor.clear.cgColor
                }
            }
        }

    
    func getBackgroundColor(for state: DiginableButtonState) -> UIColor {
            switch self {
            case .primary:
                switch state {
    
                case .default1:
                    return UIColor(hex: "2563EB")
                case .default2:
                    return UIColor(hex: "FFFFFF")
                case .disabled:
                    return UIColor(hex: "f9f8f3")
                default: return UIColor.clear
                }
            case .secondary:
                return UIColor.clear
            }
        }
    
    func getTextColor(for state: DiginableButtonState) -> UIColor {
        switch self {
        case .primary:
            switch state {
            case .default1: return UIColor(hex: "FFFFFF")
            case .default2: return UIColor(hex: "2563EB")
            case .disabled: return UIColor(hex: "dddddd")
            default: return UIColor.clear
            }
        case .secondary:
            switch state {
            case .default1, .default2:
                return UIColor(hex: "2563EB")
            case .disabled: return UIColor(hex: "dddddd")
            default: return UIColor.clear
            }
        }
    }
}

// MARK: - ETCustomButtonState
@objc public enum DiginableButtonState: Int {
    case default1 = 1, default2 = 2, disabled = 3
    
    func getCornerRadius(size: DiginableButtonSize) -> CGFloat {
        return size.getHeight() / 2
    }
}

// MARK: - NSLayoutConstraint Helpers
extension NSLayoutConstraint {
    static func addHeightConstraint(view: UIView, withHeight height: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal,
                                  toItem: nil, attribute: .notAnAttribute,
                                  multiplier: 1.0, constant: height)
    }
    
    static func addWidthConstraint(view: UIView, withWidth width: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal,
                                  toItem: nil, attribute: .notAnAttribute,
                                  multiplier: 1.0, constant: width)
    }
}

