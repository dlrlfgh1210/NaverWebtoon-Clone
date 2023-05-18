import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String title, author, img, url;
  final int webtoonId;

  const DetailScreen({
    Key? key,
    required this.title,
    required this.author,
    required this.img,
    required this.webtoonId,
    required this.url,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(widget.img),
    );
  }
}
