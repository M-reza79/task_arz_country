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
      LoadBorderCountriesEvent(
        countryName: widget.country.name,
      ),
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
                    state.borderCountries.fold(
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
                                  countryDetails[0]
                                      .continents
                                      .join(),
                                  style: TextStyle(
                                    fontSize: 24,

                                    color:
                                        textColor,
                                  ),
                                ),
                                Text(
                                  'Native Name:${countryDetails[0].nativeName} ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],

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
