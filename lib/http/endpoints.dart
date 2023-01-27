const url = 'https://newsapi.org/v2/';
const key = 'apiKey=58faf35958014ff2bd26a3c185b57585';

class Endpoints {
  String everything(int page) => '$url/everything?q=apple&page=$page&pageSize=15&$key';

  String get headlines => '$url/top-headlines?q=apple&$key';
}
