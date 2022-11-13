import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RobinFirebaseUser {
  RobinFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

RobinFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<RobinFirebaseUser> robinFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<RobinFirebaseUser>(
      (user) {
        currentUser = RobinFirebaseUser(user);
        return currentUser!;
      },
    );
