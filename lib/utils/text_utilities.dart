import 'dart:math';

String getTextWithCap(String text, int cap) {
  int textLengthWithSpaces = text.length + text.allMatches(" ").length;
  int rawLength = min(textLengthWithSpaces, cap) == textLengthWithSpaces
      ? text.length
      : cap;
  return "${text.substring(0, rawLength)}${textLengthWithSpaces > cap ? "..." : ""}";
}
