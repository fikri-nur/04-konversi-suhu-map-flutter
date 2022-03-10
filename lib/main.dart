import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konversi_suhu_flutter/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _inputUser = 0;
  double _kelvin = 0;
  double _reamur = 0;
  double _fahrenheit = 0;

  var listItem = ["Kelvin", "Reamur", "Fahrenheit"];
  final temperaturController = TextEditingController();
  String _newValue = "Kelvin";
  double _result = 0;

  List<String> listViewItem = <String>[];

  @override
  void dispose() {
    temperaturController.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Konversi Suhu\nAmiruddin Fikri Nur 2031710163"),
          ),
          body: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Input(temperaturController: temperaturController),
                Column(
                  children: [
                    DropdownButton<String>(
                      items: listItem.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _newValue,
                      onChanged: (String? changeValue) {
                        setState(() {
                          _newValue = changeValue!;
                        });
                        convert();
                      },
                    ),
                    Result(result: _result)
                  ],
                ),
                MaterialButton(
                  onPressed: () {
                    convert();
                  },
                  child: const Text(
                    "Konversi",
                    style: TextStyle(fontSize: 24),
                  ),
                  color: Colors.amber,
                  textColor: Colors.white,
                  minWidth: double.maxFinite,
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "Riwayat Konversi",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                    child: Column(
                        children: listViewItem.map((String value) {
                  return Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 15),
                      ));
                }).toList()))
              ],
            ),
          ),
        ));
  }

  void convert() {
    setState(() {
      _inputUser = double.parse(temperaturController.text);

      if (_newValue == "Kelvin") {
        _result = _inputUser + 273.15;
      } else if (_newValue == "Reamur") {
        _result = 0.8 * _inputUser;
      } else {
        _result = (_inputUser * 1.8) + 32;
      }
      listViewItem.add(_newValue + ": " + _result.toStringAsFixed(2));
    });
  }
}

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.temperaturController,
  }) : super(key: key);

  final TextEditingController temperaturController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: temperaturController,
      decoration:
          const InputDecoration(labelText: 'Masukkan Suhu Dalam Celcius'),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
    );
  }
}
