import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/google_signin/google_signin.dart';
import '../../../firebase_options.dart';
import '../../../infra/infra.dart';

GoogleSignInClient makeGoogleSignInAdapter() {
  final googleSignIn = GoogleSignIn.instance;

  // Inicializa o Google Sign-In com o serverClientId necessário para Android
  googleSignIn.initialize(
    serverClientId: DefaultFirebaseOptions.currentPlatform.androidClientId,
  );

  return GoogleSigninAdapter(instance: googleSignIn);
}
