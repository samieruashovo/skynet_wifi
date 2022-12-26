// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:skynet_wifi/methods/firestore_methods.dart';
import 'package:skynet_wifi/providers/message_provider.dart';

class CustomerProfile extends StatefulWidget {
  final String name;
  final String ipAddress;
  final String number;
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

  const CustomerProfile({
    Key? key,
    required this.name,
    required this.ipAddress,
    required this.number,
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
  }) : super(key: key);

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  uppdateBill(String monthName, String amount) async {
    FireStoreMethods().updateBill(widget.id, monthName, amount);
  }

  _getPermission() async => await [
        Permission.sms,
      ].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;
  getMessage() async {
    var msge = await FirebaseFirestore.instance
        .collection('message')
        .doc('DdgK3lJ2BZAIbxFBaIEX')
        .get();
    String msg = msge['message'];
    return msg;
  }

  sendSMS({int? simSlot}) async {
    String msg1 = await getMessage();
    print(msg1);
    var result = await BackgroundSms.sendMessage(
        phoneNumber: widget.number, message: msg1, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }

  Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;

  @override
  Widget build(BuildContext context) {
    var jan = int.parse(widget.febuaryPay);
    var feb = int.parse(widget.marchPay);
    var mar = int.parse(widget.aprilPay);
    var apr = int.parse(widget.mayPay);
    var may = int.parse(widget.junePay);
    var jun = int.parse(widget.julyPay);
    var jul = int.parse(widget.augustPay);
    var aug = int.parse(widget.septeberPay);
    var sep = int.parse(widget.octoberPay);
    var oct = int.parse(widget.novemberPay);
    var nov = int.parse(widget.decemberPay);
    var dec = int.parse(widget.januaryPay);
    var total =
        jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec;
    TextEditingController amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 122, 129, 221),
        actions: [
          IconButton(
              onPressed: () async {
                // print(widget.id);
                FireStoreMethods().deleteCustomer(widget.id);
              },
              icon: const Icon(Icons.delete))
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.name,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      widget.number,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "IP: ${widget.ipAddress}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "January",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.januaryPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("januaryPay", amountController);

                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }

                          ;
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "February",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.febuaryPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("febuaryPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "March",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.marchPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("marchPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "April",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.aprilPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("aprilPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "May",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.mayPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("mayPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "June",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.junePay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("junePay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "July",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.julyPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("julyPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "August",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.augustPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("augustPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "September",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.septeberPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("septeberPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "October",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.octoberPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("octoberPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "November",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.novemberPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("novemberPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Card(
                  child: ListTile(
                      leading: const Text(
                        "December",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        "Tk: " + widget.decemberPay,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () async {
                          showAlertDialog("decemberPay", amountController);
                          if (await _isPermissionGranted()) {
                            // if ((await _supportCustomSim)!) {
                            sendSMS(simSlot: 2);
                            // }
                          } else {
                            _getPermission();
                          }
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Card(
                    child: ListTile(
                        leading: const Text(
                          "Total: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Row(
                          children: [
                            Text(
                              total.toString(),
                            ),
                            Text(
                              " Tk",
                            ),
                          ],
                        ),
                        // trailing: IconButton(
                        //   icon: const Icon(Icons.check),
                        //   onPressed: () {},
                        // ),
                        
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(
      String monthName, TextEditingController amountController) async {
    showDialog(
        context: context,
        builder: (ctx) => SizedBox(
            height: 300,
            child: AlertDialog(
              title: const Text("Spending details"),
              content: SizedBox(
                height: 300,
                child: TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                        hintText: "Amount", border: OutlineInputBorder())),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                    )),
                TextButton(
                    onPressed: () async {
                      var res =
                          await uppdateBill(monthName, amountController.text);
                      Navigator.of(ctx).pop();
                    },
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                    )),
              ],
            )));
  }
}
