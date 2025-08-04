import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoginWithGoogle makeFireauthLoginWithGoogle() => FireauthLoginWithGoogle(
  firebaseAuthClient: makeFireAuthAdapter(),
  googleSignInClient: makeGoogleSignInAdapter(),
);
