import 'package:flutter/material.dart';

class AddFormTile extends StatelessWidget {
  const AddFormTile(
      {Key? key, required this.title, required this.textController})
      : super(key: key);
  final String title;
  final TextEditingController textController;

  const AddFormTile.date({
    Key? key,
    this.title = "Date",
    required this.textController,
  }) : super(key: key);

  const AddFormTile.type({
    Key? key,
    this.title = "Type",
    required this.textController,
  }) : super(key: key);

  const AddFormTile.category({
    Key? key,
    this.title = "Category",
    required this.textController,
  }) : super(key: key);

  const AddFormTile.description({
    Key? key,
    this.title = "Description",
    required this.textController,
  }) : super(key: key);

  const AddFormTile.amount({
    Key? key,
    this.title = "Amount",
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), generatedTextField()],
    );
  }

  Widget generatedTextField() {
    switch (title) {
      case "Date":
        return DatePickerField(
          textController: textController,
        );
      case "Type":
        return TypeField(
          textController: textController,
        );
      case "Category":
        return CategoryField(
          textController: textController,
        );
      case "Description":
        return TextFormField(
          controller: textController,
          keyboardType: TextInputType.text,
          maxLines: 3,
        );
      case "Amount":
        return TextFormField(
          controller: textController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required! Please this field';
            }
            return null;
          },
        );
      default:
        return const TextField();
    }
  }
}

class TypeField extends StatelessWidget {
  TypeField({Key? key, required this.textController}) : super(key: key);
  final TextEditingController textController;

  final List<String> type = ['Income', 'Expense'];

  @override
  Widget build(BuildContext context) {
    textController.text = 'Income';
    return DropdownButtonFormField<String>(
      items: type.map((String type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (newValue) {
        textController.text = newValue!;
      },
      onSaved: (newValue) {
        textController.text = newValue!;
      },
      value: textController.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}

class CategoryField extends StatelessWidget {
  CategoryField({Key? key, required this.textController}) : super(key: key);
  final TextEditingController textController;

  final List<String> category = ['Food', 'Shoping'];

  @override
  Widget build(BuildContext context) {
    textController.text = 'Food';
    return DropdownButtonFormField<String>(
      items: category.map((String category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (newValue) {
        textController.text = newValue!;
      },
      onSaved: (newValue) {
        textController.text = newValue!;
      },
      value: textController.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}

class DatePickerField extends StatelessWidget {
  DatePickerField({Key? key, required this.textController}) : super(key: key);

  final TextEditingController textController;

  final DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required! Please Choose the Date';
        }
        return null;
      },
      controller: textController,
      initialValue: null,
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }

  _selectDate(BuildContext context) async {
    late DateTime selectDateTime;
    final DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    final TimeOfDay? selectTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (selectDate != null && selectTime != null) {
      selectDateTime = DateTime(
        selectDate.year,
        selectDate.month,
        selectDate.day,
        selectTime.hour,
        selectTime.minute,
      );
    } else {
      selectDateTime = selectedDate;
    }

    textController.text = selectDateTime.toString();
  }
}
