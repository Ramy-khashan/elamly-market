import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/core/utils/contact_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/home_cubit.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import '../../../../core/utils/service_locator.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final controller = sl<HomeCubit>();
        return controller.isLoadingAds
            ? LoadingItem()
            : controller.adsItems.isEmpty
                ? SizedBox()
                : SizedBox(
                    height: 220,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: controller.adsItems[index].url == null ||
                                  controller.adsItems[index].url!.isEmpty
                              ? null
                              : () {
                                  Contact.launchSite(controller
                                      .adsItems[index].url
                                      .toString());
                                },
                          child: FancyShimmerImage(
                            imageUrl: controller.adsItems[index].image!,
                            boxFit: BoxFit.fill,
                          ),
                        );
                      },
                      autoplay: controller.adsItems.length == 1 ? false : true,
                      itemCount: controller.adsItems.length,
                      pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Theme.of(context).primaryColor,
                          )),
                    ),
                  );
      },
    );
  }
}
