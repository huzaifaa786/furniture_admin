import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoPage extends StatefulWidget {
  final String? url;

  const FullPhotoPage({super.key, required this.url});

  @override
  State<FullPhotoPage> createState() => _FullPhotoPageState();
}

class _FullPhotoPageState extends State<FullPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Full photo',
        ),
        centerTitle: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.url!),
      ),
    );
  }
}
