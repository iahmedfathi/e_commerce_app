import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';

class BannersSection extends StatelessWidget {
  const BannersSection({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
      final cubit = LayoutCubit.get(context);

      final banners = cubit.bannerModels;
      log("Displaying ${banners.length} banners");

      return SizedBox(
        height: 150,
        width: double.infinity,
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
          controller: controller,
          itemCount: banners.length,
          itemBuilder: (context, index) {
            final banner = banners[index];
            return Container(
              margin: EdgeInsets.only(right: 4),
              child: banner.image != null
                  ? Image.network(
                      banner.image!,
                      fit: BoxFit.fill,
                    )
                  : Center(child: Text("No Image Available")),
            );
          },
        ),
      );
    });
  }
}
