import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_bloc.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_event.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_state.dart';
import 'package:task_arz_country/bloc/theme/theme_bloc.dart';
import 'package:task_arz_country/bloc/theme/theme_event.dart';
import 'package:task_arz_country/bloc/theme/theme_state.dart';
import 'package:task_arz_country/data/model/country_detail.dart';

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
      LoadCountryDataEvent(widget.country.name),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(
      context,
    ).colorScheme.onSurface;
    return Scaffold(
      body: BlocBuilder<CountryDetailBloc, ICountryDetailState>(
        builder: (context, state) {
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
                  SliverAppBar(
                    // ویژگی‌های دیگر SliverAppBar مثل backgroundColor, floating, pinned ...

                    // 1. عنوان را در پراپرتی title قرار بده
                    title: Text(
                      'where in the world?',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    elevation: 100,
                    // 2. فقط دکه را در پراپرتی actions قرار بده
                    actions: [
                      IconButton(
                        style: IconButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                        ),
                        onPressed: () {
                          // وقتی کلیک شد، ایونت ThemeToggled رو به ThemeBloc بفرست
                          context
                              .read<ThemeBloc>()
                              .add(
                                ThemeToggled(),
                              );
                        },

                        icon: BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, themeState) {
                            // بر اساس وضعیت تم، آیکون مناسب رو نشون بده
                            return Icon(
                              themeState.themeMode ==
                                      ThemeMode
                                          .light
                                  ? Icons
                                        .brightness_high_outlined // آیکون ماه برای حالت روشن
                                  : Icons
                                        .brightness_2_outlined, // آیکون خورشید برای حالت تاریک
                              color: textColor,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(
                            left: 28,
                            top: 32,
                            bottom: 20,
                            right: 28,
                          ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start, // ۳. این خط کلیدیه! محتوا رو به چپ می‌چسبونه
                        children: [
                          ElevatedButton.icon(
                            onPressed: () =>
                                Navigator.of(
                                  context,
                                ).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                            ),
                            label: Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 16,

                                color: textColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              iconColor:
                                  textColor,
                              iconSize: 20,
                              padding:
                                  const EdgeInsets.symmetric(
                                    horizontal:
                                        32,
                                    vertical: 12,
                                  ),
                              elevation: 3,
                              shadowColor:
                                  Colors.black,
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
                            top: 5,
                            bottom: 10,
                          ),
                      child: Center(
                        child: SizedBox(
                          height: 200,
                          width: MediaQuery.of(
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
                    ),
                  ),
                  if (state
                      is CountryDetailLoadedState) ...[
                    state.countryPageData.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (countryDetails) {
                        return SliverToBoxAdapter(
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
                                  countryDetails
                                      .mainCountry
                                      .continents
                                      .join(),
                                  style: TextStyle(
                                    fontSize: 24,

                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Native Name: ${countryDetails.mainCountry.nativeName} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Population: ${countryDetails.mainCountry.population} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Region: ${countryDetails.mainCountry.region} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Sub Region: ${countryDetails.mainCountry.subregion} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'capita: ${countryDetails.mainCountry.capital.join()} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Top Level Domain: ${countryDetails.mainCountry.tld[0]} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Continents: ${countryDetails.mainCountry.continents.join()} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Languages: ${countryDetails.mainCountry.languages.join(', ')} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],

                  if (state
                      is CountryDetailLoadedState) ...[
                    state.countryPageData.fold(
                      (l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      },
                      (countryDetails) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal:
                                      28.0,
                                  vertical: 20.0,
                                ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  'Border Countries:',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color:
                                        textColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),

                                if (countryDetails
                                    .borderCountries
                                    .isEmpty)
                                  SliverToBoxAdapter(
                                    child: const Text(
                                      'This country has no land borders.',
                                    ),
                                  ),

                                SingleChildScrollView(
                                  scrollDirection:
                                      Axis.horizontal, // 👉 افقی می‌کنه
                                  child: Row(
                                    children: countryDetails.borderCountries.map((
                                      borderCountry,
                                    ) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right:
                                              10,
                                        ), // فاصله بین دکمه‌ها
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation:
                                                3,
                                            shadowColor:
                                                Colors.black,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  20,
                                              vertical:
                                                  10,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (
                                                      context,
                                                    ) {
                                                      return BlocProvider(
                                                        create:
                                                            (
                                                              context,
                                                            ) => CountryDetailBloc(),
                                                        child: CountryDetailScreen(
                                                          country: borderCountry,
                                                        ),
                                                      );
                                                    },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            borderCountry
                                                .name,
                                            style: TextStyle(
                                              color:
                                                  textColor,
                                              fontSize:
                                                  14,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
