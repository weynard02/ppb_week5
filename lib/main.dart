import 'package:flutter/material.dart';
import 'package:quote_app/quote.dart';
import 'package:quote_app/quote_card.dart';

void main() => runApp(MaterialApp(home: QuoteList()));

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  final _formKey = GlobalKey<FormState>();
  String _author = '';
  String _quote = '';
  Quote? _selectedQuote;

  List<Quote> quotes = [
    Quote(author: 'Oscar Wilde', text: 'Be yourself; everyone else is already taken'),
    Quote(author: 'Oscar Wilde', text: 'I have nothing to declare except my genius'),
    Quote(author: 'Oscar Wilde', text: 'The truth is rarely pure and never simple')
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        quotes.add(Quote(author: _author, text: _quote));
      });

      _formKey.currentState!.reset();
    }
  }

  void _editQuote(Quote quote) {
    TextEditingController authorController = TextEditingController(text: quote.author);
    TextEditingController quoteController = TextEditingController(text: quote.text);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Wrap(
            children: [
              Text(
                'Edit Quote',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: "Author"),
              ),
              TextField(
                controller: quoteController,
                decoration: InputDecoration(labelText: "Quote"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    quote.author = authorController.text;
                    quote.text = quoteController.text;
                  });
                  Navigator.pop(context);
                },
                child: Text("Update Quote"),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Enter author"),
                    validator: (value) => value!.isEmpty ? 'Please enter author' : null,
                    onSaved: (value) => _author = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Enter quote"),
                    validator: (value) => value!.isEmpty ? 'Please enter quote' : null,
                    onSaved: (value) => _quote = value!,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(_selectedQuote == null ? 'Create' : 'Update'),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: quotes.map((quote) => QuoteCard(
              quote: quote,
              delete: () => setState(() => quotes.remove(quote)),
              duplicate: () => setState(() => quotes.add(Quote(author: quote.author, text: quote.text))),
              edit: () => _editQuote(quote),
            )).toList(),
          ),
        ],
      ),
    );
  }
}