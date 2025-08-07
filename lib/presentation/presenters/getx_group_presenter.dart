import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../ui/pages/pages.dart';

class GetxGroupPresenter extends GetxController implements GroupPresenter {
  final _isLoading = true.obs;
  final _hasError = Rxn<String>();
  final _group = Rxn<GroupEntity>();

  @override
  GroupEntity? get group => _group.value;

  @override
  bool get isLoading => _isLoading.value;

  @override
  String? get hasError => _hasError.value;

  @override
  void onInit() {
    super.onInit();

    _group.value = Get.arguments;
    _isLoading.value = false;
    _hasError.value = null;
  }
}
