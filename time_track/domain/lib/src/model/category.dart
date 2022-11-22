import 'package:realm_dart/realm.dart';

part 'category.g.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String name;

  $Styling? styling;

  $Category? parent;

  @Backlink(#parent)
  late Iterable<$Category> subCategories;
}

@RealmModel(ObjectType.embeddedObject)
class $Styling {
  int color = 0;
  String? icon;
}

extension CategoryEx on Category {
  String get fullName {
    final p = parent;
    return p != null && p.parent != null ? '${p.fullName}, $name' : name;
  }
}
