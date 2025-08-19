# Flutter Dating App 💕

A sophisticated Flutter dating application featuring smooth animations, elegant design, and Tinder-like swipe functionality. Built with modern UI principles and optimized for performance across web and desktop platforms.

<div align="center">
  
  ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
  
</div>

## ✨ Features

### 🎯 Core Functionality
- **Intuitive Swiping**: Gesture-based card swiping with velocity detection
- **Smart Matching**: Randomized match algorithm with celebration animations  
- **Tab Navigation**: "Nearby" and "For You" discovery sections
- **Interactive Controls**: Button-based actions for pass, super like, and like

### 🎨 Design & UX
- **Soft Gradient Theme**: Elegant peach-to-maroon color palette
- **Smooth Animations**: 60fps card transitions with no flickering
- **Modern UI**: Polished interface with subtle shadows and rounded corners
- **Responsive Layout**: Optimized for web browsers and desktop platforms

### ⚡ Performance
- **Optimized Animations**: Multiple animation controllers working in harmony
- **Efficient Rendering**: Reduced overdraw with smart widget composition
- **Hot Reload Support**: Instant development feedback

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Chrome, Edge, or Windows desktop environment

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/adi0900/flutter-dating-app.git
   cd flutter-dating-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For web browsers
   flutter run -d chrome
   flutter run -d edge
   
   # For Windows desktop (requires Visual Studio)
   flutter run -d windows
   ```

## 🏗️ Project Architecture

### Directory Structure
```
lib/
├── main.dart                 # Application entry point
├── constants/
│   └── colors.dart          # Design system & color palette
├── models/
│   └── user.dart           # User data model
├── screens/
│   ├── home_screen.dart    # Main swipe interface
│   └── match_screen.dart   # Match celebration screen
└── widgets/
    ├── profile_card.dart   # User profile display
    └── swipeable_stack.dart # Gesture-based swipe system

assets/
└── images/
    └── profiles/           # User profile images
```

### Key Components

#### SwipeableStack Widget
The heart of the swiping experience, featuring:
- **Gesture Detection**: Supports both drag and velocity-based swiping
- **Animation System**: Multiple controllers for slide, rotation, and opacity
- **Programmatic Control**: External API for button-triggered actions
- **Performance Optimized**: Smooth 60fps animations with proper lifecycle management

#### Design System
Centralized theming with:
- **Color Palette**: Soft, professional gradients
- **Typography**: Clean, readable font hierarchy  
- **Spacing**: Consistent margins and padding
- **Shadows**: Layered depth effects

## 🎨 Design Philosophy

### Visual Identity
- **Primary Gradient**: Soft peach (`#FFF3E0`) to warm maroon (`#D7837F`)
- **Accent Colors**: Complementary tones for interactive elements
- **Modern Aesthetics**: Rounded corners (28px) and subtle shadows

### Animation Principles
- **Smooth Transitions**: 300ms primary animations with easeOut curves
- **Natural Movement**: Physics-based rotation and scaling
- **Visual Feedback**: Immediate response to user interactions

## 🛠️ Development

### Hot Reload Commands
```bash
r    # Hot reload (apply code changes)
R    # Hot restart (reset app state)  
q    # Quit application
```

### Common Tasks

**Add new profile images:**
1. Place images in `assets/images/profiles/`
2. Update `pubspec.yaml` asset declarations
3. Reference in `home_screen.dart` user data

**Customize color scheme:**
- Modify `lib/constants/colors.dart`
- Update gradient definitions
- Rebuild with hot reload

**Adjust animations:**
- Edit duration values in `swipeable_stack.dart`
- Modify easing curves for different feel
- Test performance across platforms

## 📱 Platform Support

| Platform | Status | Notes |
|----------|---------|-------|
| **Web** | ✅ Full Support | Chrome, Edge, Firefox |
| **Windows** | ✅ Full Support | Requires Visual Studio |
| **macOS** | 🔄 Ready | Needs testing |
| **iOS** | 🔄 Ready | Needs testing |
| **Android** | 🔄 Ready | Needs testing |

## 🤝 Contributing

We welcome contributions! Please see our contributing guidelines:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Guidelines
- Follow Flutter/Dart style guidelines
- Maintain 60fps animation performance
- Test across multiple platforms
- Update documentation for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Material Design** for design inspiration
- **Tinder** for the swipe interaction paradigm
- **Community** for feedback and suggestions

---

<div align="center">
  
  **Made with ❤️ using Flutter**
  
  *Star ⭐ this repo if you find it helpful!*
  
</div>
