import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

DeleteGroup makeFirestoreDeleteGroup() =>
    FirestoreDeleteGroup(firestoreClient: makeFirestoreAdapter());
