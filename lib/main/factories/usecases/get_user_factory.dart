import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

GetUser makeFireauthGetUser() =>
    FireauthGetUser(fireauthClient: makeFireAuthAdapter());
