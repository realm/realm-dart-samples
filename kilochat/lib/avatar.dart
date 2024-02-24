import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import 'model.dart';

class MyAvatar extends StatelessWidget {
  const MyAvatar({
    super.key,
    this.user,
  });

  final UserProfile? user;

  String get _userId => user?.id ?? 'N/A';
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(_userId.hashCode | 0x22000000),
      child: RandomAvatar(_userId, width: 40, trBackground: true),
    );
  }
}
