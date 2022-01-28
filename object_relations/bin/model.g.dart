// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Student extends _Student with RealmObject {
  Student(
    int number, {
    String? name,
    int? yearOfBirth,
    School? school,
  }) {
    RealmObject.set(this, 'number', number);
    this.name = name;
    this.yearOfBirth = yearOfBirth;
    this.school = school;
  }

  Student._();

  @override
  int get number => RealmObject.get<int>(this, 'number') as int;
  @override
  set number(int value) => throw RealmUnsupportedSetError();

  @override
  String? get name => RealmObject.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObject.set(this, 'name', value);

  @override
  int? get yearOfBirth => RealmObject.get<int>(this, 'yearOfBirth') as int?;
  @override
  set yearOfBirth(int? value) => RealmObject.set(this, 'yearOfBirth', value);

  @override
  School? get school => RealmObject.get<School>(this, 'school') as School?;
  @override
  set school(covariant School? value) => RealmObject.set(this, 'school', value);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Student._);
    return const SchemaObject(Student, [
      SchemaProperty('number', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('yearOfBirth', RealmPropertyType.int, optional: true),
      SchemaProperty('school', RealmPropertyType.object,
          optional: true, linkTarget: 'School'),
    ]);
  }
}

class School extends _School with RealmObject {
  School(
    String name, {
    String? city,
    School? branchOfSchool,
    Iterable<Student> students = const [],
    Iterable<School> branches = const [],
  }) {
    RealmObject.set(this, 'name', name);
    this.city = city;
    this.branchOfSchool = branchOfSchool;
    RealmObject.set<List<Student>>(this, 'students', students.toList());
    RealmObject.set<List<School>>(this, 'branches', branches.toList());
  }

  School._();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  String? get city => RealmObject.get<String>(this, 'city') as String?;
  @override
  set city(String? value) => RealmObject.set(this, 'city', value);

  @override
  List<Student> get students =>
      RealmObject.get<Student>(this, 'students') as List<Student>;

  @override
  School? get branchOfSchool =>
      RealmObject.get<School>(this, 'branchOfSchool') as School?;
  @override
  set branchOfSchool(covariant School? value) =>
      RealmObject.set(this, 'branchOfSchool', value);

  @override
  List<School> get branches =>
      RealmObject.get<School>(this, 'branches') as List<School>;
  @override
  set branches(covariant List<School> value) =>
      throw RealmUnsupportedSetError();

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(School._);
    return const SchemaObject(School, [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('city', RealmPropertyType.string, optional: true),
      SchemaProperty('students', RealmPropertyType.object,
          linkTarget: 'Student', collectionType: RealmCollectionType.list),
      SchemaProperty('branchOfSchool', RealmPropertyType.object,
          optional: true, linkTarget: 'School'),
      SchemaProperty('branches', RealmPropertyType.object,
          linkTarget: 'School', collectionType: RealmCollectionType.list),
    ]);
  }
}
