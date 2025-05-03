import 'package:flutter/material.dart';
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight( 140),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    MyImages.logo,
                    height: 100,
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
                        width: 6,
                      ),
                      Text(
                        'Egypt, Cairo',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SearchBarWidget(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
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
                height: 8,
              ),
              BannerWidget(),
              SizedBox(
                height: 10,
              ),
              SectionLabel(
                  onTap: () {}, title: S.of(context).homeExclusiveOffer),
              SizedBox(
                height: 5,
              ),
              OfferSection(),
              SizedBox(
                height: 10,
              ),
              SectionLabel(onTap: () {}, title: "Products"),
              SizedBox(
                height: 5,
              ),
              BestSellingSection(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
