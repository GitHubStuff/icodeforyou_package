import 'package:extensions_package/src/src.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum FlogLevel { trace, debug, info, warning, error, fatal, supress }

const _bottomLeftCorner = '└';
const _bottomRightCorner = '┘';
const _verticalLine = '│';
const _topLeftCorner = '┌';
const _topRightCorner = '┐';
const _leftDivider = '├';
const _rightDivider = '┤';
const _singleDivider = '-'; //'┄';
const _spaceCount = 2;

const _iconMap = {
  FlogLevel.trace: '🔬',
  FlogLevel.debug: '🐞',
  FlogLevel.info: 'ℹ️',
  FlogLevel.warning: '🚨',
  FlogLevel.error: '⛔️',
  FlogLevel.fatal: '💀',
};

class FLog {
  FLog({
    this.char = '─',
    this.prefixLength = 5,
    this.lineLength = 110,
    bool pretty = false,
    FlogLevel level = FlogLevel.trace,
  }) : _pretty = pretty,
       _level = level;
  final String char;
  final int prefixLength;
  final int lineLength;
  bool _pretty;
  FlogLevel _level;

  // Public Methods
  void t(dynamic content, {String? pad, String? tag}) =>
      _logWithPretty(content, FlogLevel.trace, pad, tag);
  void d(dynamic content, {String? pad, String? tag}) =>
      _log(content, FlogLevel.debug, pad, tag);
  void i(dynamic content, {String? pad, String? tag}) =>
      _log(content, FlogLevel.info, pad, tag);
  void w(dynamic content, {String? pad, String? tag}) =>
      _log(content, FlogLevel.warning, pad, tag);
  void e(dynamic content, {String? pad, String? tag}) =>
      _log(content, FlogLevel.error, pad, tag);
  void f(dynamic content, {String? pad, String? tag}) =>
      _log(content, FlogLevel.fatal, pad, tag);

  // This setter is intentionally provided without a getter
  // because the value is managed internally and should not be read directly.
  // ignore: avoid_setters_without_getters
  set level(FlogLevel level) => _level = level;

  void stackDump({int? limit = 50}) {
    final stack = StackTrace.current.toString().split('\n');
    debugPrint(_formatHeader('Stack Dump', _singleDivider));
    for (var i = 1; i < (limit ?? stack.length); i++) {
      final fileName = FileInfo.fileNameParase(stack[i]);
      final lineNumber = FileInfo.lineNumberParase(stack[i]);
      final content = '${_timestamp()}- $lineNumber: $fileName:';
      if (fileName.isNotEmpty) debugPrint(content);
    }
    debugPrint(_footerLine(_singleDivider));
  }

  // Private Helper Methods
  bool _isValid(FlogLevel level) => level.index >= _level.index;

  void _log(dynamic content, FlogLevel level, String? pad, String? tag) {
    if (!_isValid(level)) return;

    final icon = tag ?? _iconMap[level] ?? '';
    final headerContent = _caller(StackTrace.current);
    _line(headerContent, pad: ' ');
    final header =
        _pretty
            ? _formatHeader(headerContent, pad ?? char)
            : _line(headerContent, pad: '-');
    _printLog(header, icon);

    if (content is List) {
      for (var i = 0; i < content.length; i++) {
        _printLog(
          _pretty ? _formatBody(content[i].toString()) : content[i].toString(),
          icon,
        );
        if (i != content.length - 1 && _pretty) {
          _printLog(_separatorLine(pad ?? _singleDivider), icon);
        }
      }
    } else {
      _printLog(
        _pretty ? _formatBody(content.toString()) : content.toString(),
        icon,
      );
    }

    if (_pretty) {
      _printLog(_footerLine(pad ?? char), icon);
    }
  }

  void _logWithPretty(
    dynamic content,
    FlogLevel level,
    String? pad,
    String? tag,
  ) {
    if (!_isValid(level)) return;
    final originalPretty = _pretty;
    _pretty = true;
    _log(content, level, pad, tag);
    _pretty = originalPretty;
  }

  String _formatHeader(String content, String pad) =>
      '$_topLeftCorner${_line(content, pad: pad)}$_topRightCorner';

  String _formatBody(String content) =>
      '$_verticalLine${_line(content, pad: ' ', length: 0)}$_verticalLine';

  String _separatorLine(String pad) =>
      '$_leftDivider${''.padRight(lineLength, pad)}$_rightDivider';

  String _footerLine(String pad) =>
      '$_bottomLeftCorner${''.padRight(lineLength, pad)}$_bottomRightCorner';

  String _line(String content, {required String pad, int? length}) {
    length ??= prefixLength;
    final totalLength = lineLength - content.length - length - _spaceCount;
    final leading = ''.padLeft(length, pad);
    final trailing = ''.padRight(totalLength > 0 ? totalLength : 0, pad);
    return '$leading $content $trailing';
  }

  String _caller(StackTrace trace) {
    final index = _pretty ? 3 : 2;
    final traceString = trace.toString().split('\n')[index];
    final fileName = FileInfo.fileNameParase(traceString);
    final lineNumber = FileInfo.lineNumberParase(traceString);
    return '$fileName:$lineNumber'.replaceAll('(', '').replaceAll(')', '');
  }

  String _timestamp() => DateFormat('HH:mm:ss.SS').format(DateTime.now());

  void _printLog(String message, String tag) {
    final space = _pretty ? '' : ' ';
    debugPrint('${_timestamp()} $tag$space$message');
  }
}
