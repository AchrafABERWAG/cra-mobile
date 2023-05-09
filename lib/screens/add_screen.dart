import 'package:flutter/material.dart';
import 'package:committer_cra/api.dart';
import '../model/client.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController siretcontroller = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController tvacontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  Future<Client>? _futureClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Data',
      theme: ThemeData(primaryColor: Colors.red),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child:
              (_futureClient == null) ? _buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: mailController,
          decoration: const InputDecoration(hintText: 'Enter mail'),
        ),
        TextField(
          controller: phonecontroller,
          decoration: const InputDecoration(hintText: 'Enter phone'),
        ),
        TextField(
          controller: siretcontroller,
          decoration: const InputDecoration(hintText: 'Enter siret'),
        ),
        TextField(
          controller: tvacontroller,
          decoration: const InputDecoration(hintText: 'Enter tva'),
        ),
        TextField(
          controller: addresscontroller,
          decoration: const InputDecoration(hintText: 'Enter address'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureClient = addClient(
                  nameController.text,
                  mailController.text,
                  phonecontroller.text,
                  siretcontroller.text,
                  tvacontroller.text,
                  addresscontroller.text);
            });
          },
          child: const Text('Create a client'),
        )
      ],
    );
  }

  FutureBuilder<Client> buildFutureBuilder() {
    return FutureBuilder<Client>(
      future: _futureClient,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Text('ça marche');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
