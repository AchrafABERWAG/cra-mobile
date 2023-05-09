class Client {
  final int id;
  final String name;
  final String mail;
  final String phone;
  final String siret;
  final String tva;
  final String address;
  //final List<Project> projects;

  const Client({
    required this.id,
    required this.name,
    required this.mail,
    required this.phone,
    required this.siret,
    required this.tva,
    required this.address,
    //required this.projects,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      mail: json['mail'],
      phone: json['phone'],
      siret: json['siret'],
      tva: json['tva'],
      address: json['address'],
      //projects: json['projects'],
    );
  }
}
