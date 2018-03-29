import 'package:flutter/material.dart';


class Calculator extends StatefulWidget {
  
  @override
  _CalculatorState createState() => new _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  @override
  build(BuildContext context){
    return new Material(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[

          //The display
          new Expanded(
            flex: 2,
            child: new CalcDisplay("100")
          ),
          const Divider(height: 1.0),
          //The KeyPad
          new Expanded(
            flex: 3,
            child: new KeyPad(this)
          )
          


        ],
      ),
    );
  }

  void handle(value){
    //TODO: Do something.
    print("I got handleed");
  }
}

class KeyPad extends StatelessWidget{

  final _CalculatorState state;
  KeyPad(this.state);

  @override
  Widget build (BuildContext context){
    return new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new KeypadColumn(["7", "4", "1", "."], state),
            new KeypadColumn(["8", "5", "2", "0"], state),
            new KeypadColumn(["9", "6", "3", "="], state),
            new KeypadColumn(["C", "/", "x", "+", "-"], state)
          ],
    );
  }
}

/// A column of keys to be used in a Keypad
class KeypadColumn extends StatelessWidget{
  final List<String> elements;
  final _CalculatorState state;

  KeypadColumn(this.elements, this.state);

  @override
  Widget build(BuildContext context){
    return new Expanded(
      child: new Column(
        children: _getKeys(),
      ),
    );
        
  }

  bool _isNumber(String element){
    return int.parse(element, onError: (source) => null) != null;
  }

  List<Key> _getKeys(){
    List<Key> keys = new List<Key>();
    elements.forEach((element) {
      if (_isNumber(element)){
        keys.add(new NumberKey(element, state));
      } else {
        keys.add(new OperatorKey(element, state));
      }
    });
    return keys;
  }
}

class OperatorKey extends Key{
  OperatorKey(value, state) : super(value, state) {
    //Do stuff
  }
}

class NumberKey extends Key{
  NumberKey(value, state) : super(value, state) {
    //Do stuff
  }
}

abstract class Key extends StatelessWidget{
  final String _value;
  final _CalculatorState state;

  Key(this._value, this.state);

  @override
  Widget build(BuildContext context){
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new FlatButton(
        child: new Text(_value),
        onPressed: () => state.handle(_value),
    )
      
    );
  }
}

class CalcDisplay extends StatelessWidget {
  CalcDisplay(this.content);

  final String content;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: new EdgeInsets.all(40.0),
        child: new Text(
          content,
          style: const TextStyle(fontSize: 24.0)
        )

      )
      
      
    );
  }
}

