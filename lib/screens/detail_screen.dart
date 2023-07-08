import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String id, thumb;
  const DetailScreen({
    Key? key,
    required this.id,
    required this.thumb,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String heroTag;

  @override
  void initState() {
    super.initState();
    heroTag = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: heroTag,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${widget.thumb}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (ModalRoute.of(context)?.canPop ?? false)
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                    ),
                    const Text(
                      'Back to list',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
