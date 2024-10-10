import 'dart:convert';

class UserModel {
  String id;
  String email;
  String name;
  String phone;
  String username;
  String country;
  bool verified;
  double balance;
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.username,
    required this.country,
    required this.verified,
    required this.balance,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? username,
    String? country,
    bool? verified,
    double? balance,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      country: country ?? this.country,
      verified: verified ?? this.verified,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'username': username,
      'country': country,
      'verified': verified,
      'balance': balance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      username: map['username'] ?? '',
      country: map['country'] ?? '',
      verified: map['verified'] ?? false,
      balance: map['balance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, phone: $phone, username: $username, country: $country, verified: $verified, balance: $balance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.phone == phone &&
        other.username == username &&
        other.country == country &&
        other.verified == verified &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        username.hashCode ^
        country.hashCode ^
        verified.hashCode ^
        balance.hashCode;
  }
}
