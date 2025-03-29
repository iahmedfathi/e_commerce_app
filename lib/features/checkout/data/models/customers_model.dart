class CustomersModel {
  final String id;
  final String name;

  CustomersModel({required this.id, required this.name});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
