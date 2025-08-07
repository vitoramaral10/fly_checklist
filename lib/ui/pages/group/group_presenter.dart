import 'package:fly_checklist/domain/entities/group_entity.dart';

abstract class GroupPresenter {
  GroupEntity? get group;
  bool get isLoading;
  String? get hasError;
}
