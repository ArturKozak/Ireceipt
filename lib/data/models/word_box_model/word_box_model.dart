import 'dart:math';

import 'package:flutter/material.dart';

class WordBox {
  final String text;
  final List<Point<int>> vertices;
  final Rect boundingBox;

  WordBox(
    this.text,
    this.vertices,
    this.boundingBox,
  );
}
