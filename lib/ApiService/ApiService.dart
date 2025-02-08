import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ApiService
{
   static final FirebaseAuth auth = FirebaseAuth.instance;


// ........SignUp..........
  static Future<void> signUp(String email,String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e);
    }
}

  // logOut
  static Future<void> logOut()async{
     await auth.signOut();
  }


//   signIn
static Future<void> signIn(String email,String password)async{
    await auth.signInWithEmailAndPassword(email: email, password: password);
}


}