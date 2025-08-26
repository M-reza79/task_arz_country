import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country/country_bloc.dart';
import 'package:task_arz_country/bloc/country/country_event.dart';

class MyDropdownWidget extends StatefulWidget {
  final Color textColor;
  final List<String> continents;
  const MyDropdownWidget({
    super.key,
    required this.textColor,
    required this.continents,
  });

  @override
  State<MyDropdownWidget> createState() =>
      _MyDropdownWidgetState();
}

class _MyDropdownWidgetState
    extends State<MyDropdownWidget> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.continents.isNotEmpty) {
      _selectedValue = widget.continents[0];
    }
  }

  @override
  void didUpdateWidget(
    covariant MyDropdownWidget oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (widget.continents.isNotEmpty &&
        !widget.continents.contains(
          _selectedValue,
        )) {
      setState(() {
        _selectedValue = widget.continents[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.continents.isEmpty) {
      return const SizedBox.shrink();
    }

    return DropdownButton<String>(
      value: _selectedValue,
      dropdownColor: Theme.of(
        context,
      ).scaffoldBackgroundColor,
      style: TextStyle(
        color: widget.textColor,
        fontSize: 16,
      ),
      underline: Container(
        height: 1,
        color: widget.textColor.withOpacity(0.5),
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedValue = newValue;
          });

          context.read<CountryBloc>().add(
            FilterCountriesByContinentEvent(
              newValue,
            ),
          );
        }
      },

      items: widget.continents
          .map<DropdownMenuItem<String>>((
            String value,
          ) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
          .toList(),
    );
  }
}
