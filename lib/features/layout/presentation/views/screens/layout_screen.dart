import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/app_images.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/notifications/presentation/views/notification_view.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.thirdColor,
              title: SvgPicture.asset(
                Assets.imagesLogo,
                height: 40,
                width: 40,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationView()));
                    },
                    icon: Icon(Icons.notifications,size: 24,))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.setCurrentIndex(index: index);
              },
              selectedItemColor: AppColors.mainColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favorites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Profile"),
              
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
