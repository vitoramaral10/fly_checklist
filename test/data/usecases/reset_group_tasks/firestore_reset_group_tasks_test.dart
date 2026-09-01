import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fly_checklist/data/firestore/firestore.dart';
import 'package:fly_checklist/data/usecases/usecases.dart';
import 'package:fly_checklist/domain/entities/entities.dart';
import 'package:fly_checklist/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';

class _FirestoreClientSpy extends Mock implements FirestoreClient {}

void main() {
  late _FirestoreClientSpy firestoreClient;
  late FirestoreResetGroupTasks sut;
  late String userId;
  late GroupEntity group;

  setUp(() {
    firestoreClient = _FirestoreClientSpy();
    sut = FirestoreResetGroupTasks(firestoreClient: firestoreClient);
    userId = 'any_user_id';
    group = GroupEntity(
      id: 'any_group_id',
      name: 'Mochila',
      description: 'Antes de sair',
      icon: defaultGroupIcon,
      color: Colors.blue,
      saveCheckState: false,
      createdAt: DateTime(2026, 1, 1),
      lastResetAt: DateTime(2026, 5, 10),
    );

    when(
      () => firestoreClient.resetTasksByGroupId(
        userId: any(named: 'userId'),
        groupId: any(named: 'groupId'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => firestoreClient.updateGroup(
        userId: any(named: 'userId'),
        groupId: any(named: 'groupId'),
        data: any(named: 'data'),
      ),
    ).thenAnswer((_) async {});
  });

  test(
    'Should call FirestoreClient.resetTasksByGroupId with correct values',
    () async {
      await sut.call(userId: userId, group: group);

      verify(
        () => firestoreClient.resetTasksByGroupId(
          userId: userId,
          groupId: group.id,
        ),
      ).called(1);
    },
  );

  test('Should uncheck the tasks before stamping the group', () async {
    await sut.call(userId: userId, group: group);

    verifyInOrder([
      () => firestoreClient.resetTasksByGroupId(
        userId: userId,
        groupId: group.id,
      ),
      () => firestoreClient.updateGroup(
        userId: userId,
        groupId: group.id,
        data: any(named: 'data'),
      ),
    ]);
  });

  test('Should persist the new lastResetAt on the group', () async {
    final before = DateTime.now();

    await sut.call(userId: userId, group: group);

    final data =
        verify(
              () => firestoreClient.updateGroup(
                userId: userId,
                groupId: group.id,
                data: captureAny(named: 'data'),
              ),
            ).captured.single
            as Map<String, dynamic>;

    final lastResetAt = (data['lastResetAt'] as Timestamp).toDate();

    expect(lastResetAt.isBefore(before), false);
    expect(data['saveCheckState'], false);
    expect(data['name'], group.name);
  });

  test('Should return the group with lastResetAt updated', () async {
    final before = DateTime.now();

    final result = await sut.call(userId: userId, group: group);

    expect(result.id, group.id);
    expect(result.lastResetAt, isNotNull);
    expect(result.lastResetAt!.isBefore(before), false);
    expect(result.needsDailyReset(), false);
  });

  test(
    'Should not stamp the group if FirestoreClient.resetTasksByGroupId fails',
    () async {
      when(
        () => firestoreClient.resetTasksByGroupId(
          userId: any(named: 'userId'),
          groupId: any(named: 'groupId'),
        ),
      ).thenThrow(FirestoreError.unexpected);

      final future = sut.call(userId: userId, group: group);

      await expectLater(future, throwsA(DomainError.unexpected));
      verifyNever(
        () => firestoreClient.updateGroup(
          userId: any(named: 'userId'),
          groupId: any(named: 'groupId'),
          data: any(named: 'data'),
        ),
      );
    },
  );

  test(
    'Should throw DomainError.unexpected if FirestoreClient.updateGroup throws FirestoreError.unexpected',
    () async {
      when(
        () => firestoreClient.updateGroup(
          userId: any(named: 'userId'),
          groupId: any(named: 'groupId'),
          data: any(named: 'data'),
        ),
      ).thenThrow(FirestoreError.unexpected);

      final future = sut.call(userId: userId, group: group);

      expect(future, throwsA(DomainError.unexpected));
    },
  );

  test('Should complete normally on success', () async {
    final future = sut.call(userId: userId, group: group);

    await expectLater(future, completes);
  });
}
