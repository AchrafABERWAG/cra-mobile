import 'package:flutter/material.dart';
import '../api.dart';
import '../model/client.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client',
      theme: ThemeData(),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Client>>(
            future: fetchClients(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ClientsList(clients: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class ClientsList extends StatelessWidget {
  const ClientsList({super.key, required this.clients});

  final List<Client> clients;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: clients.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              clients[index].name,
                              style: const TextStyle(
                                  fontFamily: 'lambda', fontSize: 19),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Divider(),
                          Text(
                            'Name: ${clients[index].name}',
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'phone: ${clients[index].phone}',
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Siret: ${clients[index].siret}',
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'tva: ${clients[index].tva}%',
                            textAlign: TextAlign.left,
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
