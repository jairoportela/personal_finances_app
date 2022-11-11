import 'package:flutter/material.dart';
import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/view/create_category_page.dart';

class RouteGenerator {
  static const createPageRoute = CategoryCreatePage.routeName;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case createPageRoute:
        final category = settings.arguments as Category?;
        return MaterialPageRoute(
          builder: (context) => CategoryCreatePage(
            category: category,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
