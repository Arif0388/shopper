import 'dart:math';

String generateOrderId(){
  DateTime now  = DateTime.now();
  int randomNumbers = Random().nextInt(99999);
  String id = '${now.millisecondsSinceEpoch}_$randomNumbers';
  return id;
}