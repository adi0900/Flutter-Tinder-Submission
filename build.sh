#!/bin/bash
set -e

# Install Flutter
echo "Installing Flutter..."
cd /tmp
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:/tmp/flutter/bin"

# Verify Flutter installation
flutter --version
flutter doctor -v

# Navigate back to project directory
cd $OLDPWD

# Install dependencies
echo "Installing Flutter dependencies..."
flutter pub get

# Build for web
echo "Building Flutter web app..."
flutter build web --release

echo "Build completed successfully!"