import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirestoreService {
  final String uid;

  FirestoreService({this.uid}) : assert(uid != null);

  static final firestore = Firestore.instance;

  // Collection References
  final CollectionReference userProfilesCollection =
      firestore.collection('user-profiles');


  Future updateUserProfile(String name, String email) async {
    userProfilesCollection.document(uid).get().then((userData) async {
      if (userData.data == null) {
        await userProfilesCollection
            .document(uid)
            .setData({'name': name, 'email': email});
      } else if (userData.data["email"] == null) {
        await userProfilesCollection.document(uid).updateData({"email": email});
      }
      await setFcmToken();
    });
  }
  Future<void> setFcmToken() async {
    await userProfilesCollection
        .document(uid)
        .updateData({'fcm_token': await FirebaseMessaging().getToken()});
  }
}