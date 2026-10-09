import 'package:flutter/material.dart';

/// Task 8: Grid Displays (GridView.count).
class GridGalleryScreen extends StatelessWidget {
  const GridGalleryScreen({super.key});

  static final List<String> _images = List<String>.generate(
    6,
    (i) => 'assets/images/gallery_${i + 1}.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 8: Gallery')),
      // Exercise 8.1: 2-column gallery with cross-axis spacing.
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: const EdgeInsets.all(12),
        children: [
          for (final (index, path) in _images.indexed)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: path,
                    child: Image.asset(path, fit: BoxFit.cover),
                  ),
                  // Exercise 8.2: InkWell opens a full-screen preview on tap.
                  // Placed above the image so the ripple stays visible.
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => FullScreenImage(
                            imagePath: path,
                            title: 'Photo ${index + 1}',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;
  final String title;

  const FullScreenImage({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Hero(
              tag: imagePath,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
