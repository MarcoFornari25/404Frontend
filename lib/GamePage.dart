import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int selectedCharacterIndex = 0;
  final List<Map<String, String>> characters = [
    {
      'name': 'Guts',
      'image':
          'https://wallpapercave.com/wp/wp2740235.jpg',
    },
    {'name': 'Griffith',
     'image': 'https://i.redd.it/26dhb33dwgwb1.jpg'},
    {
      'name': 'Casca',
      'image':
          'https://preview.redd.it/why-so-cute-and-pretty-casca-v0-si3nrbluai5c1.jpg?width=630&format=pjpg&auto=webp&s=f6941ed658f2239294506f7844d481fd199d2edc',
    },
    {
      'name': 'Zodd',
      'image':
          'https://preview.redd.it/what-is-your-opinion-on-zodd-v0-l7w9ki1xsgye1.jpeg?auto=webp&s=63c8950720bd77add831535553d1cc30c5d8f51f',
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(height: 10),
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
            flex: 2,
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
                    height: 50,
                    color: Colors.yellow,
                    alignment: Alignment.center,
                    child: const Text('CharacterTabs'),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Text('CharacterContent'),
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
