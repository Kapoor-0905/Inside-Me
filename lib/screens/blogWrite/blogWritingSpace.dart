import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum _SelectionType {
  none,
  word,
  // line,
}

class BlogWritingSpace extends StatefulWidget {
  const BlogWritingSpace({Key? key}) : super(key: key);

  @override
  State<BlogWritingSpace> createState() => _BlogWritingSpaceState();
}

class _BlogWritingSpaceState extends State<BlogWritingSpace> {

  final FocusNode _focusNode = FocusNode();
  _SelectionType _selectionType = _SelectionType.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(),
      ),
    );
  }
}
