import 'package:personal_finances_app/categories/models/category.dart';
import 'package:test/test.dart';

void main() {
  group('Category', () {
    group('fromJson', () {
      test('returns correct Category object', () {
        expect(
          Category.fromJson(
            <String, dynamic>{
              'id': '700271ee-67a5-4063-97cd-c57e87c7a457',
              'icon': {'type': 'emoji', 'emoji': '🎒'},
              'properties': {
                'Name': {
                  'id': 'title',
                  'type': 'title',
                  'title': [
                    {
                      'type': 'text',
                      'text': {'content': 'Educación', 'link': null},
                      'annotations': {
                        'bold': false,
                        'italic': false,
                        'strikethrough': false,
                        'underline': false,
                        'code': false,
                        'color': 'default'
                      },
                      'plain_text': 'Educación',
                      'href': null
                    }
                  ]
                }
              },
            },
          ),
          isA<Category>()
              .having(
                (w) => w.id,
                'id',
                '700271ee-67a5-4063-97cd-c57e87c7a457',
              )
              .having(
                (w) => w.name,
                'name',
                'Educación',
              )
              .having((w) => w.icon.iconType, 'iconType', IconType.emoji)
              .having((w) => w.icon.emoji, 'emoji', '🎒'),
        );
      });
    });
  });
}
