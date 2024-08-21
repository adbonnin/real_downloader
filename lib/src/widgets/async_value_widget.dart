import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_downloader/src/widgets/info_indicator.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
  });

  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T data) data;
  final Widget Function(BuildContext context, Object error, StackTrace stackTrace)? error;
  final Widget Function(BuildContext context)? loading;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncData(:final value) => data(context, value),
      AsyncError(:final error, :final stackTrace) => this.error?.call(context, error, stackTrace) ?? //
          Center(
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
