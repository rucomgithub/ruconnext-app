#!/bin/bash

echo "========================================"
echo " RU Connext Icon Generator"
echo "========================================"
echo ""
echo "Step 1: Installing dependencies..."
flutter pub get
echo ""
echo "Step 2: Generating app icons..."
flutter pub run flutter_launcher_icons
echo ""
echo "========================================"
echo " Icon generation completed!"
echo "========================================"
echo ""
echo "Icons have been generated in:"
echo "  - android/app/src/main/res/mipmap-*/"
echo ""
