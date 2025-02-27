import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController
{
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<String> banners = RxList<String>([]);

  @override
  void onInit()
  {
    super.onInit();
    getBanners();
  }


  Future<void> getBanners()async{
    try{
      QuerySnapshot bannersSnapshot = await db.collection('banners').get();
      if(bannersSnapshot.docs.isNotEmpty){
        banners.value = bannersSnapshot.docs.map((e)=>e['imageUrl']as String).toList();
      }
    }catch(ex){
      print('Error :$ex');
    }
  }

}