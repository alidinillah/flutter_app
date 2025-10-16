import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String formatReleaseDate(String dateString) {
  if (dateString.isEmpty) return '-';
  try {
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);
    DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(dateTime);
  } catch (e) {
    debugPrint('Error parsing date: $dateString, $e');
    return dateString; // Return original if parsing fails
  }
}