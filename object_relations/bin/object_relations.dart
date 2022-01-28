import 'package:realm_dart/realm.dart';

import 'model.dart';

void main(List<String> arguments) {
  var studentMichele = Student(1)
    ..name = "Michele Ernesto"
    ..yearOfBirth = 2005;
  var studentLoreta = Student(2, name: "Loreta Salvator", yearOfBirth: 2006);
  var studentPeter = Student(3, name: "Peter Ivanov", yearOfBirth: 2007);

  var school131 = School("JHS 131", city: "NY");

  var school131Branch1 = School("First branch 131A", city: "NY Bronx")
    ..branchOfSchool = school131
    ..students.addAll([studentMichele, studentLoreta]);

  studentMichele.school = school131Branch1;
  studentLoreta.school = school131Branch1;

  var school131Branch2 = School("Second branch 131B", city: "NY Bronx")
    ..branchOfSchool = school131
    ..students.add(studentPeter);

  studentPeter.school = school131Branch2;

  school131.branches.addAll([school131Branch1, school131Branch2]);

  var config = Configuration([School.schema, Student.schema]);
  var realm = Realm(config);

  realm.write(() => realm.add(school131));

  PrintDataFromRealm(realm);

  realm.write(() {
    realm.deleteMany(school131.students);
    realm.deleteMany(school131Branch1.students);
    realm.deleteMany(school131Branch2.students);
    realm.deleteMany(school131.branches);
    realm.delete(school131);
  });

  realm.close();
}

void PrintDataFromRealm(Realm realm) {
  print('*** All schools and their students: ');
  var schools = realm.all<School>();
  for (School school in schools) {
    print('  School: ${school.name}');
    for (Student student in school.students) {
      print('    Student: ${student.name}');
    }
  }

  print('*** All students and their related schools: ');
  var students = realm.all<Student>();
  for (Student student in students) {
    print('  Student: ${student.name}');
    print('    School: ${student.school?.name}');
  }

  print('*** Filtered school branches: ');
  var branches = realm.all<School>().query('branchOfSchool != nil');
  for (School branch in branches) {
    print('  Branch: ${branch.name}');
  }

  print('*** Filtered main school: ');
  var mainSchools = realm.all<School>().query('branchOfSchool = nil');
  for (School mainSchool in mainSchools) {
    print('  School: ${mainSchool.name}');
  }
}
