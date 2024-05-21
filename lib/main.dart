import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Led',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ColorPickerScreen(),
    );
  }
}

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  final _controller = CircleColorPickerController(
    initialColor: Colors.blue,
  );

  Color selectedColor =
      Colors.blue; // Variable de estado para almacenar el color seleccionado
  double redValue = 0.0;
  double greenValue = 0.0;
  double blueValue = 255.0;

  void connectToDevice() {
    // Implementa la lógica de conexión Bluetooth aquí
    // Escanea los dispositivos disponibles y conecta al deseado
    // Configura las características para la comunicación
  }

  void sendColorToArduino(Color color) {
    // Convierte el color a valores RGB
    // int red = color.red;
    // int green = color.green;
    // int blue = color.blue;

    // Envía los valores RGB al Arduino mediante Bluetooth
    // Implementa tu protocolo de comunicación específico
  }

  void updateSelectedColor() {
    _controller.color = Color.fromARGB(
        255, redValue.toInt(), greenValue.toInt(), blueValue.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8667F2),
        title: const Text(
          'Ledcito',
          style: TextStyle(
            color: const Color(0xFFEDE7FF),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                // Lógica para el botón del icono del foco
              },
              icon: const Icon(Icons.lightbulb_outline_sharp),
              color: selectedColor,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFEDE7FF), // Color inicial
              const Color(0xFF8667F2), // Color final
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal:
                        30.0), // Modifica los valores de los márgenes vertical y horizontal según tus necesidades
                padding: const EdgeInsets.all(
                    20.0), // Modifica el valor del padding según tus necesidades
                decoration: BoxDecoration(
                  color: selectedColor, // Utiliza el color seleccionado
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'Selecciona un color',
                  style: TextStyle(
                    color: Colors.black, // Color del texto
                    fontSize: 16.0, // Tamaño de la fuente
                    fontWeight: FontWeight.bold, // Peso de la fuente
                    fontFamily: 'Arial', // Tipo de fuente
                  ),
                ),
              ),
              CircleColorPicker(
                controller: _controller,
                onChanged: (color) {
                  setState(() {
                    selectedColor = color; // Actualiza el color seleccionado
                    redValue = color.red.toDouble();
                    greenValue = color.green.toDouble();
                    blueValue = color.blue.toDouble();
                    updateSelectedColor();
                  });
                },
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 30.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7FF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ColorSlider(
                      label: Text(
                        'Red',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: redValue,
                      onChanged: (value) {
                        setState(() {
                          redValue = value;
                          updateSelectedColor();
                        });
                      },
                      activeColor: const Color(0xFF8667F2),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 30.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7FF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ColorSlider(
                      label: Text(
                        'Green',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: greenValue,
                      onChanged: (value) {
                        setState(() {
                          greenValue = value;
                          updateSelectedColor();
                        });
                      },
                      activeColor: const Color(0xFF8667F2),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 30.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7FF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ColorSlider(
                      label: Text(
                        'Blue',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: blueValue,
                      onChanged: (value) {
                        setState(() {
                          blueValue = value;
                          updateSelectedColor();
                        });
                      },
                      activeColor: const Color(0xFF8667F2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  connectToDevice();
                  sendColorToArduino(selectedColor);
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      selectedColor, // Cambia el color de fondo del botón al color seleccionado
                ),
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorSlider extends StatelessWidget {
  final Widget label;
  final double value;
  final ValueChanged<double> onChanged;
  final Color activeColor;

  const ColorSlider({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        label,
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0,
          max: 255,
          divisions: 255,
          activeColor: activeColor,
        ),
      ],
    );
  }
}
