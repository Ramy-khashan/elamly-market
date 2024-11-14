import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/service_locator.dart';
import '../../../generated/l10n.dart';

import '../../search/view/search_screen.dart';
import '../controller/home_cubit.dart';
import 'widgets/banner.dart';
import 'widgets/best_selling_section.dart';
import 'widgets/offer_section.dart';
import 'widgets/section_label.dart';

import '../../../core/components/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(110.h),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(MyImages.carrot),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        MyImages.locationIcon,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        'Egypt, Cairo',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SearchBarWidget(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>SearchScreen()));
                    },
                  )
                ],
              ),
            )),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          sl<HomeCubit>().getAds();
          sl<HomeCubit>().getProductMostSelling();
          sl<HomeCubit>().getProductOnOffer();
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 8.h,
              ),
              BannerWidget(),
              SizedBox(
                height: 10.h,
              ),
              SectionLabel(
                  onTap: () {}, title: S.of(context).homeExclusiveOffer),
              SizedBox(
                height: 5.h,
              ),
              OfferSection(),
              SizedBox(
                height: 10.h,
              ),
              SectionLabel(onTap: () {}, title: S.of(context).homeBestSelling),
              SizedBox(
                height: 5.h,
              ),
              BestSellingSection(),
              SizedBox(
                height: 10.h,
              ),
              // SectionLabel(onTap: () {}, title: S.of(context).homeGroceries),
              // SizedBox(
              //   height: 5.h,
              // ),
              // GroceriesSec/tion()
            ],
          ),
        ),
      ),
    );
  }
}
