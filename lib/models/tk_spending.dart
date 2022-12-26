import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TkSpending {
  final String reason;
  final String amount;
  String? id;

  TkSpending({required this.reason, required this.amount, this.id});
  static TkSpending fromSnap(DocumentSnapshot snap) {
    
    var snapshot = snap.data() as Map<String, dynamic>;
    return TkSpending(
      reason: snapshot['reason'],
      amount: snapshot['amount'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJosn() =>
      {
       'reason': reason, 'amount': amount, 'id': id};
}
