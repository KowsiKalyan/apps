import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/payment_model.dart';
import 'package:payment_app/payment_screen.dart';
import 'package:payment_app/payment_service.dart';

class Controller extends GetxController {
  final PaymentService _services = PaymentService();
  final RxList<PaymentModel> _paymentData = <PaymentModel>[].obs;
  RxList<PaymentModel> get paymentData => _paymentData;
  RxBool isDataLoading = true.obs;
// automated
  Future getPaymentInfo() async {
    isDataLoading(true);
    try {
      var data = await _services.getPaymentDetails(
          userId: "2222", service: "222", name: "test", amount: "100");
      if (data != null) {
        _paymentData.clear();
        _paymentData.add(data);
        isDataLoading(false);
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  TextEditingController userId = TextEditingController();
  TextEditingController orderService = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();

  // manual
  Future getPaymentInfoManual(context) async {
    isDataLoading(true);
    if (userId.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill userID'),
      ));
    } else if (orderService.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill services'),
      ));
    } else if (name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill name'),
      ));
    } else if (amount.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill amount'),
      ));
    } else {
      try {
        var data = await _services.getPaymentDetails(
            userId: userId.text,
            service: orderService.text,
            name: name.text,
            amount: amount.text);
        if (data != null) {
          _paymentData.clear();
          _paymentData.add(data);
          if (data.keyid!.isNotEmpty) {
          } else {
            Get.to(() => const PaymentScreen());
          }
          isDataLoading(false);
        } else {}
      } catch (e) {
        rethrow;
      }
    }
  }
}
