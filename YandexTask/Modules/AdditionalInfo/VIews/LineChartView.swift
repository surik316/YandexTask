//
//  LineChartView.swift
//  YandexTask
//
//  Created by maksim.surkov on 25.07.2021.
//

import Foundation
import UIKit
class LineChatView: UIView {
    private let lainColor = Colors.graphColor
    private var graphPoints = [Int]()
    private struct Constans {
        static let margin: CGFloat = 0.0
        static let topBorder: CGFloat = 50
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 1
    }
    private var circleLayer: CAShapeLayer!
    init(points: [Int]) {
        super.init(frame: .zero)
        graphPoints = points
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let margin = Constans.margin
        let graphWidth = width - margin * 2 - 5
        
        let columnXPoint = {
            (clumnl: Float) -> CGFloat in
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(clumnl) * spacing + margin
        }
        let graphHeight = CGFloat(height) - Constans.topBorder - Constans.bottomBorder
        let maxValue = graphPoints.max()!
        let cloumnYPoint =  {
            (graphPoint: Float) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * CGFloat(graphHeight)
            return CGFloat(graphHeight + Constans.topBorder - y)
        }
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: cloumnYPoint(Float(graphPoints[0]))))
        for (index, value) in graphPoints.enumerated() {
            let nextPoint = CGPoint(x: columnXPoint(Float(index)), y: cloumnYPoint(Float(value)))
            graphPath.addLine(to: nextPoint)
        }
        circleLayer = CAShapeLayer()
        circleLayer.path = graphPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = lainColor.cgColor
        circleLayer.lineWidth = 2.0
        circleLayer.strokeEnd = 1.0
        layer.addSublayer(circleLayer)
    }
}
