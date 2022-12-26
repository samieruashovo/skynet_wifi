// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skynet_wifi/methods/firestore_methods.dart';
import 'package:skynet_wifi/pages/home_page.dart';
import 'package:skynet_wifi/providers/message_provider.dart';

class AdminPage extends StatefulWidget {
  var bill;
  AdminPage({super.key, required this.bill});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController tkSpendController = TextEditingController();
  TextEditingController tkAmountController = TextEditingController();
  TextEditingController messageCOntroller = TextEditingController();

  @override
  void initState() {
    print("tb" + widget.bill.toString());
    super.initState();
  }

  @override
  void dispose() {
    tkSpendController.dispose();
    tkAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November ',
      'December'
    ];
    var now = DateTime.now();
    var current_mon = now.month;
    var prevMonth;
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
        backgroundColor: const Color.fromARGB(255, 122, 129, 221),
        title: const Text("Admin"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => SizedBox(
                    height: 300,
                    child: AlertDialog(
                      title: const Text("Spending details"),
                      content: SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            TextField(
                                controller: messageCOntroller,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    hintText: "type message",
                                    border: OutlineInputBorder())),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
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
                              FireStoreMethods()
                                  .uploadMessage(messageCOntroller.text);
                              Navigator.of(ctx).pop();
                            },
                            child: const Icon(
                              Icons.check,
                              color: Colors.green,
                            )),
                      ],
                    ),
                  ),
                );
                // Provider.of<Message>(context, listen: false).message = messageCOntroller.text;
              },
              icon: const Icon(Icons.message_outlined))
        ],
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('tkspending').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var total = 0;
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              // print(snapshot.data!.docs[i]["amount"]);
              total += int.parse(snapshot.data!.docs[i]["amount"]);
            }
            var profit = totalBill - total;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (contx, index) {
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data!.docs[index]["reason"]),
                            subtitle:
                                Text(snapshot.data!.docs[index]["amount"]),
                            trailing: IconButton(
                                onPressed: () {
                                  print(snapshot.data!.docs[index]["id"]);
                                  var res = FireStoreMethods()
                                      .deleteTkSepending(
                                          snapshot.data!.docs[index]["id"]);
                                  print(res.toString());
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Total cost:         ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              total.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${months[prevMonth]} bill: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.bill.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Total Profit:       ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              profit.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => SizedBox(
                  height: 300,
                  child: AlertDialog(
                    title: const Text("Spending details"),
                    content: SizedBox(
                      height: 300,
                      child: Column(
                        children: [
                          TextField(
                              controller: tkSpendController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                  hintText: "Reasons behind your spending",
                                  border: OutlineInputBorder())),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                              controller: tkAmountController,
                              decoration: const InputDecoration(
                                  hintText: "Amount",
                                  border: OutlineInputBorder())),
                        ],
                      ),
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
                            var res = await FireStoreMethods().uploadTkSpending(
                                tkSpendController.text,
                                tkAmountController.text);
                            Navigator.of(ctx).pop();
                          },
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                          )),
                    ],
                  ),
                ),
              );
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
