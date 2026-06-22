import 'package:currency_converter/core/routing/routes.dart';
import 'package:currency_converter/layout_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: KRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: KRoutes.home,
              builder: (context, state) =>
                  const Center(child: Text('Home Screen')),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: KRoutes.history,
              builder: (context, state) =>
                  const Center(child: Text('History Screen')),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: KRoutes.graph,
              builder: (context, state) =>
                  const Center(child: Text('Graph Screen')),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: KRoutes.settings,
              builder: (context, state) =>
                  const Center(child: Text('Settings Screen')),
            ),
          ],
        ),
      ],
    ),
  ],
);
