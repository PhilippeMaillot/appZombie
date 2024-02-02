import 'package:applizombie/pages/api.dart';
import 'package:applizombie/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int currentIndex = 0;
  List<String> images = [
    'zombi-1.png',
    'zombi-2.png',
    'zombi-3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ZombieHub',
            style: GoogleFonts.creepster(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.black,
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0) {
              _swipeLeft();
            } else if (details.primaryVelocity! < 0) {
              _swipeRight();
            }
          },
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Image.asset(
                images[currentIndex],
                key: Key(images[currentIndex]),
                fit: BoxFit.cover,
                height: 300,
                width: 300,
              ),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(2.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  SignupPage()));
              },
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'zombi-rock.png',
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  TournoiPage()));
              },
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'zombi-like.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _swipeLeft() {
    setState(() {
      currentIndex = (currentIndex - 1) % images.length;
    });
  }

  void _swipeRight() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
    });
  }
}
