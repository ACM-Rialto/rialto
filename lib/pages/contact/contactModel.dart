class Contact {

  String id;
  String name;
  String email;
  String message;
  String to;
  String from;

  // String id;
  // String price;
  // String name;
  // String img;

  Contact({this.id, this.name, this.email, this.message, this.to, this.from});

  Contact.fromMap(Map snapshot, String id) :
        // id = id ?? '',
        id = id ?? '',
        name = snapshot['name'] ?? '',
        email = snapshot['email'] ?? '',
        message = snapshot['message'] ?? '',
        to = snapshot['to'] ?? '',
        from = snapshot['from'] ?? '';

  toJson() {
    return {
      "name": name,
      "email": email,
      "message": message,
      "to": to,
      "from": from
    };
  }
}
