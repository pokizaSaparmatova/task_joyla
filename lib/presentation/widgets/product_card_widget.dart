import 'package:flutter/material.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/data/model/joyla_model.dart';
import 'package:task/presentation/page/product_detail_screen.dart';
import 'package:task/presentation/widgets/product_cache_image_widget.dart';


class ProductCard extends StatelessWidget {
  final String imagUrl;
  final String name;
  final String price;
  final String currencyType;
  final String type;


  const ProductCard({super.key, required this.imagUrl, required this.name, required this.price, required this.currencyType, required this.type});




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //    builder: (context) => PersonDetailPage(),
        //  ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ProductCacheImage(
              width: 166,
              height: 166,
              imageUrl: imagUrl,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          '${price}  ${currencyType}',
                          style: const TextStyle(color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    type,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
