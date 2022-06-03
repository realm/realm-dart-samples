import 'package:tasktracker/model.dart';
import 'package:realm_dart/realm.dart';

void main(List<String> arguments) async {
  String appId = "tasktracker-fleld";
  final appConfig = AppConfiguration(appId);
  final app = App(appConfig);
  final user = await app.logIn(Credentials.anonymous());
  final flxConfig = Configuration.flexibleSync(user, [Task.schema]);
  final realm = Realm(flxConfig);
  realm.subscriptions.update((mutableSubscriptions) {
    mutableSubscriptions.add(realm.all<Task>());
  });
  realm.write(() {
    realm.add(Task(ObjectId(), "Send an email", "completed", 4));
    realm.add(Task(ObjectId(), "Create a meeting", "completed", 100));
    realm.add(Task(ObjectId(), "Call the manager", "init", 2));
  });

  realm.subscriptions.update((mutableSubscriptions) {
    mutableSubscriptions.removeByQuery(realm.all<Task>());
    mutableSubscriptions.add(realm.query<Task>(r'status == $0 AND progressMinutes == $1', ["completed", 100]));
  });

  await realm.subscriptions.waitForSynchronization();
  var r = realm.query<Task>(r'status == $0 AND progressMinutes == $1', ["completed", 100]);
  print("Filtered records that matche the query. ${r.length}");

  realm.close();
  Realm.shutdown();
}
