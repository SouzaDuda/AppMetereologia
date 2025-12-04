import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenMeteoService {
  Future<Map<String, dynamic>> buscarPrevisao(String cidade) async {
    // Pegar as coordenadas do local (usando API de geocodificação)
    final geoUrl = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$cidade',
    );
    final geoResponse = await http.get(geoUrl);

    if (geoResponse.statusCode != 200) {
      throw Exception('Erro ao buscar coordenadas');
    }

    final geoData = json.decode(geoResponse.body);
    if (geoData['results'] == null || geoData['results'].isEmpty) {
      throw Exception('Cidade não encontrada');
    }

    final latitude = geoData['results'][0]['latitude'];
    final longitude = geoData['results'][0]['longitude'];

    //  2. Buscar previsão do tempo com base nas coordenadas
    final weatherUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true',
    );
    final weatherResponse = await http.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Erro ao buscar previsão');
    }

    final weatherData = json.decode(weatherResponse.body);
    final current = weatherData['current_weather'];

    //  3. Retornar os dados principais em formato de mapa
    return {
      'temperatura': current['temperature'],
      'vento': current['windspeed'],
      'latitude': latitude,
      'longitude': longitude,
      'clima': current['weathercode'],
    };
  }
}
