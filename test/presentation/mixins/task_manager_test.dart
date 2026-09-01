import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/usecases/usecases.dart';
import 'package:fly_checklist/presentation/mixins/mixins.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class _CreateTaskSpy extends Mock implements CreateTask {}

class _UpdateTaskSpy extends Mock implements UpdateTask {}

class _DeleteTaskSpy extends Mock implements DeleteTask {}

class _GetUserSpy extends Mock implements GetUser {}

/// Controller mínimo só para expor [TaskManager.sortTasks], que não depende
/// de nenhum dos usecases injetados nem do usuário logado.
class _TaskManagerController extends GetxController
    with UserManager, TaskManager {
  _TaskManagerController({
    required this.getUser,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  });

  @override
  final GetUser getUser;
  @override
  final CreateTask createTask;
  @override
  final UpdateTask updateTask;
  @override
  final DeleteTask deleteTask;

  @override
  List<TaskEntity> tasks = [];

  @override
  Future<void> refreshTasks() async {}
}

TaskEntity _makeTask({
  required String id,
  bool isDone = false,
  DateTime? dueDate,
  required DateTime createdAt,
}) {
  return TaskEntity(
    id: id,
    title: 'Tarefa $id',
    description: '',
    dueDate: dueDate,
    priority: 2,
    isDone: isDone,
    createdAt: createdAt,
  );
}

void main() {
  late _TaskManagerController sut;

  setUp(() {
    sut = _TaskManagerController(
      getUser: _GetUserSpy(),
      createTask: _CreateTaskSpy(),
      updateTask: _UpdateTaskSpy(),
      deleteTask: _DeleteTaskSpy(),
    );
  });

  test('Should put done tasks after pending tasks', () {
    final pending = _makeTask(
      id: 'pending',
      createdAt: DateTime(2026, 1, 1),
    );
    final done = _makeTask(
      id: 'done',
      isDone: true,
      createdAt: DateTime(2026, 1, 1),
    );
    final list = [done, pending];

    sut.sortTasks(list);

    expect(list, [pending, done]);
  });

  test('Should order pending tasks by dueDate when both have one', () {
    final later = _makeTask(
      id: 'later',
      dueDate: DateTime(2026, 2, 10),
      createdAt: DateTime(2026, 1, 1),
    );
    final earlier = _makeTask(
      id: 'earlier',
      dueDate: DateTime(2026, 2, 1),
      createdAt: DateTime(2026, 1, 1),
    );
    final list = [later, earlier];

    sut.sortTasks(list);

    expect(list, [earlier, later]);
  });

  test('Should use createdAt as a tiebreaker when dueDate is the same', () {
    final sameDueDate = DateTime(2026, 2, 10);
    final createdFirst = _makeTask(
      id: 'first',
      dueDate: sameDueDate,
      createdAt: DateTime(2026, 1, 1),
    );
    final createdLater = _makeTask(
      id: 'second',
      dueDate: sameDueDate,
      createdAt: DateTime(2026, 1, 5),
    );
    final list = [createdLater, createdFirst];

    sut.sortTasks(list);

    expect(list, [createdFirst, createdLater]);
  });

  test('Should put tasks without dueDate after tasks with dueDate', () {
    final withDueDate = _makeTask(
      id: 'with_date',
      dueDate: DateTime(2026, 3, 1),
      createdAt: DateTime(2026, 1, 1),
    );
    final withoutDueDate = _makeTask(
      id: 'without_date',
      createdAt: DateTime(2026, 1, 1),
    );
    final list = [withoutDueDate, withDueDate];

    sut.sortTasks(list);

    expect(list, [withDueDate, withoutDueDate]);
  });

  test('Should order tasks without dueDate by createdAt', () {
    final createdFirst = _makeTask(id: 'first', createdAt: DateTime(2026, 1, 1));
    final createdLater = _makeTask(
      id: 'second',
      createdAt: DateTime(2026, 1, 10),
    );
    final list = [createdLater, createdFirst];

    sut.sortTasks(list);

    expect(list, [createdFirst, createdLater]);
  });
}
