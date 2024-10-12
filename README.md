
# CircularStorySegment

`CircularStorySegment` is a customizable circular progress view in Swift, designed to visually represent progress through segmented arcs, similar to story indicators found in apps like WhatsApp. Each segment can be marked as viewed or remaining, making it perfect for story-based UI components.

## Features

- **Segmented Progress Indicator**: Visualize progress with multiple segments.
- **Customization**: Easily customize colors, segment count, gap width, and line thickness.
- **Automatic Updates**: The view automatically redraws when key properties change, such as the number of viewed segments.
- **Simple API**: A lightweight and easy-to-use component.


## Installation

1. **Manual Installation**:
   - Download the `CircularStorySegment.swift` file.
   - Add it to your Xcode project.
   
   ```bash
   # Clone the repository
   git clone https://github.com/IPSBHANGU/CircularStorySegment.git
   ```

2. **Swift Package Manager**:
   - Coming soon!

## Usage

### 1. Programmatic Usage
Here’s how you can use `CircularStorySegment` in your code:

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize CircularStorySegment with a frame
        let progressView = CircularStorySegment(frame: CGRect(x: 100, y: 100, width: 150, height: 150))

        // Set properties
        progressView.segments = 5               // Set total number of segments
        progressView.viewedSegments = 3         // Set number of segments that are viewed
        progressView.viewedColor = .green       // Customize the viewed segment color
        progressView.remainingColor = .gray     // Customize the remaining segment color
        progressView.lineWidth = 6.0            // Customize the thickness of the segments
        progressView.gapWidth = 2.0             // Customize the gap between segments

        // Add progressView to the view hierarchy
        view.addSubview(progressView)
    }
}
```

### 2. Updating Progress

When the user progresses through stories or steps, simply update the `viewedSegments` property:

```swift
progressView.viewedSegments = 4
```

The view will automatically update and display the new progress.

## Customization

You can customize various properties of the `CircularStorySegment` to fit your design requirements:

| Property         | Description                                                                 | Default Value      |
|------------------|-----------------------------------------------------------------------------|--------------------|
| `segments`       | The total number of segments in the progress indicator.                      | `1`                |
| `viewedSegments` | The number of segments that have been viewed (progress made).                | `0`                |
| `viewedColor`    | The color of the viewed segments.                                            | `systemYellow`     |
| `remainingColor` | The color of the remaining segments.                                         | `gray`             |
| `gapWidth`       | The gap between segments in points.                                          | `2.0`              |
| `lineWidth`      | The thickness of the segment lines in points.                                | `4.0`              |

## Example Usage in a ViewController

```swift
import UIKit

class StoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyProgress = CircularStorySegment(frame: CGRect(x: 50, y: 200, width: 120, height: 120))
        storyProgress.segments = 7
        storyProgress.viewedSegments = 4
        storyProgress.viewedColor = .blue
        storyProgress.remainingColor = .lightGray
        storyProgress.gapWidth = 3
        storyProgress.lineWidth = 5
        view.addSubview(storyProgress)
    }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to contribute by submitting a pull request. Please make sure to follow the existing style and conventions.

---

If you encounter any bugs or have suggestions for new features, please [open an issue](https://github.com/IPSBHANGU/CircularStorySegment/issues).

