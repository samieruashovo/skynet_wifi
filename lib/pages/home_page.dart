import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:skynet_wifi/admin_page.dart';
import 'package:skynet_wifi/pages/create_customer_page.dart';
import 'package:skynet_wifi/pages/customer/customer_profile.dart';

var totalBill = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var prevMonth = 0;
  List months = [
    "januaryPay",
    "febuaryPay",
    "marchPay",
    "aprilPay",
    "mayPay",
    "junePay",
    "julyPay",
    "augustPay",
    "septeberPay",
    "octoberPay",
    "novemberPay",
    "decemberPay"
  ];
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var current_mon = now.month;
    print(current_mon);
    if (current_mon == 1) {
      prevMonth = 11;
    } else {
      prevMonth = current_mon - 2;
    }
    print(prevMonth);
    print(months[prevMonth]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dhonirampur Wifi"),
        backgroundColor: const Color.fromARGB(255, 122, 129, 221),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AdminPage(
                          bill: totalBill,
                        )));
              },
              icon: const Icon(Icons.person))
        ],
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('customer').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          var tempTotalBill = 0;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            tempTotalBill +=
                int.parse(snapshot.data!.docs[i][months[prevMonth]]);

            totalBill = tempTotalBill;
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (contx, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      print(snapshot.data!.docs[index]["customerName"]);
                      print(snapshot.data!.docs[index]["ipAddress"]);
                      print(snapshot.data!.docs[index]["contact"]);
                      print("a" + snapshot.data!.docs[index]["id"]);
                      print("b" + snapshot.data!.docs[index]["januaryPay"]);
                      print("c" + snapshot.data!.docs[index]["febuaryPay"]);
                      print("d" + snapshot.data!.docs[index]["marchPay"]);
                      print("e" + snapshot.data!.docs[index]["aprilPay"]);
                      print("f" + snapshot.data!.docs[index]["mayPay"]);

                      print("g" + snapshot.data!.docs[index]["junePay"]);
                      print("gjh" + snapshot.data!.docs[index]["julyPay"]);
                      print("gi" + snapshot.data!.docs[index]["augustPay"]);
                      print("j" + snapshot.data!.docs[index]["septeberPay"]);
                      print("k" + snapshot.data!.docs[index]["octoberPay"]);
                      print("l" + snapshot.data!.docs[index]["novemberPay"]);
                      print("m" + snapshot.data!.docs[index]["decemberPay"]);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomerProfile(
                              name: snapshot.data!.docs[index]["customerName"],
                              ipAddress:
                                  snapshot.data!.docs[index]["ipAddress"] ?? "",
                              number:
                                  snapshot.data!.docs[index]["contact"] ?? "",
                              id: snapshot.data!.docs[index]["id"],
                              januaryPay: snapshot.data!.docs[index]
                                      ["januaryPay"] ??
                                  "",
                              febuaryPay: snapshot.data!.docs[index]
                                      ["febuaryPay"] ??
                                  "",
                              marchPay:
                                  snapshot.data!.docs[index]["marchPay"] ?? "",
                              aprilPay:
                                  snapshot.data!.docs[index]["aprilPay"] ?? "",
                              mayPay:
                                  snapshot.data!.docs[index]["mayPay"] ?? "",
                              junePay:
                                  snapshot.data!.docs[index]["junePay"] ?? "",
                              julyPay: snapshot.data!.docs[index]["julyPay"] ?? "",
                              augustPay: snapshot.data!.docs[index]["augustPay"] ?? "",
                              septeberPay: snapshot.data!.docs[index]["septeberPay"] ?? "",
                              octoberPay: snapshot.data!.docs[index]["octoberPay"] ?? "",
                              novemberPay: snapshot.data!.docs[index]["novemberPay"] ?? "",
                              decemberPay: snapshot.data!.docs[index]["decemberPay"] ?? "")));
                    },
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]["customerName"]),
                      subtitle: Text(snapshot.data!.docs[index]["contact"]),
                      leading: const Icon(
                        Icons.person_outline,
                        color: Color.fromARGB(255, 122, 129, 221),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 122, 129, 221),
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateCustomer()));
          }),
    );
  }
}
