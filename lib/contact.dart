class Contact {
  int? id;
  String? name;
  String? address;
  String? phoneNumber;

  Contact({this.id, this.name, this.address, this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'address' : address,
      'phoneNumber' : phoneNumber
    };
  }

}