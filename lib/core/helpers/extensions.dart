extension ChatTimestamp on DateTime {
  String toChatTimeString() {
    final hour12 = hour == 0 ? 12 : hour > 12 ? hour - 12 : hour;
    final minuteStr = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minuteStr $period';
  }
}