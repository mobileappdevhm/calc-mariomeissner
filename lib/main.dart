import 'package:flutter/material.dart';
import './calculator.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MaterialApp(
    home: new Calculator(),
    )
  );
}