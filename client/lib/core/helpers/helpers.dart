import 'package:intl/intl.dart';

class Helpers {
  static String timeAgo(int millisecondsSinceEpoch) {
    // Convert milliseconds to DateTime object
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inDays > 365) return DateFormat.yMMMd().format(dateTime);
    if (diff.inDays > 30) return DateFormat.yMMMd().format(dateTime);
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }
}
