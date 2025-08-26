import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_bloc.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_event.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_state.dart';

import 'package:task_arz_country/data/model/countrys.dart';
import 'package:task_arz_country/widgets/cached_image.dart';

class CountryDetailScreen extends StatefulWidget {
  final Countrys country;
  const CountryDetailScreen({
    super.key,
    required this.country,
  });

  @override
  State<CountryDetailScreen> createState() =>
      _CountryDetailScreenState();
}

class _CountryDetailScreenState
    extends State<CountryDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<CountryDetailBloc>(
      context,
    ).add(
      LoadBorderCountriesEvent(
        continent:
            widget.country.continents.first,
        countryName: widget.country.name,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CountryDetailBloc, ICountryDetailState>(
        builder: (context, state) {
          final textColor = Theme.of(
            context,
          ).colorScheme.onSurface;
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state
                    is CountryDetailLoadingState) ...[
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      mainAxisSize:
                          MainAxisSize.max,
                      children: const [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(
                            top: 5,
                            right: 30,
                            left: 30,
                            bottom: 10,
                          ),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              (textColor ==
                                  Colors.black
                              ? const Color.fromARGB(
                                  255,
                                  237,
                                  229,
                                  213,
                                )
                              : Colors.black),
                          borderRadius:
                              BorderRadius.all(
                                Radius.circular(
                                  15,
                                ),
                              ),
                        ),
                        height: 46,
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .center,
                          children: [
                            SizedBox(width: 16),

                            Expanded(
                              child: Text(
                                widget
                                    .country
                                    .name,
                                textAlign:
                                    TextAlign
                                        .center,
                                style: TextStyle(
                                  fontFamily:
                                      'SB',
                                  fontSize: 16,
                                  color:
                                      textColor,
                                ),
                              ),
                            ),

                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(
                            right: 20,
                            left: 20,
                            top: 5,
                            bottom: 10,
                          ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .center,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 100,
                              width:
                                  MediaQuery.of(
                                    context,
                                  ).size.width,
                              child: CachedkImage(
                                radius: 15,
                                imageUrl: widget
                                    .country
                                    .flags,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(
                            right: 20,
                            left: 20,
                            bottom: 10,
                          ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            'Continent: ${widget.country.continents}',
                            style: TextStyle(
                              fontSize: 24,

                              color: textColor,
                            ),
                          ),
                          Text(
                            'Capital: ${widget.country.capital}',
                            style: TextStyle(
                              fontSize: 20,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(
                            right: 20,
                            left: 20,
                            bottom: 10,
                          ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            'Description: ${widget.country.population}',
                            style: TextStyle(
                              fontSize: 24,

                              color: textColor,
                            ),
                          ),

                          SizedBox(height: 10),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(
                            right: 20,
                            left: 20,
                            bottom: 5,
                          ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            'Borders: ${widget.country.borders.join(', ')}',
                            style: TextStyle(
                              fontSize: 24,

                              color: textColor,
                            ),
                          ),

                          SizedBox(height: 10),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
