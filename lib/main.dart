import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valor em bitolas(mm2)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  double distancia = 0.0;
  double corrente = 0.0;
  String? resultado;
  double bitola110 = 0.0;
  double bitola220 = 0.0;

  void calcular() {
    bitola110 = (2 * corrente * distancia) / 294.64;
    bitola220 = (2 * corrente * distancia) / 510.4;
    resultado =
        'a bitola recomendada para tensao 127V é: ${bitola110.toStringAsFixed(2)} \nO bitola recomendada para tensao 220V é:  ${bitola220.toStringAsFixed(2)}';
  }

  void alert(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text("mensagens"),
          content: Text(msg),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Valor em bitolas(mm2)"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Eletrica residencial cabos de cobre",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20),

                Text("Distancia em metros:", style: TextStyle(fontSize: 16.0)),

                SizedBox(height: 8),

                TextField(
                  decoration: InputDecoration(
                    labelText: "Digite a distancia",
                    prefixIcon: Icon(Icons.straighten),
                  ),
                  onChanged: (value) {
                    distancia = double.tryParse(value) ?? 0.0;
                  },
                ),

                SizedBox(height: 20),

                Text("Corrente:", style: TextStyle(fontSize: 16.0)),

                SizedBox(height: 8),

                TextField(
                  decoration: InputDecoration(
                    labelText: "Digite a distancia em amperes",
                    prefixIcon: Icon(Icons.flash_on),
                  ),
                  onChanged: (value) {
                    corrente = double.tryParse(value) ?? 0.0;
                  },
                ),

                SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      calcular();
                      alert(context, "$resultado");
                    },
                    child: Text("Calcular"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
