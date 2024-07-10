import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder-Clone',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Tinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int topCardIndex = 0;
  List<Superhero> _cards = [
    Superhero(
      name: "Wonder Woman",
      description: "Looking for a partner who can handle my lasso of truth and still tell me I look amazing in my tiara. Must love ancient artifacts and have a soft spot for invisible jets. Bonus points if you're an Amazonian demigod or have experience fighting supervillains.",
      age: 3000,
      tags: ["Warrior", "Compassionate", "Lasso of Truth", "Amazonian"],
      role: "Justice League member",
      imageLink: "assets/images/wonder-woman.jpg"
    ),
    Superhero(
      name: "Jane Foster",
      description: "Seeking someone who won't be intimidated by my cosmic thunderstorms. Must appreciate a good hammer and be willing to join me in epic battles against frost giants. If you can handle interdimensional travel and have a PhD in astrophysics, let's create some sparks!",
      age: 35,
      tags: ["Scientist", "Thunder Goddess", "Noble", "Protector"],
      role: "Asgardian hero",
      imageLink: "assets/images/jane-foster.jpeg"
    ),
    Superhero(
      name: "Captain Marvel",
      description: "In search of a partner who can keep up with my photon blasts and won't mind occasional space travel. Must have nerves of steel and a sense of humor—saving the universe can be stressful! Bonus points if you've ever punched a Skrull in the face.",
      age: 30,
      tags: ["Cosmic", "Fearless", "Space Traveler", "Photon Blasts"],
      role: "Defender of the universe",
      imageLink: "assets/images/captain-marvel.jpg"
    ),
    Superhero(
      name: "Natasha Romanoff",
      description: "🕷️ Seeking a partner who can handle my double life as a spy and an Avenger. Must be comfortable with late-night stakeouts, high-speed chases, and witty banter. Bonus points if you've ever defused a bomb while wearing a killer red dress. Let's save the world together!",
      age: 35,
      tags: ["Spy", "Avenger", "Double Life", "Red Room Survivor"],
      role: "Superhero",
      imageLink: "assets/images/natasha-romanoff.jpg"
    ),
    Superhero(
      name: "Miss Marvel",
      description: "Looking for someone who appreciates shape-shifting and late-night superhero patrols. Must be cool with fangirling over the Avengers and have a soft spot for Jersey City. If you've ever accidentally turned your arm into a giant fist, let's meet up!",
      age: 16,
      tags: ["Inhuman", "Elastic", "Fanatic", "Jersey City's Protector"],
      role: "Young Avenger",
      imageLink: "assets/images/ms-marvel.jpg"
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headlineLarge!.copyWith(
      color: Colors.white60,
    );
    final subtitleStyle = theme.textTheme.titleMedium!.copyWith(
      color: Colors.white60,
    );
    final CardSwiperController controller = CardSwiperController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline_outlined),
            tooltip: 'Messages',
            onPressed: () {
              print("Clicked Messages");
            },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              print("Clicked Search");
              print(_cards.length);
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            radius: 16,
            child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset('assets/user2.jpeg', fit: BoxFit.cover),
                  ),
          ),
          SizedBox(width: 16),
        ],
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('She likes you 🔥'),
            SizedBox(height: 10),
            SizedBox(
              height: 475.0,
              width: 325.0,
              child: Stack(                
                children: <Widget>[
                  CardSwiper(
                    controller: controller,
                    cardsCount: _cards.length,
                    maxAngle: 10,
                    allowedSwipeDirection: AllowedSwipeDirection.only(left: true, right: true),
                    onSwipe: ( int previousIndex, int? currentIndex, CardSwiperDirection direction, ) {
                      debugPrint(
                        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
                      );
                      if (currentIndex != null) {
                        print(_cards[currentIndex].name);
                        setState(() {
                          topCardIndex=currentIndex;
                        });                        
                      } else {
                        print('No card is on top now.');
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                          content: Center(child: Text(direction.name == "left"? "You disliked ${_cards[previousIndex].name} 😔": "You liked ${_cards[previousIndex].name} 💖", textAlign: TextAlign.center,)),
                          duration: const Duration(milliseconds: 500),
                          // width: 280.0, // Width of the SnackBar.
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, // Inner padding for SnackBar content.
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          dismissDirection: DismissDirection.up,
                          backgroundColor: Colors.white60,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 150,
                            left: 70,
                            right: 70,
                          )
                        ),
                      );
                      
                      return true;
                    },
                    onUndo: ( int? previousIndex, int currentIndex, CardSwiperDirection direction, ) {
                      debugPrint(
                        'The card $currentIndex was undod from the ${direction.name}',
                      );
                      return true;
                    },
                    numberOfCardsDisplayed: 3,
                    backCardOffset: const Offset(20, 20),
                    padding: const EdgeInsets.all(24.0),
                    cardBuilder: (
                      context,
                      index,
                      horizontalThresholdPercentage,
                      verticalThresholdPercentage,
                    ) =>
                        Card(imageLink: _cards[index].imageLink)
                  ),
                ]
              ),
            ),
            
            SizedBox(height: 30),
            Text("${_cards[topCardIndex].name}, ${_cards[topCardIndex].age}",style: titleStyle,),
            SizedBox(height: 10),
            Text(_cards[topCardIndex].role, style: subtitleStyle,),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _cards[topCardIndex].tags.map((tag) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(tag),
                )).toList(),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 325.0,
              child: Text(_cards[topCardIndex].description, textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String imageLink; 
  Card({
    super.key,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Image.asset(
        imageLink,
        height: 475.0,
        width: 325.0,
        fit: BoxFit.cover
      ),
    );
  }
}

class Superhero {
  final String name;
  final String description;
  final String imageLink;
  final int age;
  final List<String> tags;
  final String role;

  Superhero({
    required this.name,
    required this.description,
    required this.imageLink,
    required this.age,
    required this.tags,
    required this.role,
  });

  // factory Superhero.fromJson(Map<String, dynamic> json) {
  //   return Superhero(
  //     name: json['name'],
  //     description: json['description'],
  //     imageLink: json['imageLink'],
  //     age: json['age'],
  //     tags: List<String>.from(json['tags']),
  //     role: json['role'],
  //   );
  // }
}
