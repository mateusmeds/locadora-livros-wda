import 'package:flutter/material.dart';

class DevolutionOfBooksStatusData {
  DevolutionOfBooksStatusData({
    required this.totalBooks,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;
  final int totalBooks;
}
