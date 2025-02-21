import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();

  static AuthService authServices = AuthService._();

  GoogleSignIn signIn = GoogleSignIn();
  FirebaseAuth auths = FirebaseAuth.instance;

  Future<String> registerUser({
    required String email,
    required String password,
  }) async {
    String msg;
    try {
      auths.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      msg = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          msg = 'try another way to login';
        case 'Week-password':
          msg = "Password is too weak 🔐";
        case 'email-already-in-use':
          msg = "email already exits...";
        default:
          msg = e.code;
      }
    }
    return msg;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String msg;
    try {
      await auths.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      msg = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          msg = "email or password is invalid";
        case 'operation-not-allowed':
          msg = 'try another way to login';
        default:
          msg = e.code;
      }
    }
    return msg;
  }

  Future<String> loginWithGoogle() async {
    String msg;
    try {
      GoogleSignInAccount? googleUser = await signIn.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        var credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await auths.signInWithCredential(credential);
        msg = "Success";
      } else {
        msg = "try another way to login ";
      }
    } on FirebaseAuthException catch (e) {
      msg = e.code;
    }
    return msg;
  }

  Future<User?> anonymousLogin() async {
    UserCredential userCredential = await auths.signInAnonymously();
    return userCredential.user;
  }

  // todo: LogOut Method

  Future<void> logOut() async {
    await auths.signOut();
    await signIn.signOut();
  }

  User? get currentUser => auths.currentUser;
}
