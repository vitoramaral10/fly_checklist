import 'dart:developer';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

mixin UserManager on GetxController {
  GetUser get getUser;

  final _user = Rxn<UserEntity>();

  UserEntity? get user => _user.value;

  String get currentUserId => _user.value!.uid;

  Future<void> loadUser() async {
    try {
      _user.value = await getUser.call();
    } on DomainError catch (e) {
      log(e.toString(), name: '$runtimeType.loadUser');
      throw DomainError.unexpected;
    }
  }

  void clearUser() {
    _user.value = null;
  }
}
