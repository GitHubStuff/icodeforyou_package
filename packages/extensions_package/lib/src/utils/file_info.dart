class FileInfo {
  static String fileNameParase(String content) {
    final regex = RegExp(r'#\d+\s+(.+?):(\d+):\d+');
    final match = regex.firstMatch(content);
    return match == null ? '' : match.group(1)!.replaceAll('(', '');
  }

  static String lineNumberParase(String content) {
    final regex = RegExp(r'#\d+\s+(.+?):(\d+):\d+');
    final match = regex.firstMatch(content);
    return match == null ? '' : match.group(2)!;
  }
}
