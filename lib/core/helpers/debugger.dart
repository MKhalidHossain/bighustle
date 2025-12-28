import 'package:flutter/widgets.dart';

class ErrorDebugger {
  static ErrorNode firstNode = ErrorNode(message: "No Error");
  static ErrorNode? lastNode;

  void debug() {
    ErrorNode? currentNode = firstNode;
    while(currentNode != null) {
      print(currentNode.message);
      currentNode = currentNode.child;
    }
  }
}

class ErrorNode {
  final UniqueKey key = UniqueKey();
  final String message;
  ErrorNode? _child;
  ErrorNode? get child => _child;

  ErrorNode({required this.message});

  void next({required String message}) {
    _child ??= ErrorNode(message: "No Error");
  }
}
