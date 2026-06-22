import 'package:currency_converter/core/routing/routes.dart';
import 'package:currency_converter/core/service_locator/dependency_injection.dart';
import 'package:currency_converter/features/history/domain/usecases/clear_conversion_history_use_case.dart';
import 'package:currency_converter/features/history/domain/usecases/delete_currency_conversion_item_use_case.dart';
import 'package:currency_converter/features/history/domain/usecases/get_currency_history_use_case.dart';
import 'package:currency_converter/features/history/presentation/cubit/history_cubit.dart';
import 'package:currency_converter/features/history/presentation/screens/history_screen.dart';
import 'package:currency_converter/features/home/domain/usecases/get_currencies_use_case.dart';
import 'package:currency_converter/features/home/domain/usecases/get_exchange_rates_use_case.dart';
import 'package:currency_converter/features/home/domain/usecases/save_conversion_record_use_case.dart';
import 'package:currency_converter/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_converter/features/home/presentation/screens/home_screen.dart';
import 'package:currency_converter/features/settings/presentation/screens/settings_screen.dart';
import 'package:currency_converter/layout_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: KRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => BlocProvider<HistoryCubit>(
        create: (_) => HistoryCubit(
          getIt<GetCurrencyHistoryUseCase>(),
          getIt<DeleteCurrencyConversionItemUseCase>(),
          getIt<ClearConversionHistoryUseCase>(),
        )..loadConversionHistory(),
        child: LayoutScaffold(navigationShell: navigationShell),
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: KRoutes.home,
              builder: (context, state) => BlocProvider<CurrencyCubit>(
                create: (_) => CurrencyCubit(
                  getIt<GetExchangeRatesUseCase>(),
                  getIt<GetCurrenciesUseCase>(),
                  getIt<SaveConversionLogUseCase>(),
                )..getExchangeRates("EGP", "USD"),
                child: const HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: KRoutes.history,
              builder: (context, state) => const HistoryScreen(),
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
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
