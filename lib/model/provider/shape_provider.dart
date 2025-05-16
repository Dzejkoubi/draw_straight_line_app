import 'package:flutter/material.dart';

class ShapeProvider extends ChangeNotifier {
  // List with the available shapes

  int shapesLength = 4;

  int activeShapeIndex = 0;

  // Method to set the active shape
  // This method will be called when the user selects a shape from the list of shapes
  // It updates the activeShapeIndex and notifies listeners to rebuild the UI with the new active shape
  void setActiveShape(int index) {
    if (index >= 0 && index < shapesLength) {
      activeShapeIndex = index;
      notifyListeners();
    }
  }

  // Method to change shape to next shape
  void changeActiveShape() {
    if (activeShapeIndex >= 0 && activeShapeIndex < shapesLength) {
      activeShapeIndex = activeShapeIndex + 1;
      notifyListeners();
    } else {
      activeShapeIndex = 0; // Reset to the first shape if out of bounds
      notifyListeners();
    }
  }
}
