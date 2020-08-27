import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'betukereso.dart';

class _WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    var model = context.watch<AppModel>();

    return ListView.builder(
      itemCount: model.words.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
            child: Text('${ model.words[index].length }'),
        ),
        title: Text(
          model.words[index],
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _LetterInput extends StatelessWidget {
  TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      autofocus: true,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          hintText: 'Adj meg bet\u0171ket!'
      ),
      onChanged: (newText) {
        Provider.of<AppModel>(context, listen: false).letters = newText;
      },
    );
  }
}

class _MyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final branding = Image.asset(
      'images/2child1book.webp',
      width: 100.0,
      height: 100.0,
      fit: BoxFit.cover,
    );
    return Container(
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                branding,
                Expanded(
                    child: _LetterInput()
                )
              ],
            ),
            Expanded(
                child: _WordList()
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fab = FloatingActionButton.extended(
        onPressed: () {
          print('searching');
          var model = context.read<AppModel>();
          model.words = Betukereso.ListOfWordsBy(model.letters);
          print('${model}');
        },
        tooltip: 'Keres',
        icon: Icon(Icons.search),
        label: Text("Keres")
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('\uD83D\uDCD6 Bet\u0171keres\u0151'),
      ),
      body: _MyLayout(),
      floatingActionButton: fab,
    );
  }
}
