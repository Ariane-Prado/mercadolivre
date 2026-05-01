import 'package:flutter/material.dart';
import '../../cores_app.dart';
import '../entidade/modelos.dart';

class HomeMockData {
  static const List<String> categorias = [
    'Tudo',
    'Moda',
    'Beleza',
    'Celulares',
    'Veículos',
    'Lar',
    'Computação',
  ];

  static const List<QuickItemModel> itensRapidos = [
    QuickItemModel(
      icone: Icons.credit_card,
      rotulo: 'Pedir\nCartão',
      emblema: 'GRÁTIS',
      corEmblema: AppColors.green,
      fundoIcone: AppColors.charcoal,
      corIcone: Colors.white,
    ),
    QuickItemModel(
      icone: Icons.percent,
      rotulo: 'Ofertas',
      emblema: 'GANHE \$',
      corEmblema: AppColors.green,
      fundoIcone: AppColors.yellow,
      corIcone: Colors.black,
    ),
    QuickItemModel(
      icone: Icons.link,
      rotulo: 'Afiliados',
      emblema: 'GRÁTIS',
      corEmblema: AppColors.green,
      fundoIcone: Color(0xFFB0B0B0),
      corIcone: Colors.white,
    ),
    QuickItemModel(
      icone: Icons.local_movies_outlined,
      rotulo: 'Mercado\nPlay',
      emblema: 'GRÁTIS',
      corEmblema: AppColors.green,
      fundoIcone: Color(0xFFFFE4B5),
      corIcone: Colors.deepOrange,
    ),
    QuickItemModel(
      icone: Icons.confirmation_num_outlined,
      rotulo: 'Cupons',
      emblema: null,
      corEmblema: null,
      fundoIcone: Color(0xFFE3F2FD),
      corIcone: Color(0xFF1565C0),
    ),
    QuickItemModel(
      icone: Icons.directions_car_outlined,
      rotulo: 'Carros',
      emblema: 'CRED',
      corEmblema: AppColors.green,
      fundoIcone: AppColors.lightGrey,
      corIcone: Colors.black87,
    ),
  ];

  static const List<ProductModel> produtos = [
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/mototire/300/300',
      titulo: 'Par Pneus Moto 90/90-18',
      preco: 'R\$ 249,90',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/vacuumcleaner/300/300',
      titulo: 'Aspirador Profissional 1400W',
      preco: 'R\$ 189,99',
      precoAntigo: 'R\$ 299,99',
      desconto: '37% OFF',
      temVideo: true,
      visualizacoesVideo: '2.3 mil',
      eOfertaRelampago: true,
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/smartphone55/300/300',
      titulo: 'Smartphone Samsung Galaxy A55',
      preco: 'R\$ 1.799,00',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/gamingchair/300/300',
      titulo: 'Cadeira Gamer Premium RGB',
      preco: 'R\$ 899,00',
      precoAntigo: 'R\$ 1.299,00',
      desconto: '30% OFF',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/headphones22/300/300',
      titulo: 'Fone Bluetooth JBL Tune 510BT',
      preco: 'R\$ 249,99',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/laptop2024/300/300',
      titulo: 'Notebook Dell Inspiron i5 16GB',
      preco: 'R\$ 3.299,00',
      precoAntigo: 'R\$ 4.199,00',
      desconto: '21% OFF',
    ),
  ];

  static const List<ProductModel> produtosAlternativos = [
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/tenis2024/300/300',
      titulo: 'Tênis Nike Air Max 2024',
      preco: 'R\$ 599,90',
      precoAntigo: 'R\$ 799,90',
      desconto: '25% OFF',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/cafeteira99/300/300',
      titulo: 'Cafeteira Expresso Automática',
      preco: 'R\$ 1.249,00',
      eOfertaRelampago: true,
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/bicicleta22/300/300',
      titulo: 'Bicicleta Mountain Bike 21v',
      preco: 'R\$ 879,00',
      precoAntigo: 'R\$ 1.100,00',
      desconto: '20% OFF',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/relogio2024/300/300',
      titulo: 'Smartwatch Xiaomi Watch 4',
      preco: 'R\$ 349,90',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/airfryer22/300/300',
      titulo: 'Air Fryer Digital 5.5L Mondial',
      preco: 'R\$ 299,00',
      precoAntigo: 'R\$ 459,00',
      desconto: '35% OFF',
      temVideo: true,
      visualizacoesVideo: '1.8 mil',
    ),
    ProductModel(
      urlImagem: 'https://picsum.photos/seed/tablet2024/300/300',
      titulo: 'Tablet Samsung Galaxy Tab A9',
      preco: 'R\$ 1.099,00',
    ),
  ];

  static const List<NavItemModel> itensNavegacao = [
    NavItemModel(
      icone: Icons.home_outlined,
      iconeAtivo: Icons.home,
      rotulo: 'Início',
    ),
    NavItemModel(
      icone: Icons.grid_view_outlined,
      iconeAtivo: Icons.grid_view,
      rotulo: 'Categorias',
    ),
    NavItemModel(
      icone: Icons.shopping_cart_outlined,
      iconeAtivo: Icons.shopping_cart,
      rotulo: 'Carrinho',
    ),
    NavItemModel(
      icone: Icons.play_circle_outline,
      iconeAtivo: Icons.play_circle,
      rotulo: 'Vídeos',
    ),
    NavItemModel(
      icone: Icons.menu,
      iconeAtivo: Icons.menu,
      rotulo: 'Mais',
    ),
  ];
}
