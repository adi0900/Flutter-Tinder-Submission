# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Development
- `flutter pub get` - Install dependencies
- `flutter run -d chrome` - Run app in Chrome browser
- `flutter run -d edge` - Run app in Microsoft Edge
- `flutter run -d windows` - Run app on Windows desktop (requires Visual Studio)
- `r` - Hot reload (when app is running)
- `R` - Hot restart (when app is running)
- `q` - Quit app

### Project Setup
- `flutter create . --platforms=windows,web` - Add platform support if missing
- `flutter doctor` - Check Flutter installation and dependencies

## Code Architecture

### Core Design Philosophy
This is a Flutter dating app modeled after Tinder with a focus on smooth animations and polished UI. The app features a soft, elegant design using peach and maroon gradients with sophisticated animation systems.

### Key Architectural Components

**Animation System**: The app heavily relies on custom animations for smooth user experience:
- `SwipeableStackState` exposes public methods for programmatic swiping
- Multiple `AnimationController`s work together (slide, rotation, opacity, scale)
- Animation durations are optimized for 60fps performance (300ms main, 150ms secondary)
- Uses `Listenable.merge()` to combine multiple animations efficiently

**State Management Pattern**: 
- Home screen maintains `GlobalKey<SwipeableStackState>` for controlling swipe animations
- Tab selection state (`_selectedTab`) controls "Nearby" vs "For You" UI
- User list is hardcoded with asset image references

**Design System**: 
- `AppColors` class defines the complete color palette with multiple gradient presets
- Color scheme evolved from harsh contrasts to soft, polished tones
- All shadows and borders use consistent radius values (28px for cards, 25-30px for buttons)

### Critical Implementation Details

**SwipeableStack Widget**:
- Exposes `SwipeableStackState` publicly (not private) for external control
- Implements gesture detection with velocity-based swiping (threshold: 80px or 800px/s)
- Uses `mounted` checks to prevent setState after widget disposal
- Background cards scale to 0.92 with 0.8 opacity for depth effect

**Profile Card System**:
- Must remain as `StatelessWidget` to prevent animation conflicts
- Image loading uses `errorBuilder` for graceful fallbacks
- Interest tags are limited to 3 items using `.take(3)`

**Visual Feedback**:
- Swipe indicators appear at 30px drag threshold
- Like/Nope indicators use gradient backgrounds matching action buttons
- All animations use `Curves.easeOut` for consistency

### Asset Management
- Profile images stored in `assets/images/profiles/`
- Images named after user: `emma.jpg`, `sophie.jpg`, etc.
- Asset paths must be declared in `pubspec.yaml` under both directories

### Performance Considerations
- Profile card pulse animation was removed due to conflicts with swipe animations
- Animation controllers are properly disposed in widget lifecycle
- Complex animation curves (elasticOut, easeOutQuart) replaced with simpler easeOut for better performance
- Reduced animation layers to prevent overdraw issues