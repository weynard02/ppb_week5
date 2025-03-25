import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {

  final Quote quote;
  final VoidCallback delete;
  final VoidCallback duplicate;
  final VoidCallback edit;
  QuoteCard({ required this.quote, required this.delete, required this.duplicate, required this.edit });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                quote.text ?? "",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                quote.author ?? "",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8.0),
              ElevatedButton.icon(
                onPressed: delete,
                label: Text('delete quote'),
                icon: Icon(Icons.delete),
              ),
              ElevatedButton.icon(
                onPressed: duplicate,
                label: Text('duplicate quote'),
                icon: Icon(Icons.add),
              ),
              ElevatedButton.icon(
                onPressed: edit,
                label: Text('edit quote'),
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        )
    );
  }
}