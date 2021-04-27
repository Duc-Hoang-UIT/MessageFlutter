import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mymessager/controllers/UserController/UserController.dart';
import 'package:mymessager/models/UserModel.dart';
import 'package:mymessager/services/database.dart';

class Authentication extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _user = Rx<User>(null);
  User get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  Future<bool> createUser(String name, String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel userModel = UserModel(
        id: _authResult.user.uid,
        name: name,
        email: _authResult.user.email,
        ulrImage: _authResult.user.photoURL,
      );
      if (await Database().createNewUser(userModel)) {
        Get.find<UserController>().userModel = userModel;
        //Get.back();
      }
    } catch (e) {
      print(e.toString());

      return false;
    }
    return true;
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().userModel =
          await Database().getUser(_authResult.user.uid);
      Get.toNamed('/home');
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
      Get.toNamed("/");
    } catch (e) {
      print(e.toString());
    }
  }

  final googleSignIn = GoogleSignIn();
  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount userSignInAccount = await googleSignIn.signIn();
      if (userSignInAccount == null) {
        //do nothing
      } else {
        final googleAuth = await userSignInAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential _userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        UserModel userModel = UserModel(
          id: _userCredential.user.uid,
          name: _userCredential.user.displayName,
          email: _userCredential.user.email,
          ulrImage: _userCredential.user.photoURL,
        );
        if (await Database().createNewUser(userModel)) {
          Get.find<UserController>().userModel = userModel;
        }

        Get.find<UserController>().userModel = userModel;
        Get.find<UserController>().isSignInWithGoogle = true;
        Get.toNamed("/home");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> SignOutWithGoolgeAccoutn() async {
    await googleSignIn.disconnect();
    await signOut();
  }
}
