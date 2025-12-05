import 'package:flutter/material.dart';
import 'package:openmeteo_app/pag/background.dart';
import 'package:openmeteo_app/api/openmeteo_service.dart';

class Previsaosemanal extends StatelessWidget {
  final String cidade;

  const Previsaosemanal({super.key, required this.cidade});

  // Emojis do clima
  String emoji(int code) {
    if (code == 0) return "☀️";
    if (code == 1 || code == 2) return "🌤️";
    if (code == 3) return "☁️";
    if (code >= 45 && code <= 48) return "🌫️";
    if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) return "🌧️";
    if ((code >= 71 && code <= 77) || (code >= 85 && code <= 86)) return "❄️";
    if (code >= 95) return "⛈️";
    return "☀️";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBG(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: FutureBuilder( //se constrói usando os dados mais recentes do builder
                future: OpenMeteoService().buscarSemana(cidade),

                builder: (context, snapshot) {
                  if (!snapshot.hasData) { // se há o resultado do future (buscarSemana(cidade)) ele irá retornar os dados abaixo
                    return const Center(child: CircularProgressIndicator());
                  }

                  final dados = snapshot.data as Map<String, dynamic>;

                  final datas = dados['datas'];
                  final max = dados['max'];
                  final min = dados['min'];
                  final codigos = dados['codigo'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back,
                                color: Color.fromARGB(255, 78, 73, 73)),
                            SizedBox(width: 5),
                            Text(
                              "VOLTAR",
                              style: TextStyle(
                                color: Color.fromARGB(255, 78, 73, 73),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Previsão de 7 dias para $cidade",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 78, 73, 73),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: ListView.builder(
                          itemCount: datas.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7E8970),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    datas[i],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    emoji(codigos[i]),
                                    style: const TextStyle(fontSize: 26),
                                  ),

                                  Text(
                                    "${min[i].toStringAsFixed(1)}° / ${max[i].toStringAsFixed(1)}°",
                                    style:
                                        const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
