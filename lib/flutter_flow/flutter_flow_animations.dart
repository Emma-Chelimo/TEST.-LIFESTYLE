import 'package:flutter/material.dart';
// Removed flutter_animate import to avoid conflicts; using custom simple effects.

// Animation trigger types
class AnimationTrigger {
  static const String onPageLoad = 'onPageLoad';
  static const String onPageShow = 'onPageShow';
  static const String onActionTrigger = 'onActionTrigger';
  static const String onHover = 'onHover';
  static const String onTap = 'onTap';
}

// Animation info class
class AnimationInfo {
  final String trigger;
  final List<SimpleEffect> Function()? effectsBuilder;
  final Duration? duration;
  final Duration? delay;

  const AnimationInfo({
    required this.trigger,
    this.effectsBuilder,
    this.duration,
    this.delay,
  });
}

// Simple effect interface (avoids depending on flutter_animate's EffectEntry)
abstract class SimpleEffect {
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
  );
}

// Animation effects
class FadeEffect extends SimpleEffect {
  final double begin;
  final double end;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  FadeEffect({
    required this.begin,
    required this.end,
    required this.duration,
    this.delay = Duration.zero,
    this.curve = Curves.linear,
  });

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
  ) {
    return FadeTransition(
      opacity: Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: controller, curve: curve),
      ),
      child: child,
    );
  }
}

class SlideEffect extends SimpleEffect {
  final Offset begin;
  final Offset end;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  SlideEffect({
    required this.begin,
    required this.end,
    required this.duration,
    this.delay = Duration.zero,
    this.curve = Curves.linear,
  });

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
  ) {
    return SlideTransition(
      position: Tween<Offset>(begin: begin, end: end).animate(
        CurvedAnimation(parent: controller, curve: curve),
      ),
      child: child,
    );
  }
}

class ScaleEffect extends SimpleEffect {
  final double begin;
  final double end;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  ScaleEffect({
    required this.begin,
    required this.end,
    required this.duration,
    this.delay = Duration.zero,
    this.curve = Curves.linear,
  });

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
  ) {
    return ScaleTransition(
      scale: Tween<double>(begin: begin, end: end).animate(
        CurvedAnimation(parent: controller, curve: curve),
      ),
      child: child,
    );
  }
}

// Animation mixin for widgets
mixin AnimationMixin<T extends StatefulWidget>
    on State<T>, TickerProviderStateMixin<T> {
  final Map<String, AnimationInfo> animationsMap = {};
  final Map<String, AnimationController> animationControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    for (String key in animationsMap.keys) {
      final animationInfo = animationsMap[key]!;
      final controller = AnimationController(
        duration: animationInfo.duration ?? const Duration(milliseconds: 600),
        vsync: this,
      );
      animationControllers[key] = controller;

      if (animationInfo.trigger == AnimationTrigger.onPageLoad) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    for (var controller in animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget animateOnPageLoad(Widget child, String animationKey) {
    final controller = animationControllers[animationKey];
    if (controller == null) return child;

    final animationInfo = animationsMap[animationKey];
    if (animationInfo?.effectsBuilder == null) return child;

    final effects = animationInfo!.effectsBuilder!();
    Widget animatedChild = child;

    for (var effect in effects) {
      animatedChild = effect.build(
        context,
        animatedChild,
        controller,
      );
    }

    return animatedChild;
  }
}
