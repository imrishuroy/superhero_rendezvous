import 'package:flutter/material.dart';

import '/constants/route_constants.dart';
import '/models/nav_item.dart';

List<NavItem> destinations = [
  NavItem(
    route: RouteConstants.home,
    label: 'Home',
    icon: Icon(Icons.home),
  ),
  NavItem(
    route: RouteConstants.graphScreen,
    label: 'Graph',
    icon: Icon(Icons.graphic_eq),
  ),
  NavItem(
    route: RouteConstants.experimentScreen,
    label: 'Experiment',
    icon: Icon(Icons.explore_rounded),
  ),
];
