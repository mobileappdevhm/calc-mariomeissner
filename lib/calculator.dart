import 'package:flutter/material.dart';


class Calculator extends StatefulWidget {
  
  @override
  _CalculatorState createState() => new _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  //This is the state of the calculator.
  String firstNumber = "";
  String secondNumber = "";
  String op = "";
  String display = "";
  double result;

  @override
  build(BuildContext context){
    return new Material(
      color: Colors.blue[200],
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          const Divider(height: 300.0),
          //The display
          new Expanded(
            flex: 2,
            child: new CalcDisplay(display)
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
    
    
    setState((){
       
      if (value == "C"){
        // Reset state
        firstNumber = "";
        secondNumber = "";
        op = "";
        result = null;
        display = "";
        
      }

      // User is imputting the second number.
      // Wait for more digits or the equals sign.
      // Ignore operators.
      if (op != ""){

        // If its not a number, it should only be the equals sign
        if (!_isNumber(value)){
          if (value == "="){
            result = _calculate(firstNumber, op, secondNumber);
            display = result.toString();

            // Reset state
            firstNumber = "";
            secondNumber = "";
            op = "";
            result = null;
          // If not equals sign, dont do anything.
          } else {
            //TODO: Do I need this else?
          }
        // If it is a number, add it to the secondNumber
        } else {
          secondNumber += value;
          display = firstNumber + op + secondNumber;
        }
      
      // User is imputting the first number. 
      // Add more digits to the first number or get the operator.
      // Ignore the equals sign.
      // TODO: Do I need to check more cases?
      } else {
        
        if (!_isNumber(value)){
          // If its an operator and we still dont have first number then ignore
          if (firstNumber != ""){
            op = value;
            display = firstNumber + op;
          }
          
        } else {
          firstNumber = firstNumber + value;
          display = firstNumber;
        }
        // If first number was null, initialize and add

      }

    });
  }

  /// Tells if the element is a number or not.  
  bool _isNumber(String element){
    bool isInt = int.parse(element, onError: (source) => null) != null;
    bool isPoint = (element == ".");
    return isInt || isPoint;
  }

  double _calculate(String first, String op, String second){

    double result;
    double firstNumber, secondNumber;
    try{
      firstNumber = double.parse(first);
      secondNumber = double.parse(second);
    } on FormatException {
      return double.nan;
    }
   
    switch (op) {
      case "x" : result = firstNumber * secondNumber; break;
      case "/" : result = firstNumber / secondNumber; break;
      case "+" : result = firstNumber + secondNumber; break;
      case "-" : result = firstNumber - secondNumber; break;
      default: print("Something went wrong in calculate function");
      }
    return result;
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

