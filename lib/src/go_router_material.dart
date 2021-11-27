// ignore_for_file: diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import '../go_router.dart';

/// Checks for MaterialApp in the widget tree.
bool isMaterialApp(Element elem) =>
    elem.findAncestorWidgetOfExactType<MaterialApp>() != null;

/// Builds a Cupertino page.
MaterialPage<void> pageBuilderForMaterialApp(LocalKey key, Widget child) =>
    MaterialPage<void>(key: key, child: child);

/// Default error page implementation for Material.
class GoRouterMaterialErrorPage extends StatelessWidget {
  /// Provide an exception to this page for it to be displayed.
  const GoRouterMaterialErrorPage(this.error, {Key? key}) : super(key: key);

  /// The exception to be displayed.
  final Exception? error;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(error?.toString() ?? 'page not found'),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      );
}
