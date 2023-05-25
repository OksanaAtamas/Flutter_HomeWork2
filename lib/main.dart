import 'package:flutter/material.dart';
import 'about.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<CardInfo> _listOfCards = List.generate(15, (index) {
    return CardInfo(
      title: 'title$index',
      id: index,
    );
  });

  void updateCard(CardInfo newCardInfo) {
    setState(() {
      _listOfCards[newCardInfo.id] = newCardInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeWork 2',
      home: Scaffold(
        body: ListView.builder(
          itemCount: _listOfCards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  final newCardInfo = await Navigator.push<CardInfo>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AboutPage(
                        cardInfo: _listOfCards[index],
                        onUpdate: updateCard,
                      ),
                    ),
                  );

                  if (newCardInfo != null) {
                    updateCard(newCardInfo);
                  }
                },
                child: CustomCard(
                  cardInfo: _listOfCards[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardInfo {
  String title;
  final int id;
  final String imageUrl;

  CardInfo({
    required this.title,
    required this.id,
    this.imageUrl = 'images/lake.jpg',
  });
}

class CustomCard extends StatelessWidget {
  final CardInfo cardInfo;

  const CustomCard({
    Key? key,
    required this.cardInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildTitleSection(int index) {
      return Positioned(
        top: 16,
        left: 16,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: ShapeDecoration(
            color: Colors.black.withOpacity(0.8),
            shape: CircleBorder(),
          ),
          child: Text(
            '#$index.',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Positioned(
      top: 16,
      right: 16,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Container(
          width: 180,
          height: 70,
          color: Colors.white.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
              _buildButtonColumn(Colors.green, Icons.near_me, 'ROUTE'),
              _buildButtonColumn(Colors.black, Icons.share, 'SHARE'),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: [
        Image.asset(
          cardInfo.imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        buildTitleSection(cardInfo.id),
        Positioned(
          left: 16,
          right: 16,
          bottom: 0,
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.black54,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cardInfo.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        buttonSection,
      ],
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
