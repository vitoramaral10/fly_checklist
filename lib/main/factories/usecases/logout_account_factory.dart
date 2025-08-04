import 'package:fly_checklist/domain/usecases/usecases.dart';

import '../../../data/usecases/usecases.dart';
import '../factories.dart';

LogoutAccount makeFireauthLogoutAccount() =>
    FireauthLogoutAccount(firebaseAuth: makeFireAuthAdapter());
