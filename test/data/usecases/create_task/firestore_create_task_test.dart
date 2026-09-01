import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/data/firestore/firestore.dart';
import 'package:fly_checklist/data/models/models.dart';
import 'package:fly_checklist/data/usecases/usecases.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';

class _FirestoreClientSpy extends Mock implements FirestoreClient {}

void main() {
  late _FirestoreClientSpy firestoreClient;
  late FirestoreCreateTask sut;
  late String userId;
  late TaskEntity task;

  setUp(() {
    firestoreClient = _FirestoreClientSpy();
    sut = FirestoreCreateTask(firestoreClient: firestoreClient);
    userId = 'any_user_id';
    task = TaskEntity(
      id: '',
      title: 'Comprar leite',
      description: 'Ir ao mercado antes das 18h',
      dueDate: DateTime(2026, 5, 10),
      priority: 3,
      isDone: false,
      createdAt: DateTime(2026, 1, 1),
    );

    when(
      () => firestoreClient.createTask(
        userId: any(named: 'userId'),
        data: any(named: 'data'),
      ),
    ).thenAnswer((_) async {});
  });

  test('Should call FirestoreClient.createTask with correct values', () async {
    await sut.call(userId: userId, task: task);

    verify(
      () => firestoreClient.createTask(
        userId: userId,
        data: TaskModel.fromEntity(task).toJson(),
      ),
    ).called(1);
  });

  test('Should complete normally on success', () async {
    final future = sut.call(userId: userId, task: task);

    await expectLater(future, completes);
  });

  test(
    'Should throw DomainError.unexpected if FirestoreClient throws FirestoreError.unexpected',
    () async {
      when(
        () => firestoreClient.createTask(
          userId: any(named: 'userId'),
          data: any(named: 'data'),
        ),
      ).thenThrow(FirestoreError.unexpected);

      final future = sut.call(userId: userId, task: task);

      expect(future, throwsA(DomainError.unexpected));
    },
  );

  test(
    'Should throw DomainError.unexpected if FirestoreClient throws FirestoreError.notFound',
    () async {
      when(
        () => firestoreClient.createTask(
          userId: any(named: 'userId'),
          data: any(named: 'data'),
        ),
      ).thenThrow(FirestoreError.notFound);

      final future = sut.call(userId: userId, task: task);

      expect(future, throwsA(DomainError.unexpected));
    },
  );
}
