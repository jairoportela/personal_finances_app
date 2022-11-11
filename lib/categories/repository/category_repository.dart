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
      final data = await client.postData(
        apiUrl:
            'https://api.notion.com/v1/databases/$_categoriesDatabaseId/query',
        headers: {
          'Notion-Version': '2022-06-28',
          HttpHeaders.authorizationHeader: 'Bearer ${Environment.notionApiKey}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: {
          'sorts': [
            {'property': 'Name', 'direction': 'ascending'}
          ]
        },
      );

      return Categories.fromJson(data);
    } catch (error) {
      throw const CategoriesError(message: 'Error al traer las categorias');
    }
  }

  Future<Category> createCategory(Category newCategory) async {
    try {
      final data = await client.postData(
        apiUrl: 'https://api.notion.com/v1/pages',
        headers: {
          'Notion-Version': '2022-06-28',
          HttpHeaders.authorizationHeader: 'Bearer ${Environment.notionApiKey}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: {
          'parent': {'database_id': _categoriesDatabaseId},
          ...newCategory.toJson(),
        },
      );

      return Category.fromJson(data);
    } catch (error) {
      throw const CategoriesError(message: 'Error al crear la categoría');
    }
  }

  Future<Category> editCategory(Category editedCategory) async {
    try {
      final data = await client.patchData(
        apiUrl: 'https://api.notion.com/v1/pages/${editedCategory.id}',
        headers: {
          'Notion-Version': '2022-06-28',
          HttpHeaders.authorizationHeader: 'Bearer ${Environment.notionApiKey}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: editedCategory.toJson(),
      );

      return Category.fromJson(data);
    } catch (error) {
      throw const CategoriesError(message: 'Error al editar la categoría');
    }
  }

  final ApiProvider client;
}
