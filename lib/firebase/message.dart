import 'package:firebase_database/firebase_database.dart';
import 'message.dart';
 
class MessageDao {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child('messages');
}