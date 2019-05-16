String formatDate(DateTime date) {
  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return '${date.day} ${monthNames[date.month - 1]}, ${date.year}';
}

String elapsedTimeFormatted(DateTime date) {
  Duration difference = date.difference(DateTime.now());

  if (difference.inDays < 0) {
    return difference.inDays.abs().toString() + ' days ago';
  }

  if (difference.inHours < 0) {
    return difference.inHours.abs().toString() + ' hours ago';
  }

  if (difference.inMinutes < 0) {
    return difference.inMinutes.abs().toString() + ' minutes ago';
  }

  if (difference.inSeconds < -10) {
    return difference.inSeconds.abs().toString() + ' seconds ago';
  }

  return 'Just now';
}
