import 'dart:convert';

import 'package:swiftx_app/core/model/user_model.dart';

class TransactionModel {
  final int id;
  final DateTime created_at;
  final UserModel sender;
  final UserModel receiver;
  final double amount;
  final String status;
  final String sender_id;
  final String receiver_id;
  TransactionModel({
    required this.id,
    required this.created_at,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.status,
    required this.sender_id,
    required this.receiver_id,
  });

  TransactionModel copyWith({
    int? id,
    DateTime? created_at,
    UserModel? sender,
    UserModel? receiver,
    double? amount,
    String? status,
    String? sender_id,
    String? receiver_id,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      sender_id: sender_id ?? this.sender_id,
      receiver_id: receiver_id ?? this.receiver_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'sender_id': sender_id,
      'receiver_id': receiver_id,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id']?.toInt() ?? 0,
      created_at: DateTime.parse(map['created_at']),
      sender: UserModel.fromMap(map['sender']),
      receiver: UserModel.fromMap(map['receiver']),
      amount: map['amount']?.toDouble() ?? 0.0,
      status: map['status'] ?? '',
      sender_id: map['sender_id'] ?? '',
      receiver_id: map['receiver_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, created_at: $created_at, sender: $sender, receiver: $receiver, amount: $amount, status: $status, sender_id: $sender_id, receiver_id: $receiver_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.id == id &&
        other.created_at == created_at &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.amount == amount &&
        other.status == status &&
        other.sender_id == sender_id &&
        other.receiver_id == receiver_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        sender_id.hashCode ^
        receiver_id.hashCode;
  }
}
