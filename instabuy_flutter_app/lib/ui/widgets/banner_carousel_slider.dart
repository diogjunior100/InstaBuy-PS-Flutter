import 'dart:async';

import 'package:flutter/material.dart';

class BannerCarouselSlider extends StatefulWidget {
  final List<String> imageUrls;
  const BannerCarouselSlider({super.key, required this.imageUrls});

  @override
  State<BannerCarouselSlider> createState() => _BannerCarouselSliderState();
}

class _BannerCarouselSliderState extends State<BannerCarouselSlider> {
  int _current = 0;
  final PageController _controller = PageController(viewportFraction: 1);
  Timer? _timer;
  final Duration _autoScrollDuration = const Duration(seconds: 4);

  @override
  void dispose() {
    _stopAutoScroll();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.imageUrls.length > 1) _startAutoScroll();
  }

  void _startAutoScroll() {
    _stopAutoScroll();
    _timer = Timer.periodic(_autoScrollDuration, (timer) {
      final next = (_current + 1) % widget.imageUrls.length;
      if (!mounted) return;
      _controller.animateToPage(next,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 500,
          child: Listener(
            onPointerDown: (_) => _stopAutoScroll(),
            onPointerUp: (_) => _startAutoScroll(),
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) => setState(() => _current = index),
              itemBuilder: (context, index) {
                final url = widget.imageUrls[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: url.isNotEmpty
                        ? Image.network(
                            url,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            loadingBuilder: (ctx, child, progress) {
                              if (progress == null) return child;
                              return const Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (ctx, err, stack) =>
                                const Center(child: Icon(Icons.broken_image, size: 48)),
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.imageUrls.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _current == i ? 12 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _current == i ? Colors.blueAccent : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
