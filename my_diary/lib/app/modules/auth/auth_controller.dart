import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  Rx<User?> user = Rx<User?>(null);
  
  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }
  
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      await _auth.signInWithCredential(credential);
      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      Get.offAllNamed(Routes.auth);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
} 