import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

RecoveryPassword makeFireauthRecoveryPassword() =>
    FireauthRecoveryPassword(firebaseAuthClient: makeFireAuthAdapter());
