import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/features/layout/data/models/categories_model/categories_model.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/views/screens/categories_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoriesModel> categories =
        LayoutCubit.get(context).categories;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesDetailsScreen(
                                  categoriesId: category.id!)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl:
                                category.image!,
                                fit: BoxFit.fill,
                                placeholder:(context, url) => CircularProgressIndicator() ,
                                errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
                              
                            ),
                          ),
                          Text(
                            category.name!,
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })));
  }
}
