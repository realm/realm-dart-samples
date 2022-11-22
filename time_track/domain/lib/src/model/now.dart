import 'package:domain/src/domain_base.dart';
import 'package:realm_dart/realm.dart';

import 'category.dart';

part 'now.g.dart';

@RealmModel()
class $Now {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  @MapTo('time')
  late int microsecondsSinceEpoch;

  $Category? category;
}

extension NowEx on Now {
  Now repeat() => realm.newNow(category!);

  Now? get next => realm.firstEntryAfter(DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch));

  Duration? get duration {
    final n = next;
    return n != null ? Duration(microseconds: n.microsecondsSinceEpoch - microsecondsSinceEpoch) : null;
  }

  DateTime get time => DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  set time(DateTime value) => microsecondsSinceEpoch = value.microsecondsSinceEpoch;
}
