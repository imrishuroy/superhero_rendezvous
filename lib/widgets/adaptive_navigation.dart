import 'package:flutter/material.dart';

import '/models/nav_item.dart';

class AdaptiveNavigation extends StatelessWidget {
  final List<NavItem> destinations;
  final int selectedIndex;
  final Function(int) onSelected;
  final Widget child;

  const AdaptiveNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  extended: constraints.maxWidth >= 800,
                  minExtendedWidth: 180,
                  minWidth: 58,
                  destinations: destinations
                      .map(
                        (item) => NavigationRailDestination(
                          icon: item.icon,
                          label: Text(item.label),
                          // padding: EdgeInsets.zero,
                        ),
                      )
                      .toList(),
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onSelected,
                ),
                Expanded(
                  child: child,
                )
              ],
            ),
          );
        }
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            destinations: destinations
                .map(
                  (item) => NavigationDestination(
                    icon: item.icon,
                    label: item.label,
                  ),
                )
                .toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: onSelected,
          ),
          body: child,
        );
      },
    );
  }
}
