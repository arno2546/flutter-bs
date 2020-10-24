import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder:(context,item){
        if(item.isOdd) return Divider();

        final index = item ~/2;

        if(index>=_randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,style:GoogleFonts.lato(fontSize: 20.0),
      ),

      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _savedWordPairs.remove(pair);
          }
          else{
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pustSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair){
            return ListTile(
              title: Text(pair.asPascalCase, style: GoogleFonts.lato(fontSize: 20.0),),
            );
          }); 

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
            color: Colors.green[400]
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Favorite Words',style:GoogleFonts.oswald(fontSize: 30)),
            ),
            body: ListView(children: divided,),
          );
        }
      )
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator',style:GoogleFonts.oswald(fontSize: 30)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pustSaved)
        ],
      ),
      body: _buildList(),
    );
  }
}