import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String thumb, id;

  const DetailScreen({
    Key? key,
    required this.thumb,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(widget.thumb),
    );
  }
}
