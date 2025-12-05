import 'package:flutter/material.dart';
import 'pag/background.dart';
import 'pag/previsaosemanal.dart';
import 'pag/creditos.dart';
import 'api/openmeteo_service.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cidadeController = TextEditingController();

  double? temperatura;
  double? vento;
  double? latitude;
  double? longitude;
  int? clima; // Weathercode

  bool carregando = false;

  Future<void> buscarDados() async {
    final cidade = _cidadeController.text.trim();
    if (cidade.isEmpty) return;

    setState(() {
      carregando = true; // a bolinha vai aparecer e rodar
    });

    try {
      final dados = await OpenMeteoService().buscarPrevisao(cidade);

      setState(() {
        temperatura = dados['temperatura'];
        vento = dados['vento'];
        latitude = dados['latitude'];
        longitude = dados['longitude'];
        clima = dados['clima']/*?.toInt()*/; 
      });
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  // Retorna emoji baseado no weathercode
  String emojiClima(int? clima) {
    if (clima == null) return "☀️";
    if (clima == 0) return "☀️";
    if (clima == 1 || clima == 2) return "🌤️";
    if (clima == 3) return "☁️";
    if (clima >= 45 && clima <= 48) return "🌫️";
    if ((clima >= 51 && clima <= 67) || (clima >= 80 && clima <= 82)) return "🌧️";
    if ((clima >= 71 && clima <= 77) || (clima >= 85 && clima <= 86)) return "❄️";
    if (clima >= 95) return "⛈️";
    return "☀️";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBG(), //fundo do app
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _cidadeController,
                    decoration: InputDecoration(
                      hintText: "Insira a cidade...",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onSubmitted: (_) => buscarDados(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Cidade",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: carregando // bolinha para carregar
                        ? const CircularProgressIndicator()
                        : Text(
                            emojiClima(clima),
                            style: const TextStyle(fontSize: 60),
                          ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7E8970),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      final cidade = _cidadeController.text.trim();
                      if (cidade.isEmpty) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Previsaosemanal(cidade: cidade),
                        ),
                      );
                    },

                    child: const Text("Ver previsão completa da semana"),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      info("Temperatura: ${temperatura?.toStringAsFixed(1) ?? '--'} °C"),
                      info("Vento: ${vento?.toStringAsFixed(1) ?? '--'} km/h"),
                      info("Latitude: ${latitude ?? '--'}"),
                      info("Longitude: ${longitude ?? '--'}"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7E8970),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Creditos(),
                        ),
                      );
                    },
                    child: const Text("Página de créditos sobre API"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget info(String label) {
    return Container(
      width: 130,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF7E8970),
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
