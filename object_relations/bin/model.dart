import 'dart:io';
import 'package:realm_dart/realm.dart';

part 'model.g.dart';

@RealmModel()
class _Student {
  @PrimaryKey()
  late final int number;
  late String? name;
  late int? yearOfBirth;
  late _School? school;
}

@RealmModel()
class _School {
  @PrimaryKey()
  late final String name;
  late String? city;
  final List<_Student> students = [];
  late _School? branchOfSchool;
  late final List<_School> branches;
}
