import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/firestore/firestore.dart';
import '../../../infra/infra.dart';

FirestoreClient makeFirestoreAdapter() {
  final instance = FirebaseFirestore.instance;
  // Persistência offline já vem ligada por padrão no Android; deixamos explícito
  // e sem limite de cache para o checklist continuar usável sem conexão.
  instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  return FirestoreAdapter(instance: instance);
}
