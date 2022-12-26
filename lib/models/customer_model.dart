// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String customerName;
  final String ipAddress;
  final String contact;
  final String id;
  final String januaryPay;
  final String febuaryPay;
  final String marchPay;
  final String aprilPay;
  final String mayPay;
  final String junePay;
  final String julyPay;
  final String augustPay;
  final String septeberPay;
  final String octoberPay;
  final String novemberPay;
  final String decemberPay;
  Customer({
    required this.customerName,
    required this.ipAddress,
    required this.contact,
    required this.id,
    required this.januaryPay,
    required this.febuaryPay,
    required this.marchPay,
    required this.aprilPay,
    required this.mayPay,
    required this.junePay,
    required this.julyPay,
    required this.augustPay,
    required this.septeberPay,
    required this.octoberPay,
    required this.novemberPay,
    required this.decemberPay,
  });

  static Customer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Customer(
      customerName: snapshot['customerName'],
      ipAddress: snapshot['ipAddress'],
      contact:  snapshot['contact'],
      id: snapshot['id'],
      januaryPay: snapshot['januaryPay'],
      febuaryPay: snapshot['febuaryPay'],
      marchPay: snapshot['marchPay'],
      aprilPay: snapshot['aprilPay'],
      mayPay: snapshot['mayPay'],
      junePay: snapshot['junePay'],
      julyPay: snapshot['julyPay'],
      augustPay: snapshot['augustPay'],
      septeberPay: snapshot['septeberPay'],
      octoberPay: snapshot['octoberPay'],
      novemberPay: snapshot['novemberPay'],
      decemberPay: snapshot['decemberPay'],
    );
  }

  Map<String, dynamic> toJosn() => {
        'customerName': customerName,
        'ipAddress': ipAddress,
        'contact':contact,
        'id':id,
        'januaryPay': januaryPay,
        'febuaryPay': febuaryPay,
        'marchPay': marchPay,
        'aprilPay': aprilPay,
        'mayPay': mayPay,
        'junePay': junePay,
        'julyPay':julyPay,
        'augustPay': augustPay,
        'septeberPay': septeberPay,
        'octoberPay': octoberPay,
        'novemberPay': novemberPay,
        'decemberPay': decemberPay
      };
}
