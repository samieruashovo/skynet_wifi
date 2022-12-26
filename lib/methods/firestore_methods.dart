import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skynet_wifi/models/customer_model.dart';
import 'package:skynet_wifi/models/mesage.dart';
import 'package:skynet_wifi/models/tk_spending.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createCustomer(
      String customerName,
      String contact,
      String ipAddress,
      String id,
      String januaryPay,
      String febuaryPay,
      String marchPay,
      String aprilPay,
      String mayPay,
      String junePay,
      String julyPay,
      String augustPay,
      String septeberPay,
      String octoberPay,
      String novemberPay,
      String decemberPay) async {
    String res = "error";
    try {
      Customer customer = Customer(
          customerName: customerName,
          ipAddress: ipAddress,
          contact: contact,
          id: id,
          januaryPay: januaryPay,
          febuaryPay: febuaryPay,
          marchPay: marchPay,
          aprilPay: aprilPay,
          mayPay: mayPay,
          junePay: junePay,
          julyPay: julyPay,
          augustPay: augustPay,
          septeberPay: septeberPay,
          octoberPay: octoberPay,
          novemberPay: novemberPay,
          decemberPay: decemberPay);
      _firestore.collection("customer").doc(id).set(customer.toJosn());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> updateBill(String id, String monthName, String amount) async {
    try {
      _firestore.collection("customer").doc(id).update({monthName: amount});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteCustomer(String id) async {
    try {
      _firestore.collection("customer").doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> uploadTkSpending(String reason, String amount) async {
    String res = "error";
    try {
      String reasonId = const Uuid().v1();
      TkSpending tkS = TkSpending(reason: reason, amount: amount, id: reasonId);
      _firestore.collection("tkspending").doc(reasonId).set(tkS.toJosn());
      res = "success";
    } catch (e) {
      res = e.toString();
      print(e.toString());
    }
    return res;
  }

  Future<String> uploadMessage(String message) async {
    String res = "error";
    try {
      // String reasonId = const Uuid().v1();
      Message msg = Message(message: message, id: 'DdgK3lJ2BZAIbxFBaIEX');
      _firestore.collection("message").doc('DdgK3lJ2BZAIbxFBaIEX').set(msg.toJosn());
      res = "success";
    } catch (e) {
      res = e.toString();
      print(e.toString());
    }
    return res;
  }

  Future<String> deleteTkSepending(String id) async {
    String res = "error";
    try {
      await _firestore.collection("tkspending").doc(id).delete();
      res = "success";
    } catch (e) {
      res = e.toString();
      print(e.toString());
    }
    return res;
  }
}
