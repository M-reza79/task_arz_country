import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country/country_bloc.dart';
import 'package:task_arz_country/bloc/country/country_event.dart';
import 'package:task_arz_country/bloc/country/country_state.dart';
import 'package:task_arz_country/bloc/theme/theme_bloc.dart';
import 'package:task_arz_country/bloc/theme/theme_event.dart';
import 'package:task_arz_country/bloc/theme/theme_state.dart';
import 'package:task_arz_country/data/model/countrys.dart';
import 'package:task_arz_country/widgets/category_countries.dart';
import 'package:task_arz_country/widgets/my_dropdown_widget.dart';
import 'package:task_arz_country/widgets/serche.dart';

class HomeScrennes extends StatefulWidget {
  const HomeScrennes({super.key});

  @override
  State<HomeScrennes> createState() =>
      _HomeScrennesState();
}

class _HomeScrennesState
    extends State<HomeScrennes> {
  @override
  void initState() {
    BlocProvider.of<CountryBloc>(
      context,
    ).add(LoadCountriesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(
      context,
    ).colorScheme.onSurface;
    return Scaffold(
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state
                    is CountryLoadingState) ...[
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
                  SliverAppBar(
                    title: Text(
                      'where in the world?',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    shadowColor: textColor,
                    forceElevated: false,
                    elevation: 0,
                    actions: [
                      IconButton(
                        style: IconButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                        ),
                        onPressed: () {
                          context
                              .read<ThemeBloc>()
                              .add(
                                ThemeToggled(),
                              );
                        },

                        icon: BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, themeState) {
                            return Icon(
                              themeState.themeMode ==
                                      ThemeMode
                                          .light
                                  ? Icons
                                        .brightness_high_outlined
                                  : Icons
                                        .brightness_2_outlined,
                              color: textColor,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  _GetSearchBox(
                    textColor: textColor,
                  ),

                  if (state
                      is CountryResponseState) ...[
                    state.countries.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (countrylist) {
                        return _GetRatingBox(
                          textColor: textColor,
                          countrylist:
                              countrylist,
                          continents:
                              state.continents,
                        );
                      },
                    ),
                  ],

                  if (state
                      is CountryResponseState) ...[
                    state.countries.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (countrylist) {
                        return CategoryCountries(
                          textColor: textColor,
                          countrylist:
                              countrylist,
                        );
                      },
                    ),
                  ],
                  SliverPadding(
                    padding:
                        EdgeInsetsGeometry.only(
                          bottom: 100,
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

class _GetRatingBox extends StatelessWidget {
  final List<Countrys> countrylist;
  final Color textColor;
  final List<String> continents;
  const _GetRatingBox({
    super.key,
    required this.countrylist,
    required this.textColor,
    required this.continents,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 25,
        ),
        child: Row(
          children: [
            MyDropdownWidget(
              textColor: textColor,
              continents: continents,
            ),
            Spacer(),
            Text(
              'Total: ${countrylist.length}',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GetSearchBox extends StatelessWidget {
  final Color textColor;
  const _GetSearchBox({
    super.key,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 20,
          right: 20,
          left: 20,
          bottom: 10,
        ),
        child: Serche(textColor: textColor),
      ),
    );
  }
}
