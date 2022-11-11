import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/payment_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Controller _controller = Get.put(Controller());
  late var _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  payAmount() async {
    ///Make payment
    if (_controller.paymentData[0].amount!.isNotEmpty &&
        _controller.paymentData[0].keyid!.isNotEmpty) {
      var options = {
        // razorpay key
        'key': _controller.paymentData[0].keyid ?? "",
        // amount will be multiple of 100
        'amount': (int.parse(_controller.paymentData[0].amount!) * 100)
            .toString(), //So its pay 500
        'name': 'Developer',
        'description': 'Dev',
        'timeout': 300, // in seconds
        'prefill': {'contact': '00000000', 'email': 'dev@gmail.com'}
      };
      _razorpay.open(options);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill amount'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                payAmount();
              },
              child: const Text("Pay"))),
    );
  }
}
