import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({ super.key });

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {

  double _opacity = 1;
  double _margin = 0;
  double _width = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.all(_margin),
        width: _width,
        color: _color,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(onPressed: () {
                setState(() {
                  _margin = 50;
                });
              }, child:
                const Text('Animate margin',
                    style: TextStyle(
                    color: Colors.black,
                  )
                )
              ),
              OutlinedButton(onPressed: () {
                setState(() {
                  _color = Colors.purple;
                });
              }, child:
              const Text('Animate color',
                  style: TextStyle(
                      color: Colors.black,
                  )
              )
              ),
              OutlinedButton(onPressed: () {
                setState(() {
                  _width = 300;
                });
              }, child:
              const Text('Animate width',
                  style: TextStyle(
                      color: Colors.black,
                  )
              )
              ),
              OutlinedButton(onPressed: () {
                setState(() {
                  _opacity= 0;
                });
              }, child:
              const Text('Animate opacity',
                  style: TextStyle(
                    color: Colors.black,
                  )
              )
              ),
              AnimatedOpacity(opacity: _opacity, duration: const Duration(seconds:2), child: const Text('Hide me', style: TextStyle(
                fontSize: 22,
                color: Colors.red
              )),)
            ]
          ),
        ),
      ),
    );
  }
}
