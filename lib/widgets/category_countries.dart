import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country/country_bloc.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_bloc.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_event.dart';
import 'package:task_arz_country/data/model/country_detail.dart';

import 'package:task_arz_country/data/model/countrys.dart';
import 'package:task_arz_country/views/country_detail_screen.dart';

import 'package:task_arz_country/widgets/cached_image.dart';

class CategoryCountries extends StatelessWidget {
  final List<Countrys> countrylist;
  final Color textColor;
  const CategoryCountries({
    super.key,
    required this.countrylist,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((
        context,
        index,
      ) {
        final country = countrylist[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                     
                      create: (context) => CountryDetailBloc(),
                      child: CountryDetailScreen(country: country),
                  );
                },
              ),
            );
          },

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15.0),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(
                          top: Radius.circular(
                            15.0,
                          ),
                        ),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: CachedkImage(
                        imageUrl: country.flags,
                      ),
                    ),
                  ),

                  Container(
                    width: double
                        .infinity, // عرض کامل کارت
                    color: const Color(
                      0xFF2d3a4a,
                    ), // رنگ پس‌زمینه تیره شبیه عکس
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start, // همه نوشته‌ها از چپ شروع بشن
                      children: [
                        // نام کشور با استایل بزرگ و بولد
                        Text(
                          country.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        // استفاده از تابع کمکی برای نمایش اطلاعات
                        _buildInfoRow(
                          'Population: ',
                          country.population
                              .toString(),
                        ),
                        const SizedBox(height: 6),
                        _buildInfoRow(
                          'Region: ',
                          country.region,
                        ),
                        const SizedBox(height: 6),
                        _buildInfoRow(
                          'Capital: ',
                          country.capital.join(
                            ', ',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, childCount: countrylist.length),
    );
  }

  Widget _buildInfoRow(
    String title,
    String value,
  ) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          height: 1.5, // کمی فاصله بین خطوط
        ),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ), // قسمت عنوان بولد می‌شه
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
