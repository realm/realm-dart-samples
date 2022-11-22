import 'package:domain/domain.dart';
import 'package:realm_dart/realm.dart';

final app = App(AppConfiguration('time_track-phhcg'));

final realm = () {
  final realm = Realm(Configuration.flexibleSync(app.currentUser!, schemaObjects));
  realm.subscriptions.update((mutableSubscriptions) {
    mutableSubscriptions.add(realm.all<Now>());
    mutableSubscriptions.add(realm.all<Category>());
  });
  return realm;
}();
