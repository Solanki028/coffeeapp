import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: SingleChildScrollView(
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _controller.value,
                child: Transform.scale(
                  scale: _controller.value,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 420, // Adjust height as needed
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(_controller.isCompleted ? 10.0 : 0.0),
            child: Text(
              "CAFFEINATED",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 45,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          ScaleTransition(
            scale: _animation,
            child: GestureDetector(
              onTap: (() {
                print("Navigating to Menu");
                Navigator.of(context).pushNamed("/menu");
              }),
              child: Container(
                height: 60,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.brown,
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
