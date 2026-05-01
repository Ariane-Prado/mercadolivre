import 'dart:math';
import 'package:mobx/mobx.dart';
import '../repositorio/dados_inicio.dart';
import 'modelos.dart';
part 'armazem_produtos.g.dart';

class ArmazemProdutos = ArmazemProdutosBase with _$ArmazemProdutos;

abstract class ArmazemProdutosBase with Store {
  final _random = Random();

  @observable
  List<ProductModel> produtos = HomeMockData.produtos;

  @observable
  ProductModel ofertaDestaque = const ProductModel(
    urlImagem: 'https://picsum.photos/seed/crossbag789/300/300',
    titulo: 'Bolsa Tiracolo Feminina Em C...',
    preco: 'R\$ 57,66',
    precoAntigo: 'R\$ 131',
    desconto: '56% OFF',
  );

  @action
  void trocarProdutos() {
    List<ProductModel> novos = [];

    for (int i = 0; i < HomeMockData.produtos.length; i++) {
      int seed = _random.nextInt(9999);
      int nomeIndex = _random.nextInt(_nomes.length);
      int precoIndex = _random.nextInt(_precos.length);

      novos.add(ProductModel(
        urlImagem: 'https://picsum.photos/seed/$seed/300/300',
        titulo: _nomes[nomeIndex],
        preco: _precos[precoIndex],
      ));
    }

    produtos = novos;

    ofertaDestaque = ProductModel(
      urlImagem: 'https://picsum.photos/seed/${_random.nextInt(9999)}/300/300',
      titulo: _nomes[_random.nextInt(_nomes.length)],
      preco: _precos[_random.nextInt(_precos.length)],
    );
  }

  static const List<String> _nomes = [
    'Smartphone Samsung Galaxy A55',
    'Notebook Dell Inspiron i5 16GB',
    'Fone Bluetooth JBL Tune 510BT',
    'Cadeira Gamer RGB Premium',
    'Aspirador Robô 2800 Pa Wi-Fi',
    'Tênis Nike Air Max 2024',
    'Smart TV 50" 4K OLED LG',
    'Cafeteira Expresso Automática',
    'Tablet Samsung Galaxy Tab A9',
    'Air Fryer Digital 5.5L Mondial',
    'Bicicleta Mountain Bike 21v',
    'Smartwatch Xiaomi Watch 4',
    'Câmera GoPro Hero 12 Black',
    'Impressora HP LaserJet Pro',
    'Mochila Masculina Impermeável',
    'Par Pneus Moto 90/90-18',
    'Cadeira de Escritório Ergonômica',
    'Monitor Gamer 27" 165Hz',
    'Teclado Mecânico RGB Redragon',
    'Mouse Sem Fio Logitech MX',
  ];

  static const List<String> _precos = [
    'R\$ 89,90',
    'R\$ 149,99',
    'R\$ 249,00',
    'R\$ 399,90',
    'R\$ 599,99',
    'R\$ 799,00',
    'R\$ 1.199,00',
    'R\$ 1.799,00',
    'R\$ 2.499,90',
    'R\$ 3.299,00',
  ];
}
