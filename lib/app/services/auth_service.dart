import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter/app/models/user.dart';

abstract class AuthService {
  Future<MyUser?> signInAnonymously();
  Future<void> signOut();
  MyUser? getCurrentUser();
}

class AuthServiceImpl extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<MyUser?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return MyUser(uid: userCredential.user!.uid);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  MyUser? getCurrentUser() {
    final uid = _auth.currentUser;
    return _userFromFirebase(uid);
  }

  MyUser? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return MyUser(uid: user.uid);
  }
}
