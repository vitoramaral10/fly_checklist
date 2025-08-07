import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

CreateGroup makeFirestoreCreateGroup() =>
    FirestoreCreateGroup(firestoreClient: makeFirestoreAdapter());
