import 'package:flutter/material.dart';
import 'package:real_downloader/src/style.dart';
import 'package:real_downloader/src/widgets/error_indicator.dart';

class LoadingContainer extends StatefulWidget {
  const LoadingContainer({
    super.key,
    required this.isLoading,
    this.error,
    required this.child,
  });

  final bool isLoading;
  final Object? error;
  final Widget child;

  @override
  State<LoadingContainer> createState() => LoadingContainerState();
}

class LoadingContainerState extends State<LoadingContainer> {
  Object? _error;

  @override
  void initState() {
    super.initState();
    _error = widget.error;
  }

  @override
  void didUpdateWidget(LoadingContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLoading != widget.isLoading) {
      if (widget.isLoading) {
        _error = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LoadingOverlay(
          isLoading: widget.isLoading,
          child: widget.child,
        ),
        if (_error != null) ...[
          Gaps.p8,
          ErrorIndicator(
            error: _error!,
          ),
        ],
      ],
    );
  }

  void resetError() {
    setError(null);
  }

  void setError(Object? error) {
    setState(() {
      _error = error;
    });
  }
}

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    this.barrierColor,
    required this.child,
  });

  final bool isLoading;
  final Color? barrierColor;
  final Widget child;

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  var _showOverlay = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0) //
        .animate(_controller);

    _fadeAnimation.addStatusListener(_handleAnimation);

    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        if (_showOverlay) //
          Positioned.fill(
            top: -5,
            bottom: -5,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: LoadingBarrier(
                barrierColor: widget.barrierColor,
              ),
            ),
          ),
      ],
    );
  }

  void _handleAnimation(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      setState(() {
        _showOverlay = true;
      });
    } //

    else if (status == AnimationStatus.dismissed) {
      setState(() {
        _showOverlay = false;
      });
    }
  }
}

class LoadingBarrier extends StatelessWidget {
  const LoadingBarrier({
    super.key,
    this.barrierColor,
  });

  final Color? barrierColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AbsorbPointer(
      child: Container(
        color: barrierColor ?? theme.colorScheme.surface.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
