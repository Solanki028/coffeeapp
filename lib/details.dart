import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _appBarController;
  late Animation<double> _animation;
  late Animation<Offset> _appBarAnimation;
  late Animation<Offset> _slideAnimation;
  int quantity = 1;
  bool isSmallSelected = true;
  Offset _coffeeCupOffset = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _appBarController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );

    _appBarAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _appBarController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _appBarController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
  }

  void _selectContainer(bool isSmall) {
    setState(() {
      isSmallSelected = isSmall;
      _coffeeCupOffset = isSmall ? Offset(0.1, 0.0) : Offset(0.3, 0.0);
    });
    _appBarController.forward().then((value) => _appBarController.reverse());
  }

  void _onAnimatedTextTap() {
    setState(() {
      // Define actions to be performed on tap
    });

    _controller.reset();
    _controller.forward();
  }

  void _onSugarTap(String sugarLevel) {
    setState(() {
      // Handle sugar level tap
      print('Selected sugar level: $sugarLevel');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Latte",
          style: TextStyle(color: Colors.brown, fontSize: 30),
        ),
        backgroundColor: Colors.brown[50],
        toolbarHeight: 100,
        elevation: 0,
        actions: [
          Stack(
            children: [
              Positioned(
                right: 20.0 + _coffeeCupOffset.dx * 100.0,
                top: 50.0 + _coffeeCupOffset.dy * 100.0,
                child: Image.asset(
                  'assets/coffee_cup.png',
                  height: isSmallSelected ? 40 : 50,
                  width: isSmallSelected ? 40 : 50,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ScaleTransition(
            scale: _animation,
            child: Container(
              width: double.infinity,
              height: 200,
              color: Colors.brown[50],
              child: Image.asset('assets/coffee_cup.png'),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ScaleTransition(
                      scale: _animation,
                      child: Text(
                        "Latte",
                        style: TextStyle(fontSize: 20, color: Colors.brown),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        ScaleTransition(
                          scale: _animation,
                          child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: _decrementQuantity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ScaleTransition(
                            scale: _animation,
                            child: Text(
                              "$quantity",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ),
                        ScaleTransition(
                          scale: _animation,
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _incrementQuantity,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: _onAnimatedTextTap,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: AnimatedText("Sugar"),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _onSugarTap("0%"),
                      child: ScaleTransition(
                        scale: _animation,
                        child: Text(
                          "0%",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: () => _onSugarTap("25%"),
                      child: ScaleTransition(
                        scale: _animation,
                        child: Text(
                          "25%",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: () => _onSugarTap("50%"),
                      child: ScaleTransition(
                        scale: _animation,
                        child: Text(
                          "50%",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: () => _onSugarTap("100%"),
                      child: ScaleTransition(
                        scale: _animation,
                        child: Text(
                          "100%",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 130),
          ScaleTransition(
            scale: _animation,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed("/summary"),
              child: Column(
                children: [
                  submitButton("Add to cart"),
                  SizedBox(height: 10),
                  Text(
                    "Quantity: $quantity",
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  Widget submitButton(String text) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget AnimatedText(String text) {
    return ScaleTransition(
      scale: _animation,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.brown,
        ),
      ),
    );
  }
}
