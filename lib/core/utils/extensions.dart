extension StringExtensions on String {
  bool get isEmail {
    return RegExp(
      r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(this);
  }

  String get capitalize {
    if (isEmpty) return this;

    return '${this[0].toUpperCase()}${substring(1)}';
  }
}