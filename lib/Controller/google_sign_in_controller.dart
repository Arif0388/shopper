import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desi_mart/Models/UserModel.dart';
import 'package:desi_mart/Pages/HomePage/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends GetxController
{
 final FirebaseAuth auth = FirebaseAuth.instance;
 final FirebaseFirestore _db = FirebaseFirestore.instance;

 final GoogleSignIn googleSignIn = GoogleSignIn();

 Future<void> signInWithGoogle()async{
 try{
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if(googleSignInAccount !=null)
   {
    EasyLoading.show(status:'Please Wait....');
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
     final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken:googleSignInAuthentication.accessToken,
      idToken:googleSignInAuthentication.idToken
     );

     final UserCredential userCredential = await auth.signInWithCredential(credential);

     final User? user = userCredential.user;

     if(user !=null)
      {
       UserModel userModel = UserModel(
        uid:user.uid,
        userName:user.displayName.toString(),
        userEmail:user.email,
        userPhone:user.phoneNumber.toString(),
        userImage:user.photoURL.toString(),
        userDeviceToken:'',
        userCountry: '',
        userAddress:'',
        userStreet:'',
        isAdmin:false,
        isActive:true,
        createdOn:DateTime.now(),
       );
      await _db.collection('Users').doc(user.uid).set(userModel.toJson());
      EasyLoading.dismiss();
      Get.offAll(HomePage());
      }
   }
 }catch(ex){
  EasyLoading.dismiss();
  print('Error : $ex');
    }
 }

 Future<void> signOut()async{
 await googleSignIn.signOut();
 }
}