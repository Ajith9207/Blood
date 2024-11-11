class Donor {
  final String name;
  final String age;
  final String bloodGroup;
  final String lastDonated;
  final String phoneNumber;

  Donor({
    required this.name,
    required this.age,
    required this.bloodGroup,
    required this.lastDonated,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'bloodGroup': bloodGroup,
      'lastDonated': lastDonated,
      'phoneNumber': phoneNumber,
    };
  }

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      lastDonated: json['lastDonated'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
}
