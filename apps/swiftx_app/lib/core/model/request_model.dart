import 'dart:convert';

import 'package:swiftx_app/core/model/user_model.dart';

class RequestModel {
  final int id;
  final DateTime created_at;
  final UserModel requester;
  final UserModel approver;
  final double amount;
  final String requester_id;
  final String approver_id;
  RequestModel({
    required this.id,
    required this.created_at,
    required this.requester,
    required this.approver,
    required this.amount,
    required this.requester_id,
    required this.approver_id,
  });

  RequestModel copyWith({
    int? id,
    DateTime? created_at,
    UserModel? requester,
    UserModel? approver,
    double? amount,
    String? requester_id,
    String? approver_id,
  }) {
    return RequestModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      requester: requester ?? this.requester,
      approver: approver ?? this.approver,
      amount: amount ?? this.amount,
      requester_id: requester_id ?? this.requester_id,
      approver_id: approver_id ?? this.approver_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'requester_id': requester_id,
      'approver_id': approver_id,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id']?.toInt() ?? 0,
      created_at: DateTime.parse(map['created_at']),
      requester: UserModel.fromMap(map['requester']),
      approver: UserModel.fromMap(map['approver']),
      amount: map['amount']?.toDouble() ?? 0.0,
      requester_id: map['requester_id'] ?? '',
      approver_id: map['approver_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) => RequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestModel(id: $id, created_at: $created_at, requester: $requester, approver: $approver, amount: $amount, requester_id: $requester_id, approver_id: $approver_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RequestModel &&
      other.id == id &&
      other.created_at == created_at &&
      other.requester == requester &&
      other.approver == approver &&
      other.amount == amount &&
      other.requester_id == requester_id &&
      other.approver_id == approver_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      created_at.hashCode ^
      requester.hashCode ^
      approver.hashCode ^
      amount.hashCode ^
      requester_id.hashCode ^
      approver_id.hashCode;
  }
}
