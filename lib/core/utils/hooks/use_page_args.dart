import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

T usePageArgs<T>() {
  final context = useContext();
  final args = ModalRoute.of(context)?.settings.arguments;
  if (args is T) return args;
  throw Exception(
      'Arguments type mismatch: Expected $T but given ${args.runtimeType}');
}
