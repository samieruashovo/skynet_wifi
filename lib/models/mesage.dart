import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  String? id;

  Message({required this.message, this.id});
  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Message(
      message: snapshot['message'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJosn() => {'message': message, 'id': id};
}
