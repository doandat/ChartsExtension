//
//  ChartDataEntryBase.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import UIKit

open class ChartDataEntryBase: NSObject
{
    /// the y value
    @objc open var y = 0.0
    
    /// optional spot for additional data this Entry represents
    @objc open var data: Any?
    
    /// optional icon image
    @objc open var icon: NSUIImage?
    @objc open var iconHighlight: NSUIImage?
    @objc open var textAttributeMarker: NSAttributedString?
    @objc open var colorHighlight: NSUIColor?
    
    public override required init()
    {
        super.init()
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - y: the y value (the actual value of the entry)
    @objc public init(y: Double)
    {
        super.init()
        
        self.y = y
    }
    
    /// - Parameters:
    ///   - y: the y value (the actual value of the entry)
    ///   - data: Space for additional data this Entry represents.
    
    @objc public convenience init(y: Double, data: Any?)
    {
        self.init(y: y)
        
        self.data = data
    }
    
    /// - Parameters:
    ///   - y: the y value (the actual value of the entry)
    ///   - icon: icon image
    
    @objc public convenience init(y: Double, icon: NSUIImage?)
    {
        self.init(y: y)

        self.icon = icon
    }
    @objc public convenience init(y: Double, icon: NSUIImage?, iconHighlight: NSUIImage?)
    {
        self.init(y: y)
        self.iconHighlight = iconHighlight
        self.icon = icon
    }
    
    @objc public convenience init(y: Double, icon: NSUIImage?, iconHighlight: NSUIImage?, colorHighlight: NSUIColor?)
    {
        self.init(y: y)
        self.iconHighlight = iconHighlight
        self.colorHighlight = colorHighlight
        self.icon = icon
    }
    
    @objc public convenience init(y: Double, icon: NSUIImage?, iconHighlight: NSUIImage?, colorHighlight: NSUIColor?, textAttributeMarker: NSMutableAttributedString?)
    {
        self.init(y: y, icon: icon, iconHighlight: iconHighlight, colorHighlight: colorHighlight)
        self.iconHighlight = iconHighlight
        self.colorHighlight = colorHighlight
        self.textAttributeMarker = textAttributeMarker
        self.icon = icon
    }

    
    /// - Parameters:
    ///   - y: the y value (the actual value of the entry)
    ///   - icon: icon image
    ///   - data: Space for additional data this Entry represents.
    
    @objc public convenience init(y: Double, icon: NSUIImage?, data: Any?)
    {
        self.init(y: y)

        self.icon = icon
        self.data = data
    }

    // MARK: NSObject
    
    open override var description: String
    {
        return "ChartDataEntryBase, y \(y)"
    }
}

// MARK: Equatable
extension ChartDataEntryBase/*: Equatable*/ {
    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ChartDataEntryBase else { return false }

        if self === object
        {
            return true
        }

        return y == object.y
    }
}
