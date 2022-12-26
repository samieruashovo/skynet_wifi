import 'package:flutter/material.dart';
import 'package:skynet_wifi/methods/firestore_methods.dart';
import 'package:uuid/uuid.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({super.key});

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController ipController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  @override
  void dispose() {
    customerNameController.dispose();
    ipController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 122, 129, 221),
        elevation: 0,
        title: const Text("Create new Cutomer"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: customerNameController,
                    decoration: const InputDecoration(
                        hintText: "Customer Name",
                        border: OutlineInputBorder())),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: ipController,
                    decoration: const InputDecoration(
                        hintText: "Ip", border: OutlineInputBorder())),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: contactController,
                    decoration: const InputDecoration(
                        hintText: "Contact", border: OutlineInputBorder())),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 122, 129, 221),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      var customerId = Uuid().v1();
                      String res = await FireStoreMethods().createCustomer(
                        customerNameController.text,
                        contactController.text,
                        ipController.text,
                        customerId,
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                        "0",
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text("Done"))
            ],
          ),
        ),
      ),
    );
  }
}
