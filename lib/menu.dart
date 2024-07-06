import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> coffeeTitle = [
      "Espresso",
      "Cappuccino",
      "Mocha",
      "Latte",
      "Macchiato"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MENU",
          style: TextStyle(
            color: Colors.brown,
            fontSize: 40,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.brown[50],
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ScaleTransition(
              scale: _animation,
              child: Icon(
                Icons.search,
                color: Colors.brown,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
      body: SingleChildScrollView(
        child: content(context, coffeeTitle),
      ),
    );
  }

  Widget content(BuildContext context, List<String> coffeeTitle) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text.rich(
              TextSpan(
                text: "It's Great ",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.brown[900],
                ),
                children: [
                  TextSpan(
                    text: "Day for Coffee.",
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ListView.builder(
          itemCount: coffeeTitle.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ScaleTransition(
              scale: _animation,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  leading: FadeTransition(
                    opacity: _animation,
                    child: Image.asset('assets/coffee_cup.png'),
                  ),
                  title: Text(
                    coffeeTitle[index],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      print("Navigating to Details for ${coffeeTitle[index]}");
                      Navigator.of(context).pushNamed('/details');
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
