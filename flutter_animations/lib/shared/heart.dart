import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _colorAnimation;
  Animation? _sizeAnimation;
  Animation<double>? _curve;

  bool _isLiked = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _curve = CurvedAnimation(parent: _controller!, curve: Curves.slowMiddle);

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve!);
    _sizeAnimation = TweenSequence([
      // The weights here should all add up to 100
      // It is the percentage of time it should focus on the Tween
      TweenSequenceItem(tween: Tween(begin: 30.0, end:50.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 50.0, end:30.0), weight: 50)
    ]).animate(_curve!);
    _controller!.addStatusListener((status) {
      setState(() {
        _isLiked = status == AnimationStatus.completed;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation!.value,
            size: _sizeAnimation!.value,
          ),
          onPressed: () {
            // This is good for when functionality is not used and just animation
            // _controller!.isCompleted ? _controller!.reverse() : _controller!.forward();

            // This is what should be used when using button for actual functional changes
            _isLiked ? _controller!.reverse() : _controller!.forward();
          },
        );
      },
    );
  }
}