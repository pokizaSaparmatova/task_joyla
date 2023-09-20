import 'package:flutter/material.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/data/model/joyla_model.dart';
import 'package:task/presentation/widgets/product_cache_image_widget.dart';


class PersonDetailPage extends StatelessWidget {
   final Product product;

  const PersonDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ProductCacheImage(
              width: 260,
              height: 260,
              imageUrl:  'https://mobile-api.joyla.uz/mobile/${product.imageUrl}',
            ),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Container(
            //   child: PersonCacheImage(
            //     width: 260,
            //     height: 260,
            //     imageUrl: person.image,
            //   ),
            // ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(
          color: AppColors.greyColor,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
