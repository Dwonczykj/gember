import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';

// import '../components/grocery_tile.dart';
import '../colors.dart';
import '../models/models.dart';

class YourItemScreen extends StatefulWidget {
  final Function(YourItem) onCreate;
  final Function(YourItem, int) onUpdate;
  final YourItem? originalItem;
  final int index;
  final bool isUpdating;

  static MaterialPage page({
    YourItem? item,
    int index = -1,
    required Function(YourItem) onCreate,
    required Function(YourItem, int) onUpdate,
  }) {
    return MaterialPage(
      name: TemplatePages.groceryItemDetails,
      key: ValueKey(TemplatePages.groceryItemDetails),
      child: YourItemScreen(
        originalItem: item,
        index: index,
        onCreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }

  const YourItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    this.index = -1,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _YourItemScreenState createState() => _YourItemScreenState();
}

class _YourItemScreenState extends State<YourItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final groceryItem = YourItem(
                  // id: widget.originalItem?.id ?? const Uuid().v1(),
                  // name: _nameController.text,
                  // importance: _importance,
                  // color: _currentColor,
                  // quantity: _currentSliderValue,
                  // date: DateTime(
                  //   _dueDate.year,
                  //   _dueDate.month,
                  //   _dueDate.day,
                  //   _timeOfDay.hour,
                  //   _timeOfDay.minute,
                  // ),
                  );

              if (widget.isUpdating) {
                widget.onUpdate(
                  groceryItem,
                  widget.index,
                );
              } else {
                widget.onCreate(groceryItem);
              }
            },
          )
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: green,
      ),
    );
  }

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _name = originalItem.name;
      _nameController.text = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
