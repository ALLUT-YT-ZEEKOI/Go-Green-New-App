import 'package:flutter/material.dart';

class AccordionDemo extends StatelessWidget {
  const AccordionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a list of title and content for the tiles
    final accordionItems = [
      {
        'title': 'Product Description',
        'content': 'This is the product overview.'
      },
      {'title': 'Shelf life', 'content': 'Details about specs.'},
      {'title': 'Country of origin', 'content': 'Feedback from customers.'},
    ];

    return Column(
      children: accordionItems.map((item) {
        return AccordionTile(
          title: item['title']!,
          content: item['content']!,
        );
      }).toList(),
    );
  }
}

class AccordionTile extends StatefulWidget {
  final String title;
  final String content;

  const AccordionTile({super.key, required this.title, required this.content});

  @override
  _AccordionTileState createState() => _AccordionTileState();
}

class _AccordionTileState extends State<AccordionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 1.0,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(
                color: Color(0xFF1D2730),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: ConstrainedBox(
              constraints: _isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(widget.content),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
