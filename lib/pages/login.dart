import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwipePage extends StatefulWidget {
  SwipePage({Key? key}) : super(key: key);

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
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
        color: Colors.black, // Fond noir
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0) {
              // Swiped to the right
              _swipeLeft(); // Appelle la fonction de swipe vers la gauche
            } else if (details.primaryVelocity! < 0) {
              // Swiped to the left
              _swipeRight(); // Appelle la fonction de swipe vers la droite
            }
          },
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Image.asset(
                images[currentIndex],
                key: Key(
                    images[currentIndex]), // Key unique pour AnimatedSwitcher
                fit: BoxFit.cover,
                height: 300,
                width: 300,
              ),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(2.0, 1.0), // Position initiale de l'animation
                      end: Offset.zero, // Position finale de l'animation (centrée)
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
                // Action à effectuer lors du clic sur le bouton
                // Ajouter une animation de swipe (vers la gauche)
                _swipeLeft(); // Appelle la fonction de swipe vers la gauche
              },
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'zombi-rock.png',
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton
                // Ajouter une animation de swipe (vers la droite)
                _swipeRight(); // Appelle la fonction de swipe vers la droite
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
      currentIndex = (currentIndex - 1) % images.length; // Décrémente l'index pour passer à l'image précédente
    });
  }

  void _swipeRight() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length; // Incrémente l'index pour passer à l'image suivante
    });
  }
}
