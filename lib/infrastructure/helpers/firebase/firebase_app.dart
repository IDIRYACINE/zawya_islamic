import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:zawya_islamic/firebase_options.dart';

class MyFirebaseApp {
  static final MyFirebaseApp _instance = MyFirebaseApp._internal();
  factory MyFirebaseApp() => _instance;
  MyFirebaseApp._internal();

  late FirebaseApp firebaseApp;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;
  late FirebaseDatabase firebaseDatabase;

  Future<void> init([bool isTestMode = false]) async {
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );

    firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
    firestore = FirebaseFirestore.instanceFor(app: firebaseApp);
    firebaseDatabase = FirebaseDatabase.instanceFor(app: firebaseApp);

    if (isTestMode) {
      const emulatorHost = '192.168.1.9';
      firebaseAuth.useAuthEmulator(emulatorHost,9099);
      firestore.useFirestoreEmulator(emulatorHost, 8080);
      firebaseDatabase.useDatabaseEmulator(emulatorHost, 9000);
    }
    
  }
}
