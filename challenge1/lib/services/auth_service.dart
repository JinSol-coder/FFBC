import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 현재 유저 가져오기
  User? get currentUser => _auth.currentUser;

  // 구글 로그인
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 구글 로그인 진행
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // 구글 인증 정보 가져오기
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Firebase 인증 정보 생성
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase 로그인 및 사용자 정보 업데이트
      final userCredential = await _auth.signInWithCredential(credential);

      // 사용자 프로필 정보 업데이트
      await userCredential.user?.updateDisplayName(googleUser.displayName);
      await userCredential.user?.updatePhotoURL(googleUser.photoUrl);

      return userCredential;
    } catch (e) {
      print('Google Sign In Error: $e');
      return null;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
