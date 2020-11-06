import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X-O',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List tmp, color, arr;
  int c1, c2, counter, player1Score, player2Score;

  _MyHomePageState() {
    tmp = new List(9);
    color = new List(9);
    arr = new List(9);
    for (int i = 0; i < 9; i++) {
      arr[i] = false;
      tmp[i] = " ";
      color[i] = 0xFFFFFFFF;
    }
    counter = 0;
    c1 = 0xFFFF0000;
    c2 = 0xFF00FF00;
    player1Score = 0;
    player2Score = 0;
  }

  bool checkEnd() {
    bool check = true;
    for (int i = 0; i < 9; i++) {
      if (arr[i] == false) {
        check = false;
        break;
      }
    }
    return check;
  }

  checkWin() {
    bool checkX = false, checkO = false;
    if ((tmp[0] == "X" && tmp[1] == "X" && tmp[2] == "X") ||
        (tmp[3] == "X" && tmp[4] == "X" && tmp[5] == "X") ||
        (tmp[6] == "X" && tmp[7] == "X" && tmp[8] == "X") ||
        (tmp[0] == "X" && tmp[3] == "X" && tmp[6] == "X") ||
        (tmp[1] == "X" && tmp[4] == "X" && tmp[7] == "X") ||
        (tmp[2] == "X" && tmp[5] == "X" && tmp[8] == "X") ||
        (tmp[0] == "X" && tmp[4] == "X" && tmp[8] == "X") ||
        (tmp[2] == "X" && tmp[4] == "X" && tmp[6] == "X")) {
      checkX = true;
    } else if ((tmp[0] == "O" && tmp[1] == "O" && tmp[2] == "O") ||
        (tmp[3] == "O" && tmp[4] == "O" && tmp[5] == "O") ||
        (tmp[6] == "O" && tmp[7] == "O" && tmp[8] == "O") ||
        (tmp[0] == "O" && tmp[3] == "O" && tmp[6] == "O") ||
        (tmp[1] == "O" && tmp[4] == "O" && tmp[7] == "O") ||
        (tmp[2] == "O" && tmp[5] == "O" && tmp[8] == "O") ||
        (tmp[0] == "O" && tmp[4] == "O" && tmp[8] == "O") ||
        (tmp[2] == "O" && tmp[4] == "O" && tmp[6] == "O")) {
      checkO = true;
    }
    if (checkX == true || checkO == true) {
      for (int i = 0; i < 9; i++) {
        arr[i] = true;
      }
      if (checkX == true) {
        setState(() {
          ++player1Score;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(title: Text("player 1 wins!"));
            });
      } else if (checkO == true) {
        setState(() {
          ++player2Score;
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(title: Text("player 2 wins!"));
            });
      }
    } else if (checkEnd() == true) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(title: Text("Draw!"));
          });
    }
  }

  void reset() {
    for (int i = 0; i < 9; i++) {
      arr[i] = false;
      setState(() {
        tmp[i] = " ";
        color[i] = 0xFFFFFFFF;
      });
    }
    counter = 0;
  }

  void resetScore() {
    setState(() {
      player1Score = 0;
      player2Score = 0;
    });
  }

  getStr(int x) {
    String str = " ";
    if (arr[x] == false) {
      arr[x] = true;
      if (counter % 2 == 1) {
        str = "O";
      } else if (counter % 2 == 0) {
        str = "X";
      }
      return str;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange[300],
            title: Center(
                child: Text(
              "TIC-TAC-TOE",
              style: TextStyle(color: Colors.white),
            )),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Player 1",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("X",
                          style: TextStyle(
                              fontSize: 20, color: Color(0xFFFF0000))),
                    ],
                  ),
                  Text(
                    '$player1Score' + '  :  ' + '$player2Score',
                    style: TextStyle(color: Color(0xFF6F6F6F), fontSize: 20),
                  ),
                  Column(
                    children: [
                      Text("Player 2",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5,
                      ),
                      Text("O",
                          style: TextStyle(
                              fontSize: 20, color: Color(0xFF00FF00))),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(width: 1, color: Color(0xFF6F6F6F)),
                  ),
                  children: [
                    TableRow(children: [
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(0);
                            if (s != null) {
                              setState(() {
                                tmp[0] = s;
                                if (s == "X")
                                  color[0] = c1;
                                else
                                  color[0] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[0],
                              style: TextStyle(
                                color: Color(color[0]),
                                fontSize: 98,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(1);
                            if (s != null) {
                              setState(() {
                                tmp[1] = s;
                                if (s == "X")
                                  color[1] = c1;
                                else
                                  color[1] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[1],
                              style: TextStyle(
                                color: Color(color[1]),
                                fontSize: 98,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(2);
                            if (s != null) {
                              setState(() {
                                tmp[2] = s;
                                if (s == "X")
                                  color[2] = c1;
                                else
                                  color[2] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[2],
                              style: TextStyle(
                                color: Color(color[2]),
                                fontSize: 98,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(3);
                            if (s != null) {
                              setState(() {
                                tmp[3] = s;
                                if (s == "X")
                                  color[3] = c1;
                                else
                                  color[3] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[3],
                              style: TextStyle(
                                color: Color(color[3]),
                                fontSize: 98,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(4);
                            if (s != null) {
                              setState(() {
                                tmp[4] = s;
                                if (s == "X")
                                  color[4] = c1;
                                else
                                  color[4] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[4],
                              style: TextStyle(
                                color: Color(color[4]),
                                fontSize: 98,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(5);
                            if (s != null) {
                              setState(() {
                                tmp[5] = s;
                                if (s == "X")
                                  color[5] = c1;
                                else
                                  color[5] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[5],
                              style: TextStyle(
                                color: Color(color[5]),
                                fontSize: 98,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(6);
                            if (s != null) {
                              setState(() {
                                tmp[6] = s;
                                if (s == "X")
                                  color[6] = c1;
                                else
                                  color[6] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[6],
                              style: TextStyle(
                                  color: Color(color[6]),
                                  fontSize: 98,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(7);
                            if (s != null) {
                              setState(() {
                                tmp[7] = s;
                                if (s == "X")
                                  color[7] = c1;
                                else
                                  color[7] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[7],
                              style: TextStyle(
                                  color: Color(color[7]),
                                  fontSize: 98,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: FlatButton(
                          onPressed: () {
                            String s = getStr(8);
                            if (s != null) {
                              setState(() {
                                tmp[8] = s;
                                if (s == "X")
                                  color[8] = c1;
                                else
                                  color[8] = c2;
                              });
                              counter++;
                              if (counter > 4) checkWin();
                            }
                          },
                          child: Text(tmp[8],
                              style: TextStyle(
                                  color: Color(color[8]),
                                  fontSize: 98,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 35,
                    width: 145,
                    child: RaisedButton(
                        onPressed: () {
                          reset();
                        },
                        color: Colors.orange[300],
                        child: Text(
                          "Play Again",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 35,
                    width: 145,
                    child: RaisedButton(
                        onPressed: () {
                          resetScore();
                        },
                        color: Colors.orange[300],
                        child: Text(
                          "Reset Score",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
