import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Color> color = [
  Colors.white,
  Colors.red.withOpacity(0.5),
  Colors.orange.withOpacity(0.8),
  Colors.amber.withOpacity(0.5),
  Colors.green.withOpacity(0.5),
  Colors.blue.withOpacity(0.8)
];
final DateFormat dateFormat = DateFormat('d MMM yyy, h:mm a');

// final DateFormat dateFormat = DateFormat('EEEE, d MMM yyy, h:mm a');
enum ActionType {
  addNote,
  editNote,
}
