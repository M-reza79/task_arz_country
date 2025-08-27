import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country/country_bloc.dart';
import 'package:task_arz_country/bloc/country/country_event.dart';

class Serche extends StatelessWidget {
  final Color textColor;
  const Serche({
    super.key,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.all(
        Radius.circular(10),
      ),
      child: TextField(
        onChanged: (value) {
          context.read<CountryBloc>().add(
            SearchCountryEvent(value),
          );
        },
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),

        textAlign: TextAlign.left,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: BorderSide(
              color: textColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: BorderSide(
              color: textColor,
              width: 1,
            ),
          ),

          hintTextDirection: TextDirection.rtl,
          hintText: '...Search for a country',
          hintStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.search,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
