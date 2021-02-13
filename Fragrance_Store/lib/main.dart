import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:clickable_list_wheel_view/measure_size.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _scrollController = FixedExtentScrollController();
  static const double _itemHeight = 10;
  static const int _itemCount = 100;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red[200]),
      home: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('FRAGRANCE'),
            centerTitle: true,
            actions: [
              Icon(Icons.favorite),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.search),
              ),
              Icon(Icons.more_vert),
            ],
            backgroundColor: Colors.pink[200],
          ),
          body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = FixedExtentScrollController();
  List<dynamic> infor = Fragrance_DATA;
  static const double _itemHeight = 180;
  static const int _itemCount = 10;
  double _price = 0.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            width: 400.00,
            height: 100.00,
            child: Image(
              image: AssetImage("assets/image/Perfume1.png"),
              fit: BoxFit.fitWidth,
            ),
            color: Color.fromARGB(255, 245, 222, 179),
          ),
          Container(
            height: 450,
            color: Color.fromARGB(255, 245, 222, 179),
            child: ClickableListWheelScrollView(
              scrollController: _scrollController,
              itemHeight: _itemHeight,
              itemCount: _itemCount,
              onItemTapCallback: (index) {
                setState(() {
                  _price += infor[index]['price'];
                });
                print("onItemTapCallback index: $index $_price");
              },
              child: ListWheelScrollView.useDelegate(
                controller: _scrollController,
                itemExtent: 200,
                physics: FixedExtentScrollPhysics(),
                overAndUnderCenterOpacity: 0.5,
                perspective: 0.002,
                onSelectedItemChanged: (index) {
                  print("onSelectedItemChanged index: $index");
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) => _child(index),
                  childCount: _itemCount,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 400,
            height: 104.9,
            color: Colors.pink[200],
            child:
                Text('Total Price : $_price', style: TextStyle(fontSize: 30)),
          )
        ],
      ),
    );
  }

  Widget _child(int index) {
    return AspectRatio(
        aspectRatio: 16 / 1,
        child: Container(
            padding: EdgeInsets.only(right: 10),
            color: Colors.pink[100],
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Text(
                    infor[index]["name"],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  infor[index]["band"],
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  'assets/image/${infor[index]["image"]}',
                  height: 100,
                ),
                Text(
                  "Price: " + "${infor[index]["price"]}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_basket, size: 40),
                  onPressed: () {},
                )
              ],
            )));
  }
}
