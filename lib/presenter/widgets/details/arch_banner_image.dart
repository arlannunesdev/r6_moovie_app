import 'package:flutter/cupertino.dart';

class ArcBannerImage extends StatelessWidget {
  final String imageUrl;

  const ArcBannerImage(this.imageUrl, {super.key, required double height});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: MediaQuery.of(context).size.width,
      height: 230.0,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
      return const Text('Falha ao carregar a imagem');
    },
    );
  }
}