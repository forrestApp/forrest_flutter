import 'package:firebase_auth/firebase_auth.dart';
import 'package:forrest_flutter/modules/firebaseUser.dart';
import 'package:forrest_flutter/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int currentYear = DateTime.now().year;

  //create user object based on firebaseUser
  FirebaseUser _userFromFirebaseUser(User user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<FirebaseUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(
      String name,
      String email,
      String password,
      String home,
      String profilePicture,
      String car,
      String bike) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create a new document for the user
      await DatabaseService(uid: user.uid)
          .updateUserData(name, email, home, profilePicture, car, bike);

      //create powerfolder and data -> average usage
      await DatabaseService(uid: user.uid, currentYear: currentYear)
          .initializePowerData('Strommix', 1300, 612300);

      //create heatingfolder without any data
      await DatabaseService(uid: user.uid, currentYear: currentYear)
          .initializeHeatingData('-', 0);

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      //exception that occurs if e-mail already exists

      if (e.code == 'Diese Email ist bereits registriert') {
        return e;
      }
    }
  }

  //forgot password
  Future forgotPassword(String email) async {
    try {
      UserCredential userCredential = await _auth
          .sendPasswordResetEmail(email: email)
          .then((value) => null);
      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
