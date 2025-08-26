 
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_arz_country/bloc/country/country_bloc.dart';
// import 'package:task_arz_country/bloc/country/country_event.dart';
// import 'package:task_arz_country/bloc/country/country_state.dart';
// import 'package:task_arz_country/data/model/country.dart';
// import 'package:task_arz_country/widgets/cached_image.dart';

// class CountryView extends StatefulWidget {
//   final Country country;
//   final Color textColor;
//   const CountryView({
//     super.key,
//     required this.country,
//     required this.textColor,
//   });

//   @override
//   State<CountryView> createState() =>
//       _CountryViewState();
// }

// class _CountryViewState
//     extends State<CountryView> {
//   late Country country;
//   @override
//   void initState() {
//     country = widget.country;
//     BlocProvider.of<CountryBloc>(
//       context,
//     ).add(LoadCountriesEvent());

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<CountryBloc, CountryState>(
//         builder: (context, state) {
//           return SafeArea(
//             child: CustomScrollView(
//               slivers: [
//                 if (state
//                     is CountryLoadingState) ...[
//                   SliverToBoxAdapter(
//                     child: Column(
//                       mainAxisAlignment:
//                           MainAxisAlignment
//                               .center,
//                       mainAxisSize:
//                           MainAxisSize.max,
//                       children: const [
//                         SizedBox(
//                           width: 20,
//                           height: 20,
//                           child:
//                               CircularProgressIndicator(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ] else ...[
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(
//                             top: 5,
//                             right: 30,
//                             left: 30,
//                             bottom: 10,
//                           ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color:
//                               (widget.textColor ==
//                                   Colors.black
//                               ? const Color.fromARGB(
//                                   255,
//                                   237,
//                                   229,
//                                   213,
//                                 )
//                               : Colors.black),
//                           borderRadius:
//                               BorderRadius.all(
//                                 Radius.circular(
//                                   15,
//                                 ),
//                               ),
//                         ),
//                         height: 46,
//                         child: Row(
//                           crossAxisAlignment:
//                               CrossAxisAlignment
//                                   .center,
//                           children: [
//                             SizedBox(width: 16),

//                             Expanded(
//                               child: Text(
//                                 country.name,
//                                 textAlign:
//                                     TextAlign
//                                         .center,
//                                 style: TextStyle(
//                                   fontFamily:
//                                       'SB',
//                                   fontSize: 16,
//                                   color: widget
//                                       .textColor,
//                                 ),
//                               ),
//                             ),

//                             SizedBox(width: 16),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(
//                             right: 20,
//                             left: 20,
//                             top: 5,
//                             bottom: 10,
//                           ),
//                       child: Column(
//                         mainAxisAlignment:
//                             MainAxisAlignment
//                                 .center,
//                         crossAxisAlignment:
//                             CrossAxisAlignment
//                                 .center,
//                         children: [
//                           Center(
//                             child: SizedBox(
//                               height: 100,
//                               width:
//                                   MediaQuery.of(
//                                     context,
//                                   ).size.width,
//                               child: CachedkImage(
//                                 radius: 15,
//                                 imageUrl:
//                                     country.flag,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(
//                             right: 20,
//                             left: 20,
//                             bottom: 10,
//                           ),
//                       child: Column(
//                         mainAxisAlignment:
//                             MainAxisAlignment
//                                 .center,
//                         crossAxisAlignment:
//                             CrossAxisAlignment
//                                 .start,
//                         children: [
//                           Text(
//                             'Continent: ${country.continent}',
//                             style: TextStyle(
//                               fontSize: 24,

//                               color: widget
//                                   .textColor,
//                             ),
//                           ),
//                           Text(
//                             'Capital: ${country.capital}',
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: widget
//                                   .textColor,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Divider(),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(
//                             right: 20,
//                             left: 20,
//                             bottom: 10,
//                           ),
//                       child: Column(
//                         mainAxisAlignment:
//                             MainAxisAlignment
//                                 .center,
//                         crossAxisAlignment:
//                             CrossAxisAlignment
//                                 .start,
//                         children: [
//                           Text(
//                             'Description: ${country.description}',
//                             style: TextStyle(
//                               fontSize: 24,

//                               color: widget
//                                   .textColor,
//                             ),
//                           ),

//                           SizedBox(height: 10),
//                           Divider(),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(
//                             right: 20,
//                             left: 20,
//                             bottom: 5,
//                           ),
//                       child: Column(
//                         mainAxisAlignment:
//                             MainAxisAlignment
//                                 .center,
//                         crossAxisAlignment:
//                             CrossAxisAlignment
//                                 .start,
//                         children: [
//                           Text(
//                             'Borders: ${country.borders.join(', ')}',
//                             style: TextStyle(
//                               fontSize: 24,

//                               color: widget
//                                   .textColor,
//                             ),
//                           ),

//                           SizedBox(height: 10),
//                           Divider(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
