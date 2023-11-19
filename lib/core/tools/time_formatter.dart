class TimeFormatter {
  String relativeTime(DateTime date) {
    try {
      final now = DateTime.now();
      final difference = now.difference(date);
      if (difference.inHours > 24) {
        return "${difference.inHours ~/ 24}d atrás";
      } else if (difference.inHours > 0) {
        return "${difference.inHours}h atrás";
      } else if (difference.inMinutes > 0) {
        return "${difference.inMinutes}m atrás";
      } else {
        return "Agora mesmo";
      }
    } on Exception {
      return "N/A";
    }
  }
}
