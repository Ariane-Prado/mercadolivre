import 'package:flutter/material.dart';

class ProductModel {
  final String urlImagem;
  final String titulo;
  final String preco;
  final String? precoAntigo;
  final String? desconto;
  final bool temVideo;
  final String? visualizacoesVideo;
  final bool eOfertaRelampago;

  const ProductModel({
    required this.urlImagem,
    required this.titulo,
    required this.preco,
    this.precoAntigo,
    this.desconto,
    this.temVideo = false,
    this.visualizacoesVideo,
    this.eOfertaRelampago = false,
  });
}

class NavItemModel {
  final IconData icone;
  final IconData iconeAtivo;
  final String rotulo;

  const NavItemModel({
    required this.icone,
    required this.iconeAtivo,
    required this.rotulo,
  });
}

class QuickItemModel {
  final IconData icone;
  final String rotulo;
  final String? emblema;
  final Color? corEmblema;
  final Color fundoIcone;
  final Color corIcone;

  const QuickItemModel({
    required this.icone,
    required this.rotulo,
    required this.emblema,
    required this.corEmblema,
    required this.fundoIcone,
    required this.corIcone,
  });
}
