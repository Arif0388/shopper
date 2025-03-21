import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class GetUserDataController extends GetxController
{
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String uid)async{
    QuerySnapshot userData = await db.collection('Users').where('Uid',isEqualTo:uid).get();
    return userData.docs;
  }

}