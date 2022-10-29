import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FindYourPassionFirebaseUser {
  FindYourPassionFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FindYourPassionFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FindYourPassionFirebaseUser> findYourPassionFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FindYourPassionFirebaseUser>(
      (user) {
        currentUser = FindYourPassionFirebaseUser(user);
        return currentUser!;
      },
    );
