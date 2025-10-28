class ApiInfo {
  final String nome;
  final String urlDocumentacao;
  final String urlAcesso;
  final String autenticacao;
  final List<String> metodos;
  final Map<String, String> atributos;
  final Map<String, String> dadosRetornados;

  ApiInfo({
    required this.nome,
    required this.urlDocumentacao,
    required this.urlAcesso,
    required this.autenticacao,
    required this.metodos,
    required this.atributos,
    required this.dadosRetornados,
  });
}

// Objeto com os dados da Open-Meteo
final openMeteoInfo = ApiInfo(
  nome: "Open-Meteo",
  urlDocumentacao: "https://open-meteo.com/en/docs",
  urlAcesso: "https://api.open-meteo.com/v1/forecast",
  autenticacao: "Não requer autenticação (API gratuita e aberta)",
  metodos: [
    "GET /forecast — retorna dados de previsão do tempo com base na latitude e longitude."
  ],
  atributos: {
    "latitude": "Coordenada geográfica norte-sul (double)",
    "longitude": "Coordenada geográfica leste-oeste (double)",
    "current_weather": "Define se os dados atuais para serem retornados (bool)",
  },
  dadosRetornados: {
    "temperature": "Temperatura atual em graus Celsius (double)",
    "windspeed": "Velocidade do vento em km/h (double)",
  },
);
