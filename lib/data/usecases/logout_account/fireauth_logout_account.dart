import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';

class FireauthLogoutAccount implements LogoutAccount {
  final FireauthClient firebaseAuth;

  FireauthLogoutAccount({required this.firebaseAuth});

  @override
  Future<void> call() async {
    await firebaseAuth.logout();
  }
}
