import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class OpenMeteoService {
  Future<Map<String, dynamic>> buscarPrevisao(String cidade) async {
    // --> 1. pega as coordenadas do local (usando API de geocodificação / lat e long)
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

<<<<<<< HEAD
    // --> 2. busca a previsão com base nas coordenadas
=======
    //  2. Buscar previsão do tempo com base nas coordenadas
>>>>>>> 7c4086b59f56e409daf1a64b7f3816a4225443b0
    final weatherUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true',
    );
    final weatherResponse = await http.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Erro ao buscar previsão');
    }

    final weatherData = json.decode(weatherResponse.body);
    final current = weatherData['current_weather'];

<<<<<<< HEAD
    // --> 3. devolve os dados abaixo como se fosse um mapa (em formato de mapa)
=======
    //  3. Retornar os dados principais em formato de mapa
>>>>>>> 7c4086b59f56e409daf1a64b7f3816a4225443b0
    return {
      'temperatura': current['temperature'],
      'vento': current['windspeed'],
      'latitude': latitude,
      'longitude': longitude,
      'clima': current['weathercode'],
    };
  } 
  
// -------------------------------------------------------------------------------------------------
  
  // --> Previsão Semanal
  Future<Map<String, dynamic>> buscarSemana(String cidade) async {
    // --> 1. pega o lat e long da cidade
    final dadosCidade = await buscarPrevisao(cidade);

    final latitude = dadosCidade['latitude'];
    final longitude = dadosCidade['longitude'];

    // --> 2. pedido da previsão semanal
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?'
      'latitude=$latitude&longitude=$longitude'
      '&daily=temperature_2m_max,temperature_2m_min,weathercode'
      '&timezone=auto',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar previsão semanal");
    }

    final data = json.decode(response.body);


    /* foi criada uma lista do tipo string para formatar as datas, ela pega os dados da lista da data e para cada item (D)
     da lista ele retorna o valor como string. E na data final ele converte esses valores string (da API) em datetime, 
     assim retorna uma nova string da data formatada
    */
    List<String> datasFormatadas = List<String>.from(
      data['daily']['time'].map<String>((d) {
        final date = DateTime.parse(d);
        return DateFormat('dd/MM/yyyy').format(date);
      }),
    );


    // --> 3. devolve os dados organizados
    return {
      'max': List<double>.from(data['daily']['temperature_2m_max']),
      'min': List<double>.from(data['daily']['temperature_2m_min']),
      'codigo': List<int>.from(data['daily']['weathercode']),
      'datas': datasFormatadas
      //'datas': List<String>.from(data['daily']['time']),
    };
  }

}