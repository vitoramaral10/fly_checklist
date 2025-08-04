import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

SendVerificationEmail makeFireauthSendVerificationEmail() =>
    FireauthSendVerificationEmail(firebaseAuthClient: makeFireAuthAdapter());
