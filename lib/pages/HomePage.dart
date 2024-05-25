import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:openbankapp/api/accounts.dart';
import 'package:openbankapp/models/account.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _lastRefreshedAt = DateTime.now();
  double balance = 0.00;
  List<Account> accounts = [];

  void loadAccounts() async {
    accounts = await getAccounts();
    try {
      setState(() {
        balance = 0.00;
        accounts.forEach(
          (element) {
            if (element.balance.currency == "AED") {
              balance += element.balance.amount;
            }
          },
        );
        accounts = accounts;
        _lastRefreshedAt = DateTime.now();
      });
    } catch (e) {
      SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text("Ошибка"), content: Text(e.toString()));
            },
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            loadAccounts();
          });
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SafeArea(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 72,
                        ),
                        Text(
                          "Мой банк",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    balance.toStringAsFixed(0),
                                    style: TextStyle(
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    ",00",
                                    style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "AED",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white.withOpacity(0.7)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                DateFormat("Обновлено: dd.MM.yy в HH:mm")
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.7)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                style: const ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(
                                        Colors.transparent),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.transparent)),
                                onPressed: () => {},
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: SvgPicture.asset(
                                        width: 22,
                                        height: 22,
                                        "assets/icons/add.svg",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      "Пополнить",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(
                                        Colors.transparent),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.transparent)),
                                onPressed: () => {},
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: SvgPicture.asset(
                                        width: 22,
                                        height: 22,
                                        "assets/icons/cheque.svg",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      "Запросить",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    overlayColor: WidgetStatePropertyAll(
                                        Colors.transparent),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.transparent)),
                                onPressed: () => {},
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: SvgPicture.asset(
                                        width: 22,
                                        height: 22,
                                        "assets/icons/cardsend.svg",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      "Перевести",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Text(
                            "Hello, 2312!",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
