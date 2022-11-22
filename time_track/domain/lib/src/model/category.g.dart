// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Category extends $Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    ObjectId id,
    String name, {
    Styling? styling,
    Category? parent,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'styling', styling);
    RealmObjectBase.set(this, 'parent', parent);
  }

  Category._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Styling? get styling =>
      RealmObjectBase.get<Styling>(this, 'styling') as Styling?;
  @override
  set styling(covariant Styling? value) =>
      RealmObjectBase.set(this, 'styling', value);

  @override
  Category? get parent =>
      RealmObjectBase.get<Category>(this, 'parent') as Category?;
  @override
  set parent(covariant Category? value) =>
      RealmObjectBase.set(this, 'parent', value);

  @override
  RealmResults<Category> get subCategories =>
      RealmObjectBase.get<Category>(this, 'subCategories')
          as RealmResults<Category>;
  @override
  set subCategories(covariant RealmResults<Category> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Category._);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('_id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('styling', RealmPropertyType.object,
          optional: true, linkTarget: 'Styling'),
      SchemaProperty('parent', RealmPropertyType.object,
          optional: true, linkTarget: 'Category'),
      SchemaProperty('subCategories', RealmPropertyType.linkingObjects,
          linkOriginProperty: 'parent',
          collectionType: RealmCollectionType.list,
          linkTarget: 'Category'),
    ]);
  }
}

class Styling extends $Styling
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  Styling({
    int color = 0,
    String? icon,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Styling>({
        'color': 0,
      });
    }
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'icon', icon);
  }

  Styling._();

  @override
  int get color => RealmObjectBase.get<int>(this, 'color') as int;
  @override
  set color(int value) => RealmObjectBase.set(this, 'color', value);

  @override
  String? get icon => RealmObjectBase.get<String>(this, 'icon') as String?;
  @override
  set icon(String? value) => RealmObjectBase.set(this, 'icon', value);

  @override
  Stream<RealmObjectChanges<Styling>> get changes =>
      RealmObjectBase.getChanges<Styling>(this);

  @override
  Styling freeze() => RealmObjectBase.freezeObject<Styling>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Styling._);
    return const SchemaObject(ObjectType.embeddedObject, Styling, 'Styling', [
      SchemaProperty('color', RealmPropertyType.int),
      SchemaProperty('icon', RealmPropertyType.string, optional: true),
    ]);
  }
}
