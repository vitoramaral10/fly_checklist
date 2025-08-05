import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadTasks makeFirestoreLoadTasks() =>
    FirestoreLoadTasks(firestoreClient: makeFirestoreAdapter());
