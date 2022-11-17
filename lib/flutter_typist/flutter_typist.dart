import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class FlutterTypist extends StatefulWidget {
  final String text;
  final VoidCallback? onTypingCompleted;
  final TextDirection? textDirection;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final Color? selectionColor;

  const FlutterTypist({
    Key? key,
    required this.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.selectionColor,
    this.onTypingCompleted,
  }) : super(key: key);

  @override
  State<FlutterTypist> createState() => _FlutterTypistState();
}

class _FlutterTypistState extends State<FlutterTypist> {
  late String _remainingText;
  late String _currentText;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _currentText = "";
    _remainingText = widget.text;
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTextStyle(
        style: widget.style ?? const TextStyle(color: Colors.black),
        child: Text(
          _currentText,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          locale: widget.locale,
          softWrap: widget.softWrap,
          overflow: widget.overflow,
          textScaleFactor: widget.textScaleFactor,
          maxLines: widget.maxLines,
          semanticsLabel: widget.semanticsLabel,
          textWidthBasis: widget.textWidthBasis,
          selectionColor: widget.selectionColor,
        ),
      ),
    );
  }

  void _startAnimation() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      log("timer started $_currentText");
      _currentText += _remainingText.characters.first;
      _remainingText = _remainingText.substring(1);
      setState(() {});
      if (_remainingText.isEmpty) {
        timer.cancel();
        widget.onTypingCompleted?.call();
      }
    });
  }
}
