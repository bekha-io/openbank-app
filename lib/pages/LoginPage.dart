import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openbankapp/api/auth.dart';
import 'package:openbankapp/components/UIButton.dart';
import 'package:openbankapp/components/UITextInput.dart';
import 'package:openbankapp/pages/HomePage.dart';
import '../components/Heading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumber = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var token = await authenticate(_phoneNumber.text);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
      } catch (ex) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Ошибка!"),
                content: Text(ex.toString()),
              );
            });
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to submit form.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(top: 48, left: 24, right: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(text: "Вход в систему", level: 1),
                  SizedBox(
                    height: 24,
                  ),
                  Heading(
                      text: "Введите номер телефона для входа в систему",
                      level: 5),
                ],
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    UITextInput(
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return "Введите номер телефона";
                        }
                      },
                      controller: _phoneNumber,
                      label: "Номер телефона",
                      prefixText: "+971 ",
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                    ),
                  ],
                )),
            const SizedBox(
              height: 64,
            ),
            UIButton(
              text: "Войти",
              onPressed: _submitForm,
            )
          ]),
        )),
      ),
    );
  }
}
