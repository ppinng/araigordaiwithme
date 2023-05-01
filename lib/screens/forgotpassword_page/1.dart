import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:araigordaiwithme/constant.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class forgotMain extends StatelessWidget {
  const forgotMain({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: size.width,
          //   height: 200,
          //   child: Image.asset('images/forgot.png'),
          // ),
          // const Padding(
          //   padding: EdgeInsets.all(0),
          //   child: Text(
          //     'Jum Mai Dai.',
          //     style: TextStyle(
          //         color: kAppColor,
          //         fontSize: 40.0,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const Padding(
          //   padding: EdgeInsets.all(0),
          //   child: forgotEmail(),
          // )
        ],
      ),
    );
  }
}

class forgotEmail extends StatefulWidget {
  const forgotEmail({super.key});

  @override
  State<forgotEmail> createState() => _forgotEmailState();
}

class _forgotEmailState extends State<forgotEmail> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = useTextEditingController();
  final _passwordController = useTextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  color: kTextFieldColor,
                  borderRadius: new BorderRadius.circular(50.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return "Enter Correct Email Address";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       if (_formKey.currentState!.validate()) {
          //         showDialog(
          //             context: context,
          //             builder: (context) {
          //               return AlertDialog(
          //                 content: Text(
          //                     "${_emailController.text}\n${_passwordController.text}"),
          //               );
          //             });
          //       }
          //     },
          //     child: const Text("Next"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
