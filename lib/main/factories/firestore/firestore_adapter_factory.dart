import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/firestore/firestore.dart';
import '../../../infra/infra.dart';

FirestoreClient makeFirestoreAdapter() =>
    FirestoreAdapter(instance: FirebaseFirestore.instance);
