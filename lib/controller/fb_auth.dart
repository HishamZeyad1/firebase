import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FbAuth{
  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  UserCredential? userCredential;





  Future<bool> signEmailAndPassword({required String emailAddress,required String password}) async {
    try {
      print("enter here");
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      if (userCredential!=null && userCredential!.user != null){
        return true;
      }
      // print("is Logged:${FirebaseAuth.instance.currentUser!=null}");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }
  Future<String?> createAccount({required String emailAddress,required String password}) async {
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if(userCredential!=null && userCredential!.user !=null){
        print(userCredential!.user);
        print(userCredential!.user!.email);
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return "The account already exists for that email.";
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return "Some error has occured";
  }

  Future<bool> loginAnyomous() async {
    try {
      userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      print(FirebaseAuth.instance.currentUser);/*print(userCredential.user==null);*/

      if (userCredential!=null&& userCredential!.user != null)
          return true;
      return false;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
      return false;
    }
  }
  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    OAuthCredential userCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential1=await FirebaseAuth.instance.signInWithCredential(userCredential);

    if (userCredential1.user != null){
      print("is Logged:${FirebaseAuth.instance.currentUser!=null}");
      return true;
    }
    return false;

    // Once signed in, return the UserCredential
  }
  Future<bool> islogged()async{
    print(FirebaseAuth.instance.currentUser);
    print("is Logged:${FirebaseAuth.instance.currentUser!=null}");

    return FirebaseAuth.instance.currentUser!=null;
  }

  Future<bool> logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
      return true;
    }
    return false;
  }
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  //
  // Future<UserCredential> signInWithTwitter() async {
  //   // Create a TwitterLogin instance
  //   final twitterLogin = new TwitterLogin(
  //       apiKey: '<your consumer key>',
  //       apiSecretKey:' <your consumer secret>',
  //       redirectURI: '<your_scheme>://'
  //   );
  //
  //   // Trigger the sign-in flow
  //   final authResult = await twitterLogin.login();
  //
  //   // Create a credential from the access token
  //   final twitterAuthCredential = TwitterAuthProvider.credential(
  //     accessToken: authResult.authToken!,
  //     secret: authResult.authTokenSecret!,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  // }

}