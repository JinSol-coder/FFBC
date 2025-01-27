import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  final Rx<User?> user = Rx<User?>(null);
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
    ever(user, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) {
    if (user != null) {
      // 로그인 성공 시 홈 화면으로 이동하고 이전 스택 모두 제거
      Get.offAllNamed('/home');
    } else {
      // 로그아웃 시 로그인 화면으로 이동하고 이전 스택 모두 제거
      Get.offAllNamed('/login');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      
      // Google 로그인 프로세스
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase 인증
      await _auth.signInWithCredential(credential);
      
    } catch (e) {
      print('Google sign in error: $e');
      Get.snackbar('오류', '로그인에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      print('Sign out error: $e');
      Get.snackbar('오류', '로그아웃에 실패했습니다.');
    }
  }
} 