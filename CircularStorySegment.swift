//
//  CircularStorySegment.swift
//  testing
//
//  Created by Inderpreet Singh on 13/06/24.
//

import UIKit

/**
 A customizable circular progress view that visually represents progress as a series of segmented arcs.
 
 The `CircularStorySegment` is designed to visually display progress in the form of a circle divided into segments.
 Each segment represents a "story" or "step," and segments can be marked as viewed or remaining, similar to the story progress indicators seen in apps like Instagram or WhatsApp.
 
 ## Features:
 - You can specify how many segments there are (`segments` property).
 - The number of segments that have been viewed can be updated (`viewedSegments` property).
 - The colors for viewed and remaining segments are customizable (`viewedColor` and `remainingColor`).
 - The width of the gap between segments and the thickness of the segment lines are also adjustable (`gapWidth` and `lineWidth`).
 - The view automatically updates itself whenever one of its key properties is changed.

 ## Properties:
 - `segments`: The total number of segments. Each segment represents a portion of the circle. Setting this will trigger a redraw of the view.
 - `viewedSegments`: The number of segments that have been viewed. These will be drawn with the `viewedColor`. Setting this will also trigger a redraw.
 - `viewedColor`: The color used for viewed segments. Defaults to `systemYellow`.
 - `remainingColor`: The color used for remaining (non-viewed) segments. Defaults to `gray`.
 - `gapWidth`: The gap between segments. This is a CGFloat value in points that represents how much space to leave between segments. Defaults to 2.0.
 - `lineWidth`: The thickness of the lines drawn for the segments. Defaults to 4.0 points.

 ## Initializers:
 - `init(frame: CGRect)`: Initializes a `CircularStorySegment` with a specific frame.
 - `init?(coder: NSCoder)`: Required for initializing from Interface Builder, e.g., if using a storyboard or xib.

 ## Drawing:
 - The `draw(_:)` method calculates and draws the arcs based on the number of segments and how many have been viewed.
 - The segments are drawn in two stages: first the remaining (non-viewed) segments, and then the viewed segments, each with their respective colors.

 ## How it Works:
 - The circle is divided into `segments` equal parts, represented as arcs.
 - Viewed segments are drawn using the `viewedColor`, and remaining segments are drawn using the `remainingColor`.
 - If there are multiple segments, a small gap is added between each segment to visually separate them, controlled by `gapWidth`.
 - The start and end angles for each arc are calculated dynamically, considering the total number of segments and the gaps between them.

 ## How to Use:

 1. **Programmatic Initialization:**
    ```swift
    let progressView = CircularStorySegment(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    progressView.segments = 5 // Set total number of segments
    progressView.viewedSegments = 3 // Set number of segments that are viewed
    progressView.viewedColor = .green // Customize the viewed segment color
    progressView.remainingColor = .lightGray // Customize the remaining segment color
    progressView.lineWidth = 6.0 // Customize the thickness of the segments
    progressView.gapWidth = 2.0 // Customize the gap between segments
    view.addSubview(progressView)
    ```

 2. **Updating Progress:**
    When the progress changes, for example when a new "story" is viewed, you can simply update the `viewedSegments` property and the view will automatically redraw itself:
    ```swift
    progressView.viewedSegments = 4
    ```

 3. **Customization:**
    You can customize the appearance of the progress view by modifying its various properties:
    - `viewedColor`: Set this to change the color of the viewed segments.
    - `remainingColor`: Set this to change the color of the remaining (non-viewed) segments.
    - `gapWidth`: Adjust this to increase or decrease the spacing between segments.
    - `lineWidth`: Modify this to control the thickness of the segment lines.

 ## Example Usage in a ViewController:
 
 ```swift
 class ViewController: UIViewController {
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         let progressView = CircularStorySegment(frame: CGRect(x: 100, y: 100, width: 150, height: 150))
         progressView.segments = 6
         progressView.viewedSegments = 2
         progressView.viewedColor = .blue
         progressView.remainingColor = .lightGray
         progressView.lineWidth = 8
         progressView.gapWidth = 3
         view.addSubview(progressView)
     }
 }
 */

class CircularStorySegment: UIView {
    
    var segments: Int = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var viewedSegments: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var viewedColor: UIColor = .systemYellow {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var remainingColor: UIColor = .gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var gapWidth: CGFloat = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lineWidth: CGFloat = 4.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        guard segments > 0 else { return }
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        
        let totalAngle: CGFloat = 2 * .pi
        let segmentAngle = totalAngle / CGFloat(segments)
        let gapAngle = gapWidth / radius
        
        // Adjust the start angle based on whether we have more than 1 segment
        var currentStartAngle: CGFloat
        if segments == 1 {
            // No gap for 1 segment
            currentStartAngle = -CGFloat.pi / 2
        } else {
            // Add gap at the start for more than 1 segment
            currentStartAngle = -CGFloat.pi / 2 + gapAngle / 2
        }
        
        // Draw remaining segments first (non-viewed)
        for i in 0..<(segments - viewedSegments) {
            let startAngle = currentStartAngle
            let endAngle = startAngle + segmentAngle - (segments > 1 ? gapAngle : 0)
            
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = lineWidth
            remainingColor.setStroke()
            path.stroke()
            
            // Move to the next segment
            currentStartAngle = endAngle + (segments > 1 ? gapAngle : 0)
        }
        
        // Draw viewed segments at the end
        for i in 0..<viewedSegments {
            let startAngle = currentStartAngle
            let endAngle = startAngle + segmentAngle - (segments > 1 ? gapAngle : 0)
            
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = lineWidth
            viewedColor.setStroke()
            path.stroke()
            
            // Move to the next segment
            currentStartAngle = endAngle + (segments > 1 ? gapAngle : 0)
        }
    }
}

