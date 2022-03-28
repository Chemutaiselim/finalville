import 'package:firebase_database/firebase_database.dart';
import 'package:finalville/firebase/post_model.dart';

class DataStream {
  final _database = FirebaseDatabase.instance.ref();

  Stream<List<PostModel>> getPostStream() {
    final orderStream = _database.child('post').onValue;
    final results = orderStream.map((event) {
      final Map<String, dynamic> orderMap = event.snapshot.value as Map<String, dynamic>;
      final orderList = orderMap.entries.map((element) {
        return PostModel.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return orderList;
    });
    return results;
  }
}