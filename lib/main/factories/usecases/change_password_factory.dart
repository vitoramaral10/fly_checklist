import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

ChangePassword makeFireauthChangePassword() =>
    FireauthChangePassword(firebaseAuth: makeFireAuthAdapter());
