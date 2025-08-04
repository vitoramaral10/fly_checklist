import 'dart:developer';

import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../fireauth/fireauth.dart';
import '../../models/models.dart';

class FireauthGetUser extends GetxController implements GetUser {
  final FireauthClient fireauthClient;

  FireauthGetUser({required this.fireauthClient});

  @override
  Future<UserEntity> call() async {
    try {
      final user = await fireauthClient.getUser();

      return user != null
          ? UserModel.fromJson(user).toEntity()
          : throw DomainError.unexpected;
    } on FireauthError catch (e) {
      log(e.toString(), name: 'FireauthGetUser.call');
      throw DomainError.unexpected;
    } catch (e) {
      log(e.toString(), name: 'FireauthGetUser.call');
      throw DomainError.unexpected;
    }
  }
}
