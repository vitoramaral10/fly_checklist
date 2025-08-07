import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

Bindings makeGroupBinding() => _GroupBinding();

class _GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxGroupPresenter(
        getUser: makeFireauthGetUser(),
        getGroup: makeFirestoreGetGroup(),
        loadTasks: makeFirestoreLoadTasks(),
      ),
    );
  }
}
