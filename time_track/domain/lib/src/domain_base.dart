import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:realm_dart/realm.dart';
import 'package:crypto/crypto.dart';

import 'model/category.dart';
import 'model/now.dart';

extension DateTimeEx on DateTime {
  DateTime get midnight => DateTime(year, month, day);
  String get formatted => '${hour.twoDigits}:${minute.twoDigits}:${second.twoDigits}';
}

extension DurationEx on Duration {
  String get formatted {
    if (inSeconds < 1) {
      return '${inMilliseconds}ms';
    }
    return '$inHours:${(inMinutes % 60).twoDigits}:${(inSeconds % 60).twoDigits}';
  }

  String get formattedShort {
    final h = inHours;
    final hourString = h > 0 ? '$h:' : '';
    final m = inMinutes % 60;
    final minuteString = m > 0 ? '${h > 0 ? m.twoDigits : '$m'}:' : '';
    final s = inSeconds % 60;
    final secondString = m > 0 ? s.twoDigits : '$s';
    return '$hourString$minuteString$secondString';
  }
}

extension IntEx on int {
  String get twoDigits => '$this'.padLeft(2, '0');
}

extension RealmEx on Realm {
  RealmResults<Now> entriesSince(DateTime since) => query<Now>(r'time > $0 SORT(time ASCENDING)', [since.microsecondsSinceEpoch]);

  RealmResults<Now> get allEntries => query<Now>('TRUEPREDICATE SORT(time ASCENDING)');

  RealmResults<Now> get allEntriesReversed => query<Now>('TRUEPREDICATE SORT(time DESCENDING)');

  Now? get latestEntry => allEntriesReversed.firstOrNull;

  Now? firstEntryAfter(DateTime time) => entriesSince(time).firstOrNull;

  void clear() {
    deleteAll<Now>();
    deleteAll<Category>();
  }

  // not live
  Iterable<Category> get allCategories => _root.subCategories.expand((c) => c.subCategories);

  static final _root = Category(''.hash(Uint8List(0)).asObjectId, '');
  Category getCategory(Iterable<String> name) {
    return name.fold(_root, (parent, n) => getCategoryByParent(parent, n));
  }

  Category getCategoryByParent(Category parent, String name) {
    final oid = name.hash(parent.id.bytes).asObjectId; // deterministic!
    final c = findOrAdd(oid, () => Category(oid, name, parent: parent));
    assert(c.parent == parent);
    return c;
  }

  Now newNow(Category category) {
    final machineId = 0;
    final microsecondsSinceEpoch = DateTime.now().microsecondsSinceEpoch;

    final bytes = Uint8List(12);
    final data = bytes.buffer.asByteData();
    data.setUint32(0, microsecondsSinceEpoch ~/ 1000000); // seconds
    data.setUint32(4, machineId);
    data.setUint32(8, microsecondsSinceEpoch % 1000000);
    data.setUint16(7, pid); // overwrite last byte of machineId, and first byte of microseconds.

    final now = Now(
      ObjectId.fromBytes(bytes),
      microsecondsSinceEpoch,
      category: category,
    );
    return add(now);
  }

  T findOrAdd<T extends RealmObject>(Object? key, T Function() create) {
    return find<T>(key) ?? add(create(), update: true);
  }
}

extension on String {
  Digest hash(Uint8List salt) {
    return sha1.convert((BytesBuilder()
          ..add(salt)
          ..add(utf8.encoder.convert(this)))
        .toBytes());
  }
}

extension on Digest {
  ObjectId get asObjectId => ObjectId.fromBytes(bytes.sublist(0, 12));
}

extension IterableEx<T> on Iterable<T> {
  T? get firstOrNull => cast<T?>().firstWhere((_) => true, orElse: () => null);
  Iterable<T> takeLast(int n) => skip(max(0, length - n)); // only efficient on EfficientLengthIterable
}

final schemaObjects = [Category.schema, Styling.schema, Now.schema];

extension RealmObjectEx<T extends RealmObject> on T {
  T? resolveIn(Realm realm) {
    // while we wait for the real thing..
    final self = this;
    if (self is Now) {
      return realm.find(self.id);
    }
    if (self is Category) {
      return realm.find(self.id);
    }
    throw StateError('Cannot resolve $self');
  }

  void delete() => realm.write(() => realm.delete(this));
  T update(T Function(T) update) => realm.write(() => update(this));
}

extension RealmEntityEx on RealmEntity {
  bool get isLive => !isFrozen;
}
