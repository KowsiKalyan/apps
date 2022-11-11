import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/payment_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController amountText = TextEditingController();
  final Controller _controller = Get.put(Controller());
  late var _razorpay;

  @override
  void initState() {
    fetchData();
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
  payAmount({required amount, required key}) async {
    ///Make payment

    var options = {
      // razorpay key
      'key': key ?? "",
      // amount will be multiple of 100
      'amount': (int.parse(amount) * 100).toString(), //So its pay 500
      'name': 'Developer',
      'description': 'Dev',
      'timeout': 300, // in seconds
      'prefill': {'contact': '00000000', 'email': 'dev@gmail.com'}
    };
    _razorpay.open(options);
  }

  fetchData() async {
    await _controller.getPaymentInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.isDataLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (_controller.paymentData.isEmpty) {
        return const Scaffold(
          body: Center(
            child: Text("No Payment Data Found"),
          ),
        );
      } else {
        var data = _controller.paymentData[0];
        return SafeArea(
          child: Scaffold(
            body: Container(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data.name ?? ""),
                    Text(data.amount ?? ""),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (data.amount!.isNotEmpty ||
                              data.keyid!.isNotEmpty) {
                            payAmount(amount: data.amount, key: data.keyid);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Somthing Went wrong'),
                            ));
                          }
                        },
                        child: const Text("Pay"))
                  ],
                ),
              ),
            )),
          ),
        );
      }
    });
  }
}
