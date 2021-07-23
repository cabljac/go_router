import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'shared/data.dart';
import 'shared/pages.dart';

void main() => runApp(App());

/// sample app using the path URL strategy, i.e. no # in the URL path
class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Sub-routes GoRouter Example',
      );

  late final _router = GoRouter(routes: _routesBuilder, error: _errorBuilder);

  List<GoRoute> _routesBuilder(BuildContext context, String location) => [
        GoRoute(
          pattern: '/',
          builder: (context, state) => MaterialPage<HomePage>(
            key: const ValueKey('HomePage'),
            child: HomePage(families: Families.data),
          ),
          routes: [
            GoRoute(
              pattern: 'family/:fid',
              builder: (context, state) {
                final family = Families.family(state.params['fid']!);

                return MaterialPage<FamilyPage>(
                  key: ValueKey(family),
                  child: FamilyPage(family: family),
                );
              },
              routes: [
                GoRoute(
                  pattern: 'person/:pid',
                  builder: (context, state) {
                    final family = Families.family(state.params['fid']!);
                    final person = family.person(state.params['pid']!);

                    return MaterialPage<PersonPage>(
                      key: ValueKey(person),
                      child: PersonPage(family: family, person: person),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ];

  Page<dynamic> _errorBuilder(BuildContext context, GoRouterState state) =>
      MaterialPage<ErrorPage>(
        key: const ValueKey('ErrorPage'),
        child: ErrorPage(message: state.error.toString()),
      );
}