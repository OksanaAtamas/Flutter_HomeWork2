import 'package:flutter/material.dart';
import 'main.dart';

class AboutPage extends StatefulWidget {
  final CardInfo cardInfo;
  final Function(CardInfo) onUpdate;

  const AboutPage({Key? key, required this.cardInfo, required this.onUpdate}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late TextEditingController controller;
  bool textFieldModified = false;

  @override
  void initState() {
    controller = TextEditingController(text: widget.cardInfo.title);
    super.initState();
  }

  Future<bool?> showDiscardChangesDialog() async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'not saved!',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardInfo = CardInfo(
      id: widget.cardInfo.id,
      title: widget.cardInfo.title,
      imageUrl: widget.cardInfo.imageUrl,
    );

    return WillPopScope(
      onWillPop: () async {
        if (textFieldModified) {
          bool? discardChanges = await showDiscardChangesDialog();
          return discardChanges ?? false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('New page')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      cardInfo.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          textFieldModified = true;
                        });
                      },
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      maxLines: 2,
                      maxLength: 35,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    cardInfo.title = controller.text;
                    widget.onUpdate(cardInfo);
                    Navigator.of(context).pop(cardInfo);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
