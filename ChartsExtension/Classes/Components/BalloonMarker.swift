//
//  BalloonMarker.swift
//  ChartsDemo-Swift
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import UIKit

open class BalloonMarker: MarkerImage
{
    open var color: UIColor
    open var arrowSize = CGSize(width: 15, height: 11)
    open var circleRadiusHighlightMargin: CGFloat = 0.0
    open var font: UIFont
    open var textColor: UIColor
    open var insets: UIEdgeInsets
    open var minimumSize = CGSize()
    
//    fileprivate var label: String?
    fileprivate var label: NSAttributedString?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key : Any]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets, arrowSize: CGSize, offsetHighlight: CGFloat)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        self.arrowSize = arrowSize
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        self.circleRadiusHighlightMargin = offsetHighlight;
        super.init()
    }
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets, arrowSize: CGSize)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        self.arrowSize = arrowSize
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0

        var origin = point
        origin.x -= width / 2
        origin.y -= height

        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }

    /*
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()

        context.setFillColor(color.cgColor)

        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }

        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
//        label.draw(in: rect, withAttributes: _drawAttributes)
        label.draw(in: rect)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
*/
    
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
//        if isDrawCirclesEnabled {
//            context.saveGState()
//            var rectCircles = CGRect()
//            rectCircles.origin.x = point.x - circleRadius
//            rectCircles.origin.y = point.y - circleRadius
//            rectCircles.size.width = circleRadius * 2
//            rectCircles.size.height = circleRadius * 2
//
//            context.setFillColor(getCircleColor().cgColor)
//            context.fillEllipse(in: rectCircles)
//            context.restoreGState()
//        }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        
        context.saveGState()
        
        context.setFillColor(color.cgColor)

        if offset.y > 0
        {
            let offsetY = CGFloat(self.circleRadius > 0 ? 7 : 1)
            rect.origin.y -= size.height - self.circleRadiusHighlightMargin-offsetY
//            rect.origin.y += self.circleRadiusHighlightMargin+1
            let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height-arrowSize.height)
            let clipPath: CGPath = UIBezierPath(roundedRect: newRect, cornerRadius: newRect.size.height/2).cgPath

            context.addPath(clipPath)
            context.setFillColor(color.cgColor)

            context.closePath()
            context.fillPath()
            
            context.beginPath()
//            context.setFillColor(NSUIColor.blue.cgColor)
            context.move(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y+circleRadius+self.circleRadiusHighlightMargin+1))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y))
            context.fillPath()
            context.strokePath()

            
            
//            
//            context.beginPath()
//            context.move(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
//                y: rect.origin.y + arrowSize.height))
//            //arrow vertex
//            context.addLine(to: CGPoint(
//                x: point.x,
//                y: point.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
//                y: rect.origin.y + arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y + arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y + rect.size.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + rect.size.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + arrowSize.height))
//            context.fillPath()
        }
        else
        {
            rect.origin.y -= size.height + self.circleRadiusHighlightMargin+1
//            let path = UIBezierPath(roundedRect: rect, cornerRadius: 5.0)
//            path.addClip()
            
//            context.saveGState()
            let newRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height-arrowSize.height)
            let clipPath: CGPath = UIBezierPath(roundedRect: newRect, cornerRadius: newRect.size.height/2).cgPath
            
            context.addPath(clipPath)
            context.setFillColor(color.cgColor)
            
            context.closePath()
            context.fillPath()
//            ctx.restoreGState()
            
            context.beginPath()
//            context.setFillColor(UIColor.black.cgColor)

            context.move(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y - circleRadius - self.circleRadiusHighlightMargin - 1))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.fillPath()
            context.strokePath()

//            context.beginPath()
//            context.move(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + rect.size.width,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
////            //arrow vertex
//            context.addLine(to: CGPoint(
//                x: point.x,
//                y: point.y))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y + rect.size.height - arrowSize.height))
//            context.addLine(to: CGPoint(
//                x: rect.origin.x,
//                y: rect.origin.y))
//            context.fillPath()
//            context.strokePath()
        }

        if offset.y > 0 {
//            rect.origin.y += self.insets.top + arrowSize.height
            rect.origin.y += self.insets.top
        } else {
            rect.origin.y += self.insets.top
        }

        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
//        label.draw(in: rect, withAttributes: _drawAttributes)
        label.draw(in: rect)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
//    */
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        if let str = entry.data as? String {
            setLabel(str, entry)
        }
    }
    
    open func setLabel(_ newLabel: String,_ entry: ChartDataEntry)
    {
//        label = newLabel
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
//        _labelSize = newLabel.size(withAttributes: _drawAttributes)
        let newStr = newLabel.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        _labelSize = newStr.size(withAttributes: _drawAttributes)


        
        if let textAttributeMarker = entry.textAttributeMarker {
            label = textAttributeMarker
        } else {
        let newAttributeStr = NSMutableAttributedString(string: newLabel, attributes: [NSAttributedString.Key.font : self.font,NSAttributedString.Key.foregroundColor : self.textColor, NSAttributedString.Key.paragraphStyle : _paragraphStyle ?? NSParagraphStyle.default])
            label = newAttributeStr
        }
        

        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}
