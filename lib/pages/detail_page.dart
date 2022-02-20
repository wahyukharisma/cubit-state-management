import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_state.dart';
import 'package:flutter_cubit/cubit/app_cubits.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/widgets/app_buttons.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';
import 'package:flutter_cubit/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStarts = 3;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
      builder: ((context, state) {
        if (state is DetailState) {
          var data = state.place;
          return Scaffold(
            body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://mark.bslmeiyu.com/uploads/" + data.img),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 50,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AppCubits>(context).goHome();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 320,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      //TODO: learn about media query
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(
                                text: data.name,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              AppLargeText(
                                text: "\$ " + data.price.toString(),
                                color: AppColors.mainColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(width: 4),
                              AppText(
                                text: data.location,
                                color: AppColors.textColor1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(
                                  5,
                                  (index) {
                                    return Icon(
                                      Icons.star,
                                      color: index < data.stars
                                          ? AppColors.starColor
                                          : AppColors.textColor2,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              AppText(
                                text: "(${data.stars}.0)",
                                color: AppColors.textColor2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AppLargeText(
                            text: "People",
                            size: 20,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          AppText(
                            text: "Number of people in your group",
                            size: 14,
                            color: AppColors.mainTextColor,
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            children: List.generate(
                              5,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: AppButtons(
                                      size: 50,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                      backgroundColor: selectedIndex == index
                                          ? Colors.black
                                          : AppColors.buttonBackground,
                                      borderColor: selectedIndex == index
                                          ? Colors.black
                                          : AppColors.buttonBackground,
                                      text: (index + 1).toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 24),
                          AppLargeText(
                            text: "Description",
                            size: 20,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(height: 10),
                          AppText(
                            text: data.description,
                            color: AppColors.mainTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        AppButtons(
                          size: 60,
                          color: AppColors.textColor2,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.textColor2,
                          isIcon: true,
                          icon: Icons.favorite_border,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ResponsiveButton(
                          isResponsive: true,
                          text: "Book Trip Now",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
