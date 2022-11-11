import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_app/payment_controller.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _controller.userId,
                decoration: const InputDecoration(
                    hintText: "Enter User ID", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _controller.orderService,
                decoration: const InputDecoration(
                    hintText: "Enter Services", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _controller.name,
                decoration: const InputDecoration(
                    hintText: "Enter Name", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _controller.amount,
                decoration: const InputDecoration(
                    hintText: "Enter Amount", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _controller.getPaymentInfoManual(context);
                  },
                  child: const Text("Submit"))
            ],
          ),
        )),
      ),
    );
  }
}
