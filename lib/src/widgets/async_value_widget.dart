import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/widgets/info_indicator.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
    this.value, {
    super.key,
    required this.data,
    this.error,
    this.loading,
    this.alignment = Alignment.center,
  });

  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T data) data;
  final Widget Function(BuildContext context, Object error, StackTrace stackTrace)? error;
  final Widget Function(BuildContext context)? loading;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncData(:final value) => data(context, value),
      AsyncError(:final error, :final stackTrace) => this.error?.call(context, error, stackTrace) ?? //
          Align(
            alignment: alignment,
            child: ErrorIndicator(
              error: error,
            ),
          ),
      _ => loading?.call(context) ?? //
          const Center(
            child: CircularProgressIndicator(),
          )
    };
  }
}
