import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../cores_app.dart';
import '../../servico/entidade/armazem_carrossel.dart';
import '../../servico/entidade/armazem_navegacao.dart';
import '../../servico/entidade/armazem_ofertas_relampago.dart';
import '../../servico/entidade/armazem_produtos.dart';
import '../../servico/entidade/modelos.dart';
import '../../servico/repositorio/dados_inicio.dart';

class HomePage extends StatelessWidget {
  final ArmazemNavegacao _armazem = ArmazemNavegacao();
  final ArmazemProdutos _armazemProdutos = ArmazemProdutos();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Observer(
                      builder: (_) {
                        return CategoryTabs(
                          categorias: HomeMockData.categorias,
                          indiceSelecionado: _armazem.categoriaSelecionada,
                          aoSelecionarCategoria: (i) {
                            _armazem.selecionarCategoria(i);
                          },
                        );
                      },
                    ),
                    const BannerCarousel(),
                    const MeliPlusBar(),
                    const QuickAccessSection(),
                    const SizedBox(height: 8),
                    FlashDealsSection(armazemProdutos: _armazemProdutos),
                    const SizedBox(height: 8),
                    ProductGridSection(armazem: _armazemProdutos),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Observer(
              builder: (_) {
                return BottomNavBar(
                  itens: HomeMockData.itensNavegacao,
                  indiceSelecionado: _armazem.abaSelecionada,
                  aoSelecionarItem: (i) {
                    _armazem.selecionarAba(i);
                    if (i == 2) {
                      _armazemProdutos.trocarProdutos();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Cabeçalho

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.yellow,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.charcoal,
                child: Text(
                  'FP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Icon(Icons.search, color: Colors.grey[400], size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Buscar no Mercado Livre',
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ),
                      Icon(Icons.camera_alt_outlined, color: Colors.grey[600], size: 20),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.notifications_outlined, size: 26, color: Colors.black87),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: const Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: Colors.black87),
              SizedBox(width: 2),
              Text('Rua CL-01 00', style: TextStyle(fontSize: 12, color: Colors.black87)),
              Icon(Icons.chevron_right, size: 14, color: Colors.black87),
            ],
          ),
        ],
      ),
    );
  }
}

// Abas de categoria

class CategoryTabs extends StatelessWidget {
  final List<String> categorias;
  final int indiceSelecionado;
  final Function(int) aoSelecionarCategoria;

  const CategoryTabs({
    super.key,
    required this.categorias,
    required this.indiceSelecionado,
    required this.aoSelecionarCategoria,
  });

  List<Widget> _construirAbas() {
    List<Widget> abas = [];

    for (int i = 0; i < categorias.length; i++) {
      Color corDaBorda;
      FontWeight pesoDaFonte;

      if (i == indiceSelecionado) {
        corDaBorda = Colors.black;
        pesoDaFonte = FontWeight.bold;
      } else {
        corDaBorda = Colors.transparent;
        pesoDaFonte = FontWeight.normal;
      }

      Widget aba = GestureDetector(
        onTap: () => aoSelecionarCategoria(i),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: corDaBorda, width: 2),
            ),
          ),
          child: Text(
            categorias[i],
            style: TextStyle(
              fontSize: 13,
              fontWeight: pesoDaFonte,
              color: Colors.black87,
            ),
          ),
        ),
      );
      abas.add(aba);
    }

    return abas;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.yellow,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _construirAbas(),
        ),
      ),
    );
  }
}

// Carrossel de banners

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final ArmazemCarrossel _armazem = ArmazemCarrossel();
  late final PageController _controlador;
  late final Timer _temporizador;

  static const _totalBanners = 2;
  static const _intervaloRolagem = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _controlador = PageController();
    _temporizador = Timer.periodic(_intervaloRolagem, (_) {
      _armazem.irParaProximaPagina(_totalBanners);
      _controlador.animateToPage(
        _armazem.paginaAtual,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controlador.dispose();
    _temporizador.cancel();
    super.dispose();
  }

  Widget _banner1() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.darkPurple1, AppColors.darkPurple2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '5.5',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 44,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RENOVE A',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, height: 1.1),
                ),
                const Text(
                  'SUA CASA',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, height: 1.1),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'ATÉ\n70% OFF',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Colors.black, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 100,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Text(
                    'R\$579',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.white70,
                    ),
                  ),
                  Text('por', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  Text(
                    'R\$ 416',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 8,
            child: Icon(Icons.microwave_outlined, size: 64, color: Colors.white.withValues(alpha: 0.65)),
          ),
          Positioned(
            right: 4,
            bottom: 8,
            child: Icon(Icons.coffee_maker_outlined, size: 64, color: Colors.white.withValues(alpha: 0.65)),
          ),
        ],
      ),
    );
  }

  Widget _banner2() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.deepPurple1, AppColors.deepPurple2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '5.5',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 44,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DE R\$899',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white60,
                  ),
                ),
                const Text('POR', style: TextStyle(color: Colors.white70, fontSize: 11)),
                const Text(
                  'R\$ 467,48',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.1),
                ),
                const SizedBox(height: 4),
                const Text('ou R\$ 420,73', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_offer, size: 11, color: Colors.black),
                      SizedBox(width: 3),
                      Text(
                        'COM CUPOM',
                        style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            bottom: 6,
            child: Icon(Icons.coffee_maker, size: 90, color: Colors.white.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178,
      child: PageView(
        controller: _controlador,
        onPageChanged: (i) {
          _armazem.mudarPagina(i);
        },
        children: [_banner1(), _banner2()],
      ),
    );
  }
}

// Barra Meli Plus

class MeliPlusBar extends StatelessWidget {
  const MeliPlusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'meli+',
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          const Text('|', style: TextStyle(color: Colors.white38, fontSize: 16)),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Viva toda a experiência Mercado Livre',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}

// Acesso rápido

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({super.key});

  List<Widget> _construirItens() {
    List<Widget> itens = [];

    for (var item in HomeMockData.itensRapidos) {
      List<Widget> filhos = [];

      filhos.add(Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: item.fundoIcone,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(item.icone, size: 28, color: item.corIcone),
      ));

      if (item.emblema != null) {
        filhos.add(Positioned(
          top: -9,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: item.corEmblema,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.emblema!,
                style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
      }

      itens.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Stack(clipBehavior: Clip.none, children: filhos),
            const SizedBox(height: 7),
            Text(
              item.rotulo,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ));
    }

    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: _construirItens(),
        ),
      ),
    );
  }
}

// Ofertas relâmpago

class FlashDealsSection extends StatefulWidget {
  final ArmazemProdutos armazemProdutos;

  const FlashDealsSection({super.key, required this.armazemProdutos});

  @override
  State<FlashDealsSection> createState() => _FlashDealsSectionState();
}

class _FlashDealsSectionState extends State<FlashDealsSection> {
  final ArmazemOfertasRelampago _armazem = ArmazemOfertasRelampago();
  late final Timer _temporizador;

  @override
  void initState() {
    super.initState();
    _temporizador = Timer.periodic(const Duration(seconds: 1), (_) {
      _armazem.diminuirUmSegundo();
    });
  }

  @override
  void dispose() {
    _temporizador.cancel();
    super.dispose();
  }

  String _calcularTextoDoTempo(int totalDeSegundos) {
    int horas = totalDeSegundos ~/ 3600;
    int segundosRestantesDepoisDasHoras = totalDeSegundos % 3600;
    int minutos = segundosRestantesDepoisDasHoras ~/ 60;
    int segundosFinais = segundosRestantesDepoisDasHoras % 60;

    String textoHoras = horas.toString().padLeft(2, '0');
    String textoMinutos = minutos.toString().padLeft(2, '0');
    String textoSegundos = segundosFinais.toString().padLeft(2, '0');

    return '$textoHoras:$textoMinutos:$textoSegundos';
  }

  Widget _segmentoTempo(String valor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        valor,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    );
  }

  Widget _construirTemporizador(String texto) {
    List<String> partes = texto.split(':');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _segmentoTempo(partes[0]),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Text(':', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        _segmentoTempo(partes[1]),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Text(':', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        _segmentoTempo(partes[2]),
      ],
    );
  }

  Widget _ofertaPequena(String urlImagem, String precoAntigo, String preco, String centavos, String desconto) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              urlImagem,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: 60,
                  height: 60,
                  color: AppColors.lightGrey,
                  child: const Center(
                    child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                );
              },
              errorBuilder: (context, erro, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: AppColors.lightGrey,
                  child: const Icon(Icons.image_not_supported_outlined, size: 24, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  precoAntigo,
                  style: const TextStyle(fontSize: 10, color: Colors.grey, decoration: TextDecoration.lineThrough),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        preco,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        centavos,
                        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    desconto,
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                String textoTempo = _calcularTextoDoTempo(_armazem.segundos);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.dividerGrey),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: AppColors.yellow,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.bolt, color: Colors.black, size: 16),
                              const SizedBox(width: 2),
                              const Expanded(
                                child: Text(
                                  'OFERTAS RELÂMPAGO',
                                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 11, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              _construirTemporizador(textoTempo),
                            ],
                          ),
                        ),
                        _ofertaPequena('https://picsum.photos/seed/vacuum2024/80/80', 'R\$ 619,90', 'R\$ 349', '90', '43% OFF'),
                        const Divider(height: 1, thickness: 1, color: AppColors.subtleGrey),
                        _ofertaPequena('https://picsum.photos/seed/straw123/80/80', 'R\$ 78,90', 'R\$ 69', '65', '11% OFF'),
                        const Divider(height: 1, thickness: 1, color: AppColors.subtleGrey),
                        _ofertaPequena('https://picsum.photos/seed/wallet456/80/80', 'R\$ 29,99', 'R\$ 23', '46', '21% OFF'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Observer(
              builder: (_) {
                ProductModel produto = widget.armazemProdutos.ofertaDestaque;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              produto.urlImagem,
                              key: ValueKey(produto.urlImagem),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  color: AppColors.lightGrey,
                                  child: const Center(child: CircularProgressIndicator()),
                                );
                              },
                              errorBuilder: (context, erro, stackTrace) {
                                return Container(
                                  color: AppColors.lightGrey,
                                  child: const Icon(Icons.image_not_supported_outlined, size: 40, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: 8,
                            bottom: 8,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Color(0xFF9C27B0), Color(0xFFFF9800)]),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: const Center(
                                child: Text('2', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.12),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.add_shopping_cart, size: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      produto.titulo,
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            produto.desconto ?? '56% OFF',
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          produto.precoAntigo ?? 'R\$ 131',
                          style: const TextStyle(fontSize: 11, color: Colors.grey, decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      produto.preco,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.close, size: 10, color: Colors.red),
                        Text('Internacional', style: TextStyle(fontSize: 10, color: Colors.red)),
                        SizedBox(width: 4),
                        Text('China', style: TextStyle(fontSize: 10, color: Colors.black54)),
                        SizedBox(width: 4),
                        Icon(Icons.bolt, size: 12, color: AppColors.green),
                        Text('FULL', style: TextStyle(fontSize: 10, color: AppColors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Cartão de produto

class ProductCard extends StatelessWidget {
  final ProductModel produto;

  const ProductCard({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    List<Widget> camadas = [];

    camadas.add(ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      child: Image.network(
        produto.urlImagem,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: AppColors.lightGrey,
            child: const Center(
              child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          );
        },
        errorBuilder: (context, erro, stackTrace) {
          return Container(
            color: AppColors.lightGrey,
            child: const Icon(Icons.image_not_supported_outlined, size: 40, color: Colors.grey),
          );
        },
      ),
    ));

    if (produto.temVideo) {
      camadas.add(Positioned(
        left: 8,
        top: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
          child: Row(
            children: [
              const Icon(Icons.play_arrow, color: Colors.white, size: 11),
              const SizedBox(width: 2),
              Text(produto.visualizacoesVideo!, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ],
          ),
        ),
      ));
    }

    if (produto.desconto != null) {
      camadas.add(Positioned(
        right: 0,
        top: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: const BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomLeft: Radius.circular(6)),
          ),
          child: Text(
            produto.desconto!,
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ));
    }

    if (produto.eOfertaRelampago) {
      camadas.add(Positioned(
        left: 0,
        bottom: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: const BoxDecoration(
            color: AppColors.yellow,
            borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomLeft: Radius.circular(8)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bolt, size: 11, color: Colors.black),
              Text('OFERTA', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
        ),
      ));
    }

    List<Widget> informacoes = [];

    informacoes.add(Text(
      produto.titulo,
      style: const TextStyle(fontSize: 11, color: Colors.black87),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ));
    informacoes.add(const SizedBox(height: 4));

    if (produto.precoAntigo != null) {
      informacoes.add(Text(
        produto.precoAntigo!,
        style: const TextStyle(fontSize: 10, color: Colors.grey, decoration: TextDecoration.lineThrough),
      ));
    }

    informacoes.add(Text(
      produto.preco,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
    ));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.dividerGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Stack(children: camadas)),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: informacoes,
            ),
          ),
        ],
      ),
    );
  }
}

// Grade de produtos

class ProductGridSection extends StatelessWidget {
  final ArmazemProdutos armazem;

  const ProductGridSection({super.key, required this.armazem});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        List<Widget> cartoes = [];

        for (var produto in armazem.produtos) {
          cartoes.add(ProductCard(key: ValueKey(produto.urlImagem), produto: produto));
        }

        return Container(
          color: Colors.white,
          child: GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            children: cartoes,
          ),
        );
      },
    );
  }
}

// Barra de navegação inferior

class BottomNavBar extends StatelessWidget {
  final List<NavItemModel> itens;
  final int indiceSelecionado;
  final Function(int) aoSelecionarItem;

  const BottomNavBar({
    super.key,
    required this.itens,
    required this.indiceSelecionado,
    required this.aoSelecionarItem,
  });

  List<Widget> _construirItens() {
    List<Widget> itensDaNavegacao = [];

    for (int i = 0; i < itens.length; i++) {
      bool estaSelecionado = i == indiceSelecionado;
      Color cor;
      IconData iconeParaMostrar;

      if (estaSelecionado) {
        cor = AppColors.blue;
        iconeParaMostrar = itens[i].iconeAtivo;
      } else {
        cor = AppColors.navGrey;
        iconeParaMostrar = itens[i].icone;
      }

      itensDaNavegacao.add(GestureDetector(
        onTap: () => aoSelecionarItem(i),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconeParaMostrar, size: 26, color: cor),
            const SizedBox(height: 2),
            Text(itens[i].rotulo, style: TextStyle(fontSize: 10, color: cor)),
          ],
        ),
      ));
    }

    return itensDaNavegacao;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.dividerGrey)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _construirItens(),
      ),
    );
  }
}
