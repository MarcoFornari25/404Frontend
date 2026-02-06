import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

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
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color.fromARGB(255, 58, 96, 52),
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
              backgroundColor:const Color.fromRGBO(227, 0, 58, 1),
              onPressed: () {
                // invio messaggio
              },
              child: const Icon(Icons.send, size: 18, color: Colors.white,),
            ),
          ),
        ],
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // left column
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: Column(
                children: [
                  _chatHeaders(),

                  Expanded(
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Text('ChatMessages'),
                    ),
                  ),

                  Container(
                    height: 60,
                    color: Colors.blueAccent,
                    alignment: Alignment.center,
                    child: Column(children: [_chatInput()]),
                  ),
                ],
              ),
            ),
          ),

          // right column
             Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Container(
                    height: 60,
                    color: Colors.purple,
                    alignment: Alignment.center,
                    child: const Text(
                      'CharacterHeader',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  Container(
                    height: 200,
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: const Text(
                      'CharacterImage',
                      style: TextStyle(color: Colors.white),
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
