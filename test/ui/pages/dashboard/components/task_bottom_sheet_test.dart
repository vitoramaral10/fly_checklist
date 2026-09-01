import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/l10n/generated/app_localizations.dart';
import 'package:fly_checklist/ui/helpers/helpers.dart';
import 'package:fly_checklist/ui/pages/dashboard/components/components.dart';
import 'package:fly_checklist/ui/pages/task_form_presenter.dart';
import 'package:get/get.dart';

/// Fake do contrato consumido pelo [TaskBottomSheet]. É um dublê escrito à
/// mão (e não um `Mock` do mocktail) porque o widget lê e escreve
/// `taskPriority`/`taskGroupId` interativamente durante o teste — precisa de
/// estado de verdade, e os `Rxn` replicam o que [TaskManager] faz em produção
/// para que os `Obx` do widget tenham uma variável observável para rastrear.
class _TaskFormPresenterFake implements TaskFormPresenter {
  @override
  final formNewTaskKey = GlobalKey<FormState>();

  @override
  final taskTitleController = TextEditingController();

  @override
  final taskDescriptionController = TextEditingController();

  @override
  final taskDueDateController = TextEditingController();

  final _priority = Rxn<int>(2);
  final _groupId = Rxn<String>();

  @override
  int? get taskPriority => _priority.value;

  @override
  set taskPriority(int? value) => _priority.value = value;

  @override
  String? get taskGroupId => _groupId.value;

  @override
  set taskGroupId(String? value) => _groupId.value = value;

  @override
  List<GroupEntity> groups = [];

  int onCreateTaskCallCount = 0;

  @override
  void clearFields() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    taskDueDateController.clear();
    taskPriority = 2;
    taskGroupId = null;
  }

  @override
  Future<void> onCreateTask() async {
    onCreateTaskCallCount++;
  }

  @override
  Future<void> onUpdateTask(TaskEntity task) async {}

  @override
  Future<void> onDeleteTask(TaskEntity task) async {}

  @override
  Future<void> toggleTaskCompletion(TaskEntity task) async {}
}

void main() {
  late _TaskFormPresenterFake presenter;

  /// O teste fixa o português: o formulário é verificado pelos textos que o
  /// usuário lê, e eles mudam com o idioma.
  const testLocale = Locale('pt');
  final l10n = lookupAppLocalizations(testLocale);

  Future<void> pumpSut(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: testLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: TaskBottomSheet(presenter: presenter)),
      ),
    );
  }

  setUpAll(() async {
    await initializeAppDateFormatting();
  });

  setUp(() {
    // O formato da data escrita no campo precisa ser o mesmo que o validador
    // vai ler — e ambos vêm do locale ativo.
    setAppDateLocale(testLocale);
    presenter = _TaskFormPresenterFake();
  });

  testWidgets(
    'Should show a validation error and not create the task if title is empty',
    (tester) async {
      await pumpSut(tester);

      await tester.tap(find.widgetWithText(FilledButton, l10n.commonCreate));
      await tester.pump();

      expect(find.text(l10n.validatorTaskTitleRequired), findsOneWidget);
      expect(presenter.onCreateTaskCallCount, 0);
    },
  );

  testWidgets(
    'Should show a validation error and not create the task if due date is in the past',
    (tester) async {
      presenter.taskTitleController.text = 'Estudar Flutter';
      presenter.taskDueDateController.text = appDateFormat.format(
        DateTime.now().subtract(const Duration(days: 1)),
      );

      await pumpSut(tester);

      await tester.tap(find.widgetWithText(FilledButton, l10n.commonCreate));
      await tester.pump();

      expect(find.text(l10n.validatorDueDateInPast), findsOneWidget);
      expect(presenter.onCreateTaskCallCount, 0);
    },
  );
}
