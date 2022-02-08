import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    ));

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplitBill(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bill_splitting.png',
              height: 250,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class SplitBill extends StatefulWidget {
  const SplitBill({Key? key}) : super(key: key);

  @override
  _SplitBillState createState() => _SplitBillState();
}

class _SplitBillState extends State<SplitBill> {
  double tip = 0;
  double personAmt = 0;
  double bill = 0;
  int personCnt = 1;
  int percentTip = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Bill Splitting',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(20.5),
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue.shade400,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      "Total per Person",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "${personAmt.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    prefixText: "Bill Amount: ",
                    prefixStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        bill = double.parse(value);
                        personAmt = (bill + tip) / personCnt;
                      },
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Text(
                            "Split",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 110),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (personCnt > 1)
                                      personCnt = personCnt - 1;
                                    personAmt = (bill + tip) / personCnt;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "$personCnt",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  personCnt = personCnt + 1;
                                  personAmt = (bill + tip) / personCnt;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Tip  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 200),
                    child: Text(
                      "$tip",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text("$percentTip %"),
                  Slider(
                    value: percentTip.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        percentTip = value.toInt();
                        tip = (percentTip / 100) * bill;
                        personAmt = (bill + tip) / personCnt;
                      });
                    },
                    max: 100,
                    activeColor: Colors.black,
                    min: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
