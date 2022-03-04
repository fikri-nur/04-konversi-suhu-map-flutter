import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final temperaturController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: temperaturController,
                  decoration: const InputDecoration(
                      labelText: 'Masukkan Suhu Dalam Celcius'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text("Suhu Dalam Kelvin"),
                        Text(
                          _kelvin.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Suhu Dalam Reamur"),
                        Text(
                          _reamur.toStringAsFixed(2),
                          style: const TextStyle(fontSize: 32),
                        ),
                      ],
                    )
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
              ],
            ),
          ),
        ));
  }

  void convert() {
    _inputUser = double.parse(temperaturController.text);
    setState(() {
      _kelvin = _inputUser + 273.15;
      _reamur = _inputUser * 0.8;
    });
  }
}
