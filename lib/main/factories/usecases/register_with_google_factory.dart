import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

RegisterWithGoogle makeFireauthRegisterWithGoogle() =>
    FireauthRegisterWithGoogle(
      firebaseAuthClient: makeFireAuthAdapter(),
      googleSignInClient: makeGoogleSignInAdapter(),
    );
