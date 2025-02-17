import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/my_colors.dart';
 import '../../../config/app/app_cubit.dart';
import '../../../core/utils/my_string.dart';
import '../controller/account_cubit.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (context) => AccountCubit()..getUserData(),
      child: Scaffold(
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            final controller = AccountCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle,),
                            width: 80,
                            height: 80,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                             child: FancyShimmerImage(
                                imageUrl: controller.image ?? ""),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  controller.name ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.email ?? "",
                              style: TextStyle(color: MyColors.greyColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => Card(
                              margin: EdgeInsets.only(bottom: 5),
                              elevation: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => controller
                                            .accountItems[index].page!,
                                      ));
                                },
                                leading:
                                    Icon(controller.accountItems[index].icon),
                                title: Text(
                                    controller.accountItems[index].title,
                                    style: TextStyle(
                                        fontFamily: MyStrings.fontFamily,
                                        fontWeight: FontWeight.bold)),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                        itemCount: controller.accountItems.length),
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        AppCubit appController = AppCubit.get(context);
                        return Card(
                          margin: EdgeInsets.only(bottom: 5),
                          elevation: 2,
                          child: ListTile(
                            onTap: () {
                              appController.toggelBritness(
                                  isDark:
                                      !(appController.isDarkTheme ?? false));
                            },
                            leading: Icon(Icons.dark_mode),
                            title: Text("Dark Mode",
                                style: TextStyle(
                                    fontFamily: MyStrings.fontFamily,
                                    fontWeight: FontWeight.bold)),
                            trailing: CupertinoSwitch(
                                value: appController.isDarkTheme!,
                                onChanged: (val) {
                                  appController.toggelBritness(isDark: val);
                                }),
                          ),
                        );
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 4.0, vertical: 10),
                    //   child: Row(children: [
                    //     Expanded(
                    //       flex: 8,
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               backgroundColor: Theme.of(context).cardColor,
                    //               elevation: 5),
                    //           onPressed: () {
                    //             // context.setLocale(const Locale('en', 'US'));
                    //           },
                    //           child: Padding(
                    //             padding: EdgeInsets.symmetric(
                    //                 vertical: 3, horizontal: 5),
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   MyImages.ar,
                    //                   width: 80,
                    //                   height: 50,
                    //                 ),
                    //                 const Spacer(),
                    //                 Text("عربي",
                    //                     style: TextStyle(
                    //                         fontFamily: MyStrings.fontFamily,
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Theme.of(context)
                    //                                     .brightness
                    //                                     .index ==
                    //                                 1
                    //                             ? MyColors.blackColor
                    //                             : Colors.white)),
                    //               ],
                    //             ),
                    //           )),
                    //     ),
                    //     const Spacer(),
                    //     Expanded(
                    //       flex: 8,
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               backgroundColor: Theme.of(context).cardColor,
                    //               elevation: 5),
                    //           onPressed: () {
                    //             // context.setLocale(const Locale('en', 'US'));
                    //           },
                    //           child: Padding(
                    //             padding: EdgeInsets.symmetric(
                    //                 vertical: 3, horizontal: 5),
                    //             child: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   MyImages.en,
                    //                   width: 80,
                    //                   height: 50,
                    //                 ),
                    //                 Spacer(),
                    //                 Text("English",
                    //                     style: TextStyle(
                    //                         fontFamily: MyStrings.fontFamily,
                    //                         fontWeight: FontWeight.bold,
                    //                         color: Theme.of(context)
                    //                                     .brightness
                    //                                     .index ==
                    //                                 1
                    //                             ? MyColors.blackColor
                    //                             : Colors.white)),
                    //               ],
                    //             ),
                    //           )),
                    //     ),
                    //   ]),
                    // ),

                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            controller.logOut();
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: MyColors.searchBarColor),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Icon(Icons.logout_outlined,
                                      color: MyColors.greenColor)),
                              Expanded(
                                  flex: 4,
                                  child: Center(
                                      child: Text(
                                    "Log out",
                                    style: TextStyle(
                                        color: MyColors.greenColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp),
                                  ))),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
