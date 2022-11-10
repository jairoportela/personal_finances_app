import 'dart:io';

import 'package:personal_finances_app/categories/models/category.dart';
import 'package:personal_finances_app/categories/models/category_error.dart';
import 'package:personal_finances_app/config/constants.dart';
import 'package:personal_finances_app/provider/api_provider.dart';

class CategoryRepository {
  CategoryRepository(this.client);
  static const _categoriesDatabaseId = '81fae8384c1943f6b16f953a009d7ac3';

  Future<Categories> getCategories() async {
    try {
      final data = await client.readData(
          'https://api.notion.com/v1/databases/$_categoriesDatabaseId/query', {
        HttpHeaders.authorizationHeader: 'Bearer ${Environment.notionApiKey}',
        'Notion-Version': '2022-06-28',
      });

      return Categories.fromJson(data);
    } catch (error) {
      throw const CategoriesError(message: 'Error al traer las categorias');
    }
  }

  final ApiProvider client;
}
