import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int selectedCharacterIndex = 0;
  final List<Map<String, dynamic>> characters = [
    {
      'name': 'Guts',
      'image': 'https://i.redd.it/39mwrodj1x2g1.jpeg',
      'hp': 160,
      'lvl': 2,
      'atk': 15,
      'def': 10,
      'strength': 18,
      'constitution': 17,
      'wisdom': 12,
      'dexterity': 14,
      'intelligence': 10,
      'charisma': 11,
    },
    {
      'name': 'Griffith',
      'image': 'https://i.redd.it/26dhb33dwgwb1.jpg',
      'hp': 120,
      'lvl': 4,
      'atk': 20,
      'def': 8,
      'strength': 13,
      'constitution': 12,
      'wisdom': 16,
      'dexterity': 17,
      'intelligence': 18,
      'charisma': 19,
    },
    {
      'name': 'Casca',
      'image':
          'https://wallpapers.com/images/high/berserk-4k-casca-wearing-armour-03jvqr1dro5j6din.webp',
      'hp': 100,
      'lvl': 1,
      'atk': 12,
      'def': 9,
      'strength': 14,
      'constitution': 13,
      'wisdom': 13,
      'dexterity': 16,
      'intelligence': 11,
      'charisma': 12,
    },
    {
      'name': 'Zodd',
      'image':
          'https://static0.gamerantimages.com/wordpress/wp-content/uploads/2024/11/nosferatu-zodd-berserk.jpg?q=70&fit=crop&w=1296&h=891&dpr=1',
      'hp': 200,
      'lvl': 3,
      'atk': 30,
      'def': 20,
      'strength': 20,
      'constitution': 19,
      'wisdom': 10,
      'dexterity': 15,
      'intelligence': 9,
      'charisma': 14,
    },
  ];

  //**metodi colonna di sinistra**
  //Game Chat
  Widget _chatHeaders() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color.fromRGBO(227, 0, 58, 1),
      alignment: Alignment.centerLeft,
      child: const Row(
        children: [
          Icon(Icons.message, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'Game Chat',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  //ChatMessages
  Widget _chatMessages() {
    return Expanded(
      child: ListView.builder(
        itemCount: 0, // per ora
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Messaggio'),
          );
        },
      ),
    );
  }

  //Sezione Chat
  Widget _chatInput() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F4),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Write a message',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 40,
              width: 40,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: const Color.fromRGBO(227, 0, 58, 1),
                onPressed: () {
                  // invio messaggio
                },
                child: const Icon(Icons.send, size: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*METODI COLONNA DI DESTRA*/
  //Character Header
  Widget characterHeader() {
    return SingleChildScrollView(
      //questo rende scrollable orizzontalmente la view
      scrollDirection: Axis.horizontal, //o meglio questo lo fa orizzontalmetne
      child: Row(
        children: List.generate(characters.length, (index) {
          final bool isSelected = index == selectedCharacterIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCharacterIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        characters[index]['image']!,
                      ),
                    ),
                  ),
                  //spazio tra circle e sotto
                  const SizedBox(height: 6),
                  //definisco nome characters
                  Text(
                    characters[index]['name']!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  //Character Tabs
  Widget characterTabs() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color.fromARGB(211, 0, 0, 0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('HP'),
                Text(characters[selectedCharacterIndex]['hp'].toString()),
              ],
            ),
          ),
        ),
        //spazio tra row
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color.fromARGB(211, 0, 0, 0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('ATK'),
                Text(characters[selectedCharacterIndex]['atk'].toString()),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color.fromARGB(211, 0, 0, 0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 4),
                Text('DEF'),
                Text(characters[selectedCharacterIndex]['def'].toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Character Content
  Widget characterContent() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //HP
            Text('HP'),
            Text(characters[selectedCharacterIndex]['hp'].toString()),
            //LVL
             Text('Level'),
             Text(characters[selectedCharacterIndex]['lvl'].toString())
             ],
        ),
        //spazio tra sopra e sotto
       const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                children: [
                  //strenght
                  Text('Strength'),
                  Text(
                    characters[selectedCharacterIndex]['strength'] 
                        .toString(),
                  ),

                  //Costitution
                  Text('Constitution'),
                  Text(
                    characters[selectedCharacterIndex]['constitution'] 
                        .toString(),
                  ),
                  //Wisdom
                  Text('Wisdom'),
                  Text(characters[selectedCharacterIndex]['wisdom'].toString()),
                ],
              ),
            ),

            //spazio tra i due expanded
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  //Dexterity
                  Text('Dexterity'),
                  Text(
                    characters[selectedCharacterIndex]['dexterity'].toString(),
                  ),
                  //Intelligence
                  Text('Intelligence'),
                  Text(
                    characters[selectedCharacterIndex]['intelligence']
                        .toString(),
                  ),
                  //Charisma
                  Text('Charisma'),
                  Text(
                    characters[selectedCharacterIndex]['charisma'].toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //*Build*//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // LEFT COLUMN
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey.shade200,
              child: Column(
                children: [_chatHeaders(), _chatMessages(), _chatInput()],
              ),
            ),
          ),

          // RIGHT COLUMN
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Container(
                    height: 90,
                    color: Color.fromRGBO(227, 0, 57, 1),
                    alignment: Alignment.center,
                    child: characterHeader(),
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.network(
                      characters[selectedCharacterIndex]['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 80,
                    color: const Color.fromARGB(255, 184, 183, 181),
                    alignment: Alignment.center,
                    child: characterTabs(),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: characterContent(),
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
}
