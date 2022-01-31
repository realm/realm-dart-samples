////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2022 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
///
import 'package:realm_dart/realm.dart';

part 'time_track.g.dart';

@RealmModel()
class _Category {
  @PrimaryKey()
  late final String name;
}

@RealmModel()
class _Now {
  late int time; // no DateTime yet (stay tuned)
  _Category? category;
}

void main(List<String> arguments) {
  final config = Configuration([Category.schema, Now.schema]);
  final realm = Realm(config);

  try {
    if (arguments.isNotEmpty) {
      // Find exisiting category or create a new
      final name = arguments.join(' ');
      final category = realm.find<Category>(name) ?? Category(name);

      // Find latest time track entry
      final latest = realm.query<Now>('TRUEPREDICATE SORT(time DESCENDING)').firstOrNull;

      // If category changed, then create a new entry
      if (latest?.category != category) {
        final now = Now(
          DateTime.now().millisecondsSinceEpoch,
          category: category,
        );
        // Add new entry
        realm.write(() => realm.add(now));
      }
    }

    // Find all todays entries
    final today = realm.query<Now>(r'time >= $0 SORT(time ASCENDING)', [DateTime.now().midnight.millisecondsSinceEpoch]);
    for (final tt in today) {
      print('${DateTime.fromMillisecondsSinceEpoch(tt.time)}: ${tt.category!.name}');
    }
  } finally {
    // Always remember to close!
    realm.close();
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => cast<T?>().firstWhere((_) => true, orElse: () => null);
}

extension on DateTime {
  DateTime get midnight => DateTime(year, month, day);
}
