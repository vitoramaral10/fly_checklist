import 'package:fly_checklist/main/factories/factories.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/presenters.dart';

Bindings makeDashboardBinding() => _DashboardBinding();

class _DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GetxDashboardPresenter(
        getUser: makeFireauthGetUser(),
        loadTasks: makeFirestoreLoadTasks(),
        createTask: makeFirestoreCreateTask(),
        updateTask: makeFirestoreUpdateTask(),
        deleteTask: makeFirestoreDeleteTask(),
      ),
    );
  }
}
