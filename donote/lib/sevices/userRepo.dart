import 'package:donote/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseauth.signInWithCredential(credential);
    return _firebaseauth.currentUser;
  }

  Stream<User> get authState => _firebaseauth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    try {
      return await _firebaseauth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      return await _firebaseauth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      e.toString();
    }
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseauth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseauth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseauth.currentUser).uid;
    //write logic here
  }
}
