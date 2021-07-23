import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'todo.dart';
import 'coin.dart';
import 'dart:html' show HttpRequest;
import 'dart:js' as js;

bool blackCheck = true;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        title: _title,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        darkTheme:
        ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => FirstPage(),
          '/second': (context) => SecondPage()
        },
      );
    }
}

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {

  //List<DropdownMenuItem> list = List();
  /*
    coinList.forEach(() => {}) : qoduf dksdml zmffotm rkrrkrdp eogo gkatnfmf wnf tndlTek.
    얘를 이ㅛㅇㅇ해 어떻게 리턴을 정의할 것인가? {} 안에 row 넣고, 그 child란에 text 넣는다 가정시, text()
     */

  List<Coin> coinList = [Coin("a","b","c","d","e"),
    Coin("e","f","g","h","i"), Coin("j","k","l","m","n"),
    Coin("o","p","q","r","s"), Coin("t","u","v","w","x")];


  ScrollController _scrollController = new ScrollController();
  int page = 1;
  int genre = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener( () {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        page++;
      }
    });
  }

  /*Future<List<Coin>> getCoin() async {
    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database.rawQuery(
        'select title, content, id from todos where active = 1');

    return List.generate(maps.length, (i) {
      return Coin(
          content1: maps[i]['content1'].toString(),
          content2: maps[i]['content2'].toString(),
          content3: maps[i]['id']);
    });
  }*/
  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumn = [];
    dataColumn.add(DataColumn(label: Text("항목1")));
    dataColumn.add(DataColumn(label: Text("항목2")));
    dataColumn.add(DataColumn(label: Text("항목3")));
    dataColumn.add(DataColumn(label: Text("항목4")));
    dataColumn.add(DataColumn(label: Text("항목5")));
    return dataColumn;
  }

  List<DataRow> _getRows() {
    List<DataRow> dataRow = [];
    for (var i=0; i<coinList.length-1; i++) {
      List<DataCell> cells = [];
      if(genre == 1) {
        cells.add(DataCell(Text(coinList[i].content1)));
        cells.add(DataCell(Text(coinList[i].content2)));
        cells.add(DataCell(Text(coinList[i].content3)));
        cells.add(DataCell(Text(coinList[i].content4)));
        cells.add(DataCell(Text(coinList[i].content5)));
      }
      else if(genre == 2) {
        cells.add(DataCell(Text(coinList[i].content5)));
        cells.add(DataCell(Text(coinList[i].content4)));
        cells.add(DataCell(Text(coinList[i].content3)));
        cells.add(DataCell(Text(coinList[i].content2)));
        cells.add(DataCell(Text(coinList[i].content1)));
      }
      else if(genre == 3) {
        cells.add(DataCell(Text(coinList[i].content3)));
        cells.add(DataCell(Text(coinList[i].content2)));
        cells.add(DataCell(Text(coinList[i].content4)));
        cells.add(DataCell(Text(coinList[i].content1)));
        cells.add(DataCell(Text(coinList[i].content5)));
      }
      dataRow.add(DataRow(cells: cells));
    }
    return dataRow;
  }

  Widget _getDataTable() {
    return DataTable(
      horizontalMargin: 100.0, columnSpacing: 120.0,
      columns: _getColumns(),
      rows: _getRows(),
    );
  }

  Brightness bright = Brightness.dark;
  Color textInSca = Colors.yellow;
  @override
  Widget build(BuildContext context) {
    //input in textefield
    TextEditingController varUrl = TextEditingController();

    return MaterialApp (
      theme: ThemeData(
        brightness: bright,
        primarySwatch: Colors.blue,
      ),
    //  darkTheme:
    //  ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),

        home: Scaffold(
          appBar: AppBar(
              title: Text('DYOR'),
              actions: <Widget> [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                      )
                  ),
                ),
              ]
          ),
          drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    title: Text('Setting'),
                    onTap: () {
                      AlertDialog dialog = new AlertDialog(
                          title: Text('흑색모드'),
                          actions: <Widget> [
                            Switch(
                                value: blackCheck,
                                onChanged: (value) {
                                  setState( () {
                                    blackCheck = value;
                                    if(blackCheck == true) {
                                      bright = Brightness.dark;
                                      textInSca = Colors.yellow;
                                    }
                                    else {
                                      bright = Brightness.light;
                                      textInSca = Colors.brown;
                                    }
                                  });
                                }
                            )
                          ]
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => dialog);
                    },
                    trailing: Icon(Icons.more_vert_rounded),
                  ),
                ],
              )
          ),

          body: Container(
            child: Center(
                child:Column (
                    children: <Widget> [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child:Text('Text', style: TextStyle(fontSize: 40),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left : MediaQuery.of(context).size.width / 3 ,
                            right :MediaQuery.of(context).size.width / 3),
                        child:TextField(controller: varUrl,
                          decoration: InputDecoration(labelText: '치고싶은거쳐',
                          ),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child:RaisedButton(
                          child: Text('submit'),
                          onPressed: () {
                            AlertDialog dialog = new AlertDialog(
                                title: Text('할 일'),
                                content: Text('기타 뭐 받아서 할거'),
                                actions: <Widget> [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('x')
                                  ),
                                ]
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => dialog);
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
                          child:Center(
                              child:Row(
                                  children:<Widget> [
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
                                      child:Text('list', style: TextStyle(fontSize: 20, color: textInSca,), ),
                                    ),

                                    /*
                      버튼 3개중 뭐를 넣느냐에 따라 genre가 달라짐.
                       */
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 100),
                                      child: MaterialButton(
                                        shape: CircleBorder(side: BorderSide(width: 2, color: Colors.red, style: BorderStyle.solid)),
                                        child: Text("P"),
                                        color: Colors.teal,
                                        textColor: Colors.amber,
                                        onPressed: (){
                                          setState( () {
                                            genre = 1;
                                          });},
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 100),
                                      child: MaterialButton(
                                        shape: CircleBorder(side: BorderSide(width: 2, color: Colors.red, style: BorderStyle.solid)),
                                        child: Text("G"),
                                        color: Colors.teal,
                                        textColor: Colors.amber,
                                        onPressed: (){ setState( () {
                                          genre = 2;
                                        }); },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 100),
                                      child: MaterialButton(
                                        shape: CircleBorder(side: BorderSide(width: 2, color: Colors.red, style: BorderStyle.solid)),
                                        child: Text("B"),
                                        color: Colors.teal,
                                        textColor: Colors.amber,
                                        onPressed: (){ setState( () {
                                          genre = 3;
                                        }); },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 100),
                                      child: MaterialButton(
                                        shape: CircleBorder(side: BorderSide(width: 2, color: Colors.lightBlueAccent, style: BorderStyle.solid)),
                                        child: Text("?", style: TextStyle(color:Colors.brown)),
                                        color: Colors.white,
                                        textColor: Colors.amber,
                                        onPressed: () {
                                          AlertDialog dialog = new AlertDialog(
                                              content: Text('P를 누르면 팬케이크스왑인지 뭐시기가 나오고\n'
                                                  'G를 누르면 뭐가 나올지 나도 모르고\n'
                                                  'B를 누르면 아무튼 뭐가 나오겠지 뭐'),
                                              actions: <Widget> [
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('x')
                                                ),
                                              ]
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) => dialog);
                                        },
                                      ),
                                    ),
                                  ]
                              )
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          //child: SizedBox(
                          child:SingleChildScrollView(
                            child: _getDataTable(),
                          ),
                        ),
                      )
                    ]
                )
            ) ,
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/second');
            },
            child: Icon(Icons.add),
          ),
        ),
    );

  }
}


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Container( //컨테이너로 감싼다.
        decoration: BoxDecoration( //decoration 을 준다.
            image: DecorationImage(
                image: AssetImage("images/logo.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent, //스캐폴드에 백그라운드를 투명하게 한다.
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('My App'),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ),
        ),
      ),
    );
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('돌아가기'),
          ),
        ),
      ),
    );*/
  }
}