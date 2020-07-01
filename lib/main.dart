import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController inputName = TextEditingController();
String name = '';
int page = 0;
bool answer;
DateTime currentBackPressTime;

// TODO: ornamendid mingisugused kujundusele

void main() {
  runApp(MaterialApp(
    home: RootPage(),
  ));
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      //() async => false,
      child: Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Pulmakutse',
          style: TextStyle(fontSize: 30, fontFamily: 'shadows', fontWeight: FontWeight.bold),),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 15),
                    ],
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    )),
                child: Column(children: [
                  Text(
                    'Kas',
                    style: TextStyle(fontSize: 25, fontFamily: 'shadows', fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontFamily: 'shadows', fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: '-sisesta siia nimi-',
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      name = text;
                    },
                  ),
                  Text(
                    'peaks tulema sinu pulma?',
                    style: TextStyle(fontSize: 25, fontFamily: 'shadows', fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (name == "") {
                  return Fluttertoast.showToast(
                    msg: "Pane ikka mingi nimi ka :)",
                  );
                } else {
                  page = 1;
                  return Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '?',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              textColor: Colors.white,
              color: Colors.red,
              shape: CircleBorder(),
            ),
          ],
        )),
      ),
    );
  }
}

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(
      msg: "Väljumiseks vajuta uuesti!",
    );
    return Future.value(false);
  }
  //return Future.value(true);
  return SystemNavigator.pop();
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void _setPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text('Pulmakutse',
          style: TextStyle(fontSize: 30, fontFamily: 'shadows', fontWeight: FontWeight.bold),),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 15),
                  ],
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  (() {
                    if (page == 1) {
                      page = 2;
                      return "Kas $name on su sugulane?";
                    } else if (page == 2 && answer == true) {
                      page = 3;
                      return "Kas te olete lähedased?";
                    } else if (page == 3 && answer == false) {
                      page = 4;
                      return "Kas $name on see kummaline tegelane, kes alati kohatuid nalju teeb?";
                    } else if (page == 4 && answer == false) {
                      page = 5;
                      return "Kas su ema kurvastab väga, kui sa teda ei kutsu?";
                    } else if (page == 8 && answer == true) {
                      page = 11;
                      return "Kas $name muudaks su pulma veelgi lõbusamaks?";
                    } else if (page == 7 && answer == true) {
                      page = 8;
                      return "Kas oleksid valmis talle õhtusöögi välja tegema?";
                    } else if (page == 6 && answer == true) {
                      page = 7;
                      return "Kas sa suhtled temaga ka väljaspool tööd, kooli või trenni?";
                    } else if (page == 9 && answer == true) {
                      page = 10;
                      return "Kas tal võiksid tulla vinged pulmad, kuhu minna tahaksid?";
                    } else if (page == 2 && answer == false) {
                      page = 6;
                      return "Kas sa oled viimase aasta jooksul temaga suhelnud?";
                    } else if (page == 6 && answer == false) {
                      page = 9;
                      return "Kas $name teab su kihlatu nime?";
                    } else {
                      return "..............";
                    }
                  })(),
                  style: TextStyle(fontSize: 25, fontFamily: 'shadows', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  shape: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.thumb_up,
                      size: 40,
                    ),
                  ),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    answer = true;
                    if (page == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShouldNotCome()),
                      );
                    }
                    if (page == 3 || page == 5 || page == 11 || page == 10) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShouldCome()),
                      );
                    }
                    _setPage();
                  },
                ),
                RaisedButton(
                  shape: CircleBorder(),
                  color: (Colors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.thumb_down,
                      size: 40,
                    ),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    answer = false;
                    if (page == 5 ||
                        page == 11 ||
                        page == 8 ||
                        page == 10 ||
                        page == 9 ||
                        page == 7) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShouldNotCome()),
                      );
                    }
                    _setPage();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//Peaks tulema leht

class ShouldCome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text('Pulmakutse',
            style: TextStyle(fontSize: 30, fontFamily: 'shadows', fontWeight: FontWeight.bold),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 15),
                ],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                color: Colors.green,
              ),
              margin: EdgeInsets.all(15.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Jep, $name peab kindlasti tulema su pulma!',
                  style: TextStyle(fontSize: 25, fontFamily: 'shadows', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                page = 1;
                name = "";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootPage()),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 40,
                  )),
              textColor: Colors.white,
              color: Colors.red,
              shape: CircleBorder(),
            ),
          ],
        )),
      ),
    );
  }
}

//Ei peaks tulema leht

class ShouldNotCome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: Text('Pulmakutse',
            style: TextStyle(fontSize: 30, fontFamily: 'shadows', fontWeight: FontWeight.bold),),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 15),
                ],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Ei, selle peo peab $name vahele jätma!',
                  style: TextStyle(fontSize: 25, fontFamily: 'shadows', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                page = 1;
                name = "";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootPage()),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 40,
                  )),
              textColor: Colors.white,
              color: Colors.red,
              shape: CircleBorder(),
            ),
          ],
        )),
      ),
    );
  }
}
