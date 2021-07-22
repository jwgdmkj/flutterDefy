import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../todo.dart';
import 'coin.dart';
import 'dart:html' show HttpRequest;
import 'dart:js' as js;

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
        brightness: Brightness.light,
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
 // coinList.insert(new Coin("a","b","c","d","e"));
//  List<Coin> coinList = List.generate(
 //   5,
  //    (i) => Coin('idx $i',
   //   'so $i', 'and $i', 'but $i', 'also $i'),
  //);

  /*
      Coin(1, "a", "b", "c", "d"),
    Coin(2, "a", "b", "c", "d"),
    Coin(3, "a", "b", "c", "d"),
    Coin(4, "a", "b", "c", "d"),
    Coin(5, "a", "b", "c", "d"),

  external factory List.generate(int length, E generator(int index),
    {bool growable = true});
   */

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
        //getAreaList(area: area.value, contentTypeId: kind.value, page: page);
      }
    });

  //  consList = getCoin();
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
      cells.add(DataCell(Text(coinList[i].content1)));
      cells.add(DataCell(Text(coinList[i].content2)));
      cells.add(DataCell(Text(coinList[i].content3)));
      cells.add(DataCell(Text(coinList[i].content4)));
      cells.add(DataCell(Text(coinList[i].content5)));

      dataRow.add(DataRow(cells: cells));
    }
    return dataRow;
  }

  Widget _getDataTable() {
    return DataTable(
      horizontalMargin: 12.0, columnSpacing: 28.0,
      columns: _getColumns(),
      rows: _getRows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //input in textefield
    TextEditingController varUrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('DYOR'),
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
                  decoration: InputDecoration(labelText: '치고싶은거쳐 ${coinList.length}',
                  ),),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child:RaisedButton(
                    child: Text('submit'),
                    onPressed: () {
                      setState( () {
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
                child:Center(
                  child:Row(
                    children:<Widget> [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 3),
                        child:Text('list', style: TextStyle(fontSize: 20, color: Colors.yellow,), ),
                      ),

                      /*
                      버튼 3개중 뭐를 넣느냐에 따라 genre가 달라짐.
                       */
                      Padding(
                        padding: EdgeInsets.only(left: 0, right: 1),
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
                        padding: EdgeInsets.only(left: 0, right: 1),
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
                        padding: EdgeInsets.only(left: 0, right: 1),
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
                      /*child: Column(
                        children: <Widget>[
                          DataTable(
                              columns: <DataColumn>[
                                DataColumn(
                                    label: Text("항목1")
                                ),
                                DataColumn(
                                  label: Text("항목2"),
                                  numeric: true,
                                ),
                                DataColumn(
                                    label: Text("항목3")
                                ),
                                DataColumn(
                                    label: Text("항목4")
                                ),
                                DataColumn(
                                    label: Text("항목5")
                                ),
                              ],
                              rows:[
                                DataRow(
                                  cells: [
                                    DataCell(Text("${coinList[0].content1}")),
                                    DataCell(Text("${coinList[0].content2}")),
                                    DataCell(Text("${coinList[0].content3}")),
                                    DataCell(Text("${coinList[0].content4}")),
                                    DataCell(Text("${coinList[0].content5}")),
                                  ]
                                )
                              ]// coinList
                              //어떤 버튼을 눌렀느냐에 따라 보여야 될게 다름
                              *//*
                              리스트를 rows 안에 배열 넣기
                               *//*

                          ),
                        ],
                      )*/
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
    );
  }
}


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}