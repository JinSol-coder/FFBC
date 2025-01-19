class Payment {
  final String id;
  final double amount;
  final String method;
  final DateTime createdAt;
  final String status;

  Payment({
    required this.id,
    required this.amount,
    required this.method,
    required this.createdAt,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      method: json['method'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'method': method,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
} 