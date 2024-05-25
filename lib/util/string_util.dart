import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StringUtil {
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
  static String convertFirstLetterSmall(String input) {
    if (input.isEmpty) return input;
    return input[0].toLowerCase() + input.substring(1);
  }
  static String formatSize(double size, int index) {
    return size.toStringAsFixed(index % 2 == 0 ? 0 : 1);
  }

  static String formatRelativeDate(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day) {
      return 'Today';
    } else if (timestamp.year == yesterday.year &&
        timestamp.month == yesterday.month &&
        timestamp.day == yesterday.day) {
      return 'Yesterday';
    } else {
      final formatter = DateFormat('MMM dd, yyyy');
      return formatter.format(timestamp);
    }
  }
  static String formattedDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); // Convert Timestamp to DateTime
    return StringUtil.formatRelativeDate(dateTime);
  }
}
