import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

DeleteTask makeFirestoreDeleteTask() =>
    FirestoreDeleteTask(firestoreClient: makeFirestoreAdapter());
