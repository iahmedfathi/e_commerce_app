import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/features/layout/presentation/views/screens/product_details_screen.dart';
import 'package:shop_app/features/layout/presentation/views/widgets/price_widget.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.price,
      required this.oldPrice,
      this.onTap,
      required this.isFavorite,
      this.onPressed,
      required this.inCart,
      required this.productId});
  final String image;
  final String title;
  final String price;
  final String oldPrice;
  final void Function()? onTap;
  final bool isFavorite;
  final void Function()? onPressed;
  final bool inCart;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Expanded(
              child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(productId: productId),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.fill,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.red),
              ),
            ),
          )),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.mainColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PriceWidget(
                price: price,
                oldPrice: oldPrice,
              ),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.favorite,
                  size: 20,
                  color: isFavorite ? Colors.red : AppColors.mainColor,
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: inCart ? Colors.red : AppColors.mainColor,
              ),
              child: Center(
                child: Text(
                  'add to cart',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
