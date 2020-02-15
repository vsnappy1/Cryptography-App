import 'package:crypto_graphy/Cipher/PlayFairCipher.dart';
import 'package:crypto_graphy/Cipher/RailFenceCipher.dart';
import 'package:crypto_graphy/Cipher/ShiftCipher.dart';
import 'package:crypto_graphy/Cipher/SubstitutionCipher.dart';
import 'package:crypto_graphy/Cipher/VigenereCipher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CryptographyApp());
}

Widget cipher(String cypherName) {
  return Text(
    cypherName,
    style: TextStyle(
      color: Colors.grey[300],
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
  );
}

String outputText = "Output will appear here";
TextEditingController textEditingControllerInput = TextEditingController();
TextEditingController textEditingControllerKey = TextEditingController();
ShiftCipher shiftCipher = new ShiftCipher(key: 1);
VigenereCipher vigenereCipher = new VigenereCipher(key: "A");
SubstitutionCipher substitutionCipher = new SubstitutionCipher();
PlayFairCipher playFairCipher = new PlayFairCipher(key: "A");
RailFenceCipher railFenceCipher = new RailFenceCipher(key: 1);

final listDropDownItems = <DropdownMenuItem>[
  DropdownMenuItem(
      value: shiftCipher.cipherName, child: cipher(shiftCipher.cipherName)),
  DropdownMenuItem(
      value: vigenereCipher.cipherName,
      child: cipher(vigenereCipher.cipherName)),
  DropdownMenuItem(
      value: substitutionCipher.cipherName,
      child: cipher(substitutionCipher.cipherName)),
  DropdownMenuItem(
      value: playFairCipher.cipherName,
      child: cipher(playFairCipher.cipherName)),
  DropdownMenuItem(
      value: railFenceCipher.cipherName,
      child: cipher(railFenceCipher.cipherName)),
];

class CryptographyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Cryptography",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 4,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[700],
            elevation: 0,
          ),
          body: AppBody()),
    );
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropDownAndKey(),
          InputTextField(),
          OutputText(),
        ],
      ),
    );
  }
}

class DropDownAndKey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Row(
        children: <Widget>[
          DropDown(),
          Container(
            width: 100,
            margin: EdgeInsets.fromLTRB(43, 0, 0, 0),
            child: TextField(
              controller: textEditingControllerKey,
              style: TextStyle(fontSize: 18, color: Colors.white),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Key",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(150, 238, 238, 238))),
            ),
          ),
        ],
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  static String _value = listDropDownItems.elementAt(0).value;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.grey[800],
      ),
      child: DropdownButton(
        items: listDropDownItems,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextField(
        controller: textEditingControllerInput,
        autocorrect: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Input Plain/Cipher Text Here",
            hintStyle: TextStyle(color: Color.fromARGB(150, 238, 238, 238))),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

class OutputText extends StatefulWidget {
  @override
  _OutputTextState createState() => _OutputTextState();
}

class _OutputTextState extends State<OutputText> {
  void updateText() {
    setState(() {
      if (_DropDownState._value == shiftCipher.cipherName) {

        if(isNumeric(textEditingControllerKey.text)) {
          try {
            shiftCipher =
            new ShiftCipher(key: int.parse(textEditingControllerKey.text));
          } catch (error) {
            print(error);
          }
        }
        else{
         shouldBeNumber();
        }
      }

      else if (_DropDownState._value == vigenereCipher.cipherName) {
        if(!isNumeric(textEditingControllerKey.text)) {
          vigenereCipher =
          new VigenereCipher(key: textEditingControllerKey.text);
        }
        else{
          shouldBeWord();
        }
      }

      else if (_DropDownState._value == playFairCipher.cipherName) {
        if(!isNumeric(textEditingControllerKey.text)) {
          playFairCipher =
          new PlayFairCipher(key: textEditingControllerKey.text);
        }
        else{
          shouldBeWord();
        }
      }

      else if (_DropDownState._value == railFenceCipher.cipherName) {
        if(isNumeric(textEditingControllerKey.text)) {
          try {
            railFenceCipher = new RailFenceCipher(
                key: int.parse(textEditingControllerKey.text));
          } catch (error) {
            print(error);
          }
        }
        else{
          shouldBeNumber();
        }
      }
    });
  }

  void shouldBeNumber(){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Key should be number"),
    ));
  }

  void shouldBeWord(){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Key should be a word"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        encryptDecryptButton(),
        Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                outputText,
                style: TextStyle(fontSize: 16),
              ),
            ),
            onTap: () {
              Clipboard.setData(new ClipboardData(text: outputText));
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Copied to clipboard"),
              ));
            },
          ),
        ),
      ],
    );
  }

  bool isNumeric(String s) {
    try{
      int.parse(s);
      return true;
    }
    catch(error){
      return false;
    }
  }

  Widget encryptDecryptButton() {
    return Container(
      //margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          myButton("Encrypt", Icons.lock_outline, () {
            updateText();

            updateEncryptText();
          }),
          myButton("Decrypt", Icons.lock_open, () {
            updateText();

            updateDecryptText();
          }),
        ],
      ),
    );
  }

  void updateEncryptText() {
    if (_DropDownState._value == shiftCipher.cipherName) {
      outputText = shiftCipher.encrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == vigenereCipher.cipherName) {
      outputText = vigenereCipher.encrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == substitutionCipher.cipherName) {
      outputText = substitutionCipher.encrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == playFairCipher.cipherName) {
      outputText = playFairCipher.encrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == railFenceCipher.cipherName) {
      outputText = railFenceCipher.encrypt(textEditingControllerInput.text);
    }
  }

  void updateDecryptText() {
    if (_DropDownState._value == shiftCipher.cipherName) {
      outputText = shiftCipher.decrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == vigenereCipher.cipherName) {
      outputText = vigenereCipher.decrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == substitutionCipher.cipherName) {
      outputText = substitutionCipher.decrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == playFairCipher.cipherName) {
      outputText = playFairCipher.decrypt(textEditingControllerInput.text);
    } else if (_DropDownState._value == railFenceCipher.cipherName) {
      outputText = railFenceCipher.decrypt(textEditingControllerInput.text);
    }
  }

  Widget myButton(String title, IconData icon, Function function) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: RaisedButton(
          onPressed: function,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[Text(title), Icon(icon)],
          ),
        ),
      ),
    );
  }
}
