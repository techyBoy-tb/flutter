import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  final Future<bool> initialValue;
  final ValueSetter<bool> onPress;

  const Heart({super.key, required this.initialValue, required this.onPress});

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

    asyncVars();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _curve = CurvedAnimation(parent: _controller!, curve: Curves.slowMiddle);

    _colorAnimation =
        ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve!);
    _sizeAnimation = TweenSequence([
      // The weights here should all add up to 100
      // It is the percentage of time it should focus on the Tween
      TweenSequenceItem(tween: Tween(begin: 30.0, end: 50.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 50.0, end: 30.0), weight: 50)
    ]).animate(_curve!);

    _controller!.addStatusListener((status) {
      bool statusCompleted = status == AnimationStatus.completed;
      setState(() {
        _isLiked = statusCompleted;
      });
      widget.onPress(statusCompleted);
    });
  }

  void asyncVars() async {
    var initialVal = await widget.initialValue;
    if (initialVal) {
      _controller!.forward();
    }
    setState(() {
      _isLiked = initialVal;
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
            _isLiked ? Icons.favorite : Icons.favorite_outline,
            color: _colorAnimation!.value,
            size: _sizeAnimation!.value,
          ),
          onPressed: () {
            print('_isliked $_isLiked');
            // This is good for when functionality is not used and just animation
            // _controller!.isCompleted ? _controller!.reverse() : _controller!.forward();
            // setState(() {
            _isLiked ? _controller!.reverse() : _controller!.forward();
            //   _isLiked = !_isLiked;
            // });
            // This is what should be used when using button for actual functional changes
          },
        );
      },
    );
  }
}
