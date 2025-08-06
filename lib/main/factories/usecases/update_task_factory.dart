import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

UpdateTask makeFirestoreUpdateTask() =>
    FirestoreUpdateTask(firestoreClient: makeFirestoreAdapter());
