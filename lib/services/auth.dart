import 'package:expenses_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

@immutable
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //create user obj based on Firebase
  User _userFromFireBase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFireBase(user));
        .map(_userFromFireBase); //same as above
  }

  //sign in anony
  Future<User> signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///sign in with email & pass
  Future<User> signInWithEmailAndPass(
      {@required String email, @required String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFireBase(result.user);
    } catch (e) {
      print('Error in firebase signIn');
      print(e.toString());
      return null;
    }
  }

  ///register with **email** & *pass*
  Future<User> registerWithEmailAndPass(
      {@required String email, @required String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFireBase(result.user);
    } catch (e) {
      print('firebase register error');
      print(e.toString());
      return null;
    }
  }

  ///sign in with google account
  Future<User> signInWithGoogleAccount() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      return _userFromFireBase(result.user);
    } catch (e) {
      print('error on sign in with google');
      print(e.toString());
      return null;
    }
  }

  ///sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print('error on sign out');
      print(e.toString());
    }
  }
}
