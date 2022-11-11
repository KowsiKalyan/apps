class PaymentModel {
  PaymentModel({
    this.error,
    this.keyid,
    this.keysecret,
    this.name,
    this.amount,
  });

  bool? error;
  String? keyid;
  String? keysecret;
  String? name;
  String? amount;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        error: json["error"],
        keyid: json["keyid"],
        keysecret: json["keysecret"],
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "keyid": keyid,
        "keysecret": keysecret,
        "name": name,
        "amount": amount,
      };
}
