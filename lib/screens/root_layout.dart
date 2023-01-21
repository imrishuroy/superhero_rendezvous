import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_platform/universal_platform.dart';

import '/constants/navigation_destinations.dart';
import '/widgets/adaptive_navigation.dart';

class RootLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const RootLayout({
    super.key,
    required this.currentIndex,
    required this.child,
  });
  static const _switcherKey = ValueKey('switcherKey');
  static const _navigationRailKey = ValueKey('navigationRailKey');

  @override
  Widget build(BuildContext context) {
    void onSelected(int index) {
      final destination = destinations[index];
      context.goNamed(destination.route);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return AdaptiveNavigation(
          key: _navigationRailKey,
          destinations: destinations,
          selectedIndex: currentIndex,
          onSelected: onSelected,
          child: _Switcher(
            key: _switcherKey,
            child: child,
          ),
        );
      },
    );
  }
}

class _Switcher extends StatelessWidget {
  final Widget child;

  const _Switcher({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UniversalPlatform.isDesktop
        ? child
        : AnimatedSwitcher(
            key: key,
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: child,
          );
  }
}
