import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/constants/route_constants.dart';
import '/screens/details_screen.dart';
import '/screens/experiment_screen.dart';
import '/screens/graph_screen.dart';
import '/screens/home_screen.dart';
import '/screens/root_layout.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

class RouteConfig {
  static final appRouter = GoRouter(
    routes: [
      GoRoute(
        name: RouteConstants.home,
        path: '/',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: _pageKey,
          child: RootLayout(
            key: _scaffoldKey,
            currentIndex: 0,
            child: const HomeScreen(),
          ),
        ),
        routes: [
          GoRoute(
            path: 'details/:id',
            name: RouteConstants.detailsScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: RootLayout(
                key: _scaffoldKey,
                currentIndex: 0,
                child: DetailsScreen(
                  id: state.params['id'],
                ),
              ),
            ),
          )
        ],
      ),
      GoRoute(
        name: RouteConstants.graphScreen,
        path: '/graph',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: _pageKey,
          child: RootLayout(
            key: _scaffoldKey,
            currentIndex: 1,
            child: const GraphScreen(),
          ),
        ),
      ),
      GoRoute(
        name: RouteConstants.experimentScreen,
        path: '/experiment',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: _pageKey,
          child: RootLayout(
            key: _scaffoldKey,
            currentIndex: 2,
            child: const ExperimentScreen(),
          ),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('Not Found'),
        ),
      ),
    ),
  );
}
