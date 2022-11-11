import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:payment_app/payment_model.dart';

class PaymentService {
  Future<PaymentModel?> getPaymentDetails(
      {required userId,
      required service,
      required name,
      required amount}) async {
    var body = {
      "user_id": userId,
      "ordered_services": service,
      "name": name,
      "amount": amount
    };
    try {
      var response = await http.post(
          Uri.parse('https://securemadhatv.cherritech.us/android/pay-test.php'),
          body: body);
      log(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return PaymentModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
