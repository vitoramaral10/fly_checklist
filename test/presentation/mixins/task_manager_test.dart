import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:fly_checklist/domain/usecases/usecases.dart';
import 'package:fly_checklist/presentation/mixins/mixins.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';

class _CreateTaskSpy extends Mock implements CreateTask {}

class _UpdateTaskSpy extends Mock implements UpdateTask {}

class _DeleteTaskSpy extends Mock implements DeleteTask {}

class _GetUserSpy extends Mock implements GetUser {}

class _ScheduleTaskReminderSpy extends Mock implements ScheduleTaskReminder {}

class _CancelTaskReminderSpy extends Mock implements CancelTaskReminder {}

/// Controller mínimo só para exercitar o [TaskManager] sem o resto de um
/// presenter de verdade.
class _TaskManagerController extends GetxController
    with UserManager, TaskManager {
  _TaskManagerController({
    required this.getUser,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.scheduleTaskReminder,
    required this.cancelTaskReminder,
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
  final ScheduleTaskReminder scheduleTaskReminder;
  @override
  final CancelTaskReminder cancelTaskReminder;

  @override
  List<TaskEntity> tasks = [];

  @override
  List<GroupEntity> groups = [];

  int refreshTasksCalls = 0;

  @override
  Future<void> refreshTasks() async {
    refreshTasksCalls++;
  }
}

TaskEntity _makeTask({
  required String id,
  String title = 'Tarefa',
  String? groupId,
  bool isDone = false,
  DateTime? dueDate,
  required DateTime createdAt,
}) {
  return TaskEntity(
    id: id,
    groupId: groupId,
    title: title,
    description: '',
    dueDate: dueDate,
    priority: 2,
    isDone: isDone,
    createdAt: createdAt,
  );
}

GroupEntity _makeGroup({required String id, required String name}) {
  return GroupEntity(
    id: id,
    name: name,
    icon: Icons.list,
    color: Colors.blue,
    saveCheckState: true,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  // `clearTaskFields` toca em `GlobalKey.currentState`, que precisa do binding
  // do Flutter mesmo fora de um teste de widget.
  TestWidgetsFlutterBinding.ensureInitialized();

  late _TaskManagerController sut;
  late _CreateTaskSpy createTask;
  late _UpdateTaskSpy updateTask;
  late _DeleteTaskSpy deleteTask;
  late _GetUserSpy getUser;
  late _ScheduleTaskReminderSpy scheduleTaskReminder;
  late _CancelTaskReminderSpy cancelTaskReminder;

  /// Data distante o bastante para o lembrete nunca cair no passado enquanto a
  /// suíte roda.
  DateTime futureDueDate() => DateTime.now().add(const Duration(days: 30));

  setUpAll(() async {
    await initializeDateFormatting(appDateLocale);
    registerFallbackValue(
      _makeTask(id: 'fallback', createdAt: DateTime(2026, 1, 1)),
    );
  });

  setUp(() {
    createTask = _CreateTaskSpy();
    updateTask = _UpdateTaskSpy();
    deleteTask = _DeleteTaskSpy();
    getUser = _GetUserSpy();
    scheduleTaskReminder = _ScheduleTaskReminderSpy();
    cancelTaskReminder = _CancelTaskReminderSpy();

    sut = _TaskManagerController(
      getUser: getUser,
      createTask: createTask,
      updateTask: updateTask,
      deleteTask: deleteTask,
      scheduleTaskReminder: scheduleTaskReminder,
      cancelTaskReminder: cancelTaskReminder,
    );

    when(() => getUser.call()).thenAnswer(
      (_) async => UserEntity(
        uid: 'any_user_id',
        name: 'Vitor',
        email: 'vitor@example.com',
        photoUrl: null,
        emailVerified: true,
      ),
    );
    when(
      () => createTask.call(
        userId: any(named: 'userId'),
        task: any(named: 'task'),
      ),
    ).thenAnswer((_) async => 'created_task_id');
    when(
      () => updateTask.call(
        userId: any(named: 'userId'),
        task: any(named: 'task'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => deleteTask.call(
        userId: any(named: 'userId'),
        task: any(named: 'task'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => scheduleTaskReminder.call(
        task: any(named: 'task'),
        groupName: any(named: 'groupName'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => cancelTaskReminder.call(taskId: any(named: 'taskId')),
    ).thenAnswer((_) async {});
  });

  group('sortTasks', () {
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
      final createdFirst = _makeTask(
        id: 'first',
        createdAt: DateTime(2026, 1, 1),
      );
      final createdLater = _makeTask(
        id: 'second',
        createdAt: DateTime(2026, 1, 10),
      );
      final list = [createdLater, createdFirst];

      sut.sortTasks(list);

      expect(list, [createdFirst, createdLater]);
    });
  });

  group('reminders', () {
    setUp(() async {
      await sut.loadUser();
    });

    test('Should schedule the created task with the id it was given', () async {
      sut.taskTitleController.text = 'Comprar leite';
      sut.taskDueDateController.text = appDateFormat.format(futureDueDate());

      await sut.onCreateTask();

      final scheduled =
          verify(
                () => scheduleTaskReminder.call(
                  task: captureAny(named: 'task'),
                  groupName: any(named: 'groupName'),
                ),
              ).captured.single
              as TaskEntity;

      expect(scheduled.id, 'created_task_id');
      expect(scheduled.title, 'Comprar leite');
    });

    test('Should schedule on update passing the group name', () async {
      sut.groups = [_makeGroup(id: 'group_id', name: 'Pré-voo')];
      final task = _makeTask(
        id: 'task_id',
        groupId: 'group_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );

      await sut.onUpdateTask(task);

      verify(
        () => scheduleTaskReminder.call(task: task, groupName: 'Pré-voo'),
      ).called(1);
    });

    test('Should schedule on update without a group name when there is no '
        'group', () async {
      final task = _makeTask(
        id: 'task_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );

      await sut.onUpdateTask(task);

      verify(
        () => scheduleTaskReminder.call(task: task, groupName: null),
      ).called(1);
    });

    test('Should hand the updated task over so removing the due date '
        'cancels', () async {
      final task = _makeTask(id: 'task_id', createdAt: DateTime(2026, 1, 1));

      await sut.onUpdateTask(task);

      final scheduled =
          verify(
                () => scheduleTaskReminder.call(
                  task: captureAny(named: 'task'),
                  groupName: any(named: 'groupName'),
                ),
              ).captured.single
              as TaskEntity;

      expect(scheduled.dueDate, isNull);
    });

    test('Should cancel the reminder when the task is deleted', () async {
      final task = _makeTask(
        id: 'task_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );

      await sut.onDeleteTask(task);

      verify(() => cancelTaskReminder.call(taskId: 'task_id')).called(1);
    });

    test('Should sync a done task when it is completed', () async {
      final task = _makeTask(
        id: 'task_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );
      sut.tasks = [task];

      await sut.toggleTaskCompletion(task);

      final scheduled =
          verify(
                () => scheduleTaskReminder.call(
                  task: captureAny(named: 'task'),
                  groupName: any(named: 'groupName'),
                ),
              ).captured.single
              as TaskEntity;

      expect(scheduled.isDone, isTrue);
      expect(scheduled.id, 'task_id');
    });

    test('Should sync a pending task when it is reopened', () async {
      final dueDate = futureDueDate();
      final task = _makeTask(
        id: 'task_id',
        isDone: true,
        dueDate: dueDate,
        createdAt: DateTime(2026, 1, 1),
      );
      sut.tasks = [task];

      await sut.toggleTaskCompletion(task);

      final scheduled =
          verify(
                () => scheduleTaskReminder.call(
                  task: captureAny(named: 'task'),
                  groupName: any(named: 'groupName'),
                ),
              ).captured.single
              as TaskEntity;

      expect(scheduled.isDone, isFalse);
      expect(scheduled.dueDate, dueDate);
    });

    test('Should not schedule anything when the update itself fails', () async {
      when(
        () => updateTask.call(
          userId: any(named: 'userId'),
          task: any(named: 'task'),
        ),
      ).thenThrow(DomainError.unexpected);
      final task = _makeTask(
        id: 'task_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );

      await expectLater(
        sut.onUpdateTask(task),
        throwsA(UiError.unexpected),
      );

      verifyNever(
        () => scheduleTaskReminder.call(
          task: any(named: 'task'),
          groupName: any(named: 'groupName'),
        ),
      );
    });
  });

  group('reminder failures', () {
    setUp(() async {
      await sut.loadUser();
    });

    test('Should not break the update when scheduling fails', () async {
      when(
        () => scheduleTaskReminder.call(
          task: any(named: 'task'),
          groupName: any(named: 'groupName'),
        ),
      ).thenThrow(DomainError.unexpected);
      final task = _makeTask(
        id: 'task_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );

      await expectLater(sut.onUpdateTask(task), completes);

      verify(
        () => updateTask.call(userId: 'any_user_id', task: task),
      ).called(1);
      expect(sut.refreshTasksCalls, 1);
    });

    test('Should not break the deletion when cancelling fails', () async {
      when(
        () => cancelTaskReminder.call(taskId: any(named: 'taskId')),
      ).thenThrow(DomainError.unexpected);
      final task = _makeTask(
        id: 'task_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );

      await expectLater(sut.onDeleteTask(task), completes);

      verify(
        () => deleteTask.call(userId: 'any_user_id', task: task),
      ).called(1);
      expect(sut.refreshTasksCalls, 1);
    });

    test('Should not break completing a task when scheduling fails', () async {
      when(
        () => scheduleTaskReminder.call(
          task: any(named: 'task'),
          groupName: any(named: 'groupName'),
        ),
      ).thenThrow(DomainError.unexpected);
      final task = _makeTask(
        id: 'task_id',
        dueDate: futureDueDate(),
        createdAt: DateTime(2026, 1, 1),
      );
      sut.tasks = [task];

      await expectLater(sut.toggleTaskCompletion(task), completes);

      expect(sut.tasks.single.isDone, isTrue);
    });
  });
}
