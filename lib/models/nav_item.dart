import 'package:flutter/material.dart';

class NavItem {
  final String route;
  final String label;
  final Icon icon;
  final Widget? child;

  NavItem({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });
}
