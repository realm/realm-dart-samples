import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_user_provider.g.dart';

@riverpod
Stream<User?> firebaseUser(FirebaseUserRef ref) =>
    FirebaseAuth.instance.authStateChanges();
