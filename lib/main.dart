import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'customTextField.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMS to Phone',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(166, 143, 39, 1.0),
      ),
      home: const MyHomePage(title: 'SMS to Phone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  var message = '';
  var usr = ['03024716341','030154716341'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomTextField(
                      label: 'Phone Number',
                      isFilled: true,
                      fillColor: Colors.white,
                      controller: _phoneController,
                      textInputType: TextInputType.text,
                      hint: '03XX-XXXXXXX',
                      isReadOnly: false,
                      mode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(value!.length < 11){
                          return 'Enter 11 digit Phone number';
                        }
                        else if (value.length >11){
                          return 'Number must be 11 digit';
                        }
                        else {
                          return null;
                        }
                      }
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){

                        await generateOTP().then((_){
                          sendOTP(message, usr);
                        });

                      }
                    }, child: const Text('Send OTP'))

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateOTP() async{
    int code = Random().nextInt(9000)+1000;
    message = 'This is your 4 digit OTP Code: $code';
    print(message);
  }

    void sendOTP(String message, List<String> user) async {
      String _result = await sendSMS(message: message, recipients: user, sendDirect: true)
          .catchError((onError) {
        print(onError);
      });
      print(_result);
    }

}
