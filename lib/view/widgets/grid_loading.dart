import 'package:dairy_direct/view/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridLoadingWidget extends StatelessWidget {
  const GridLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 5, childAspectRatio: 0.8),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomContainer(
                height: 300,
                width: 100,
                borderColor:
                    Border.all(color: const Color.fromARGB(255, 229, 226, 226)),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          },
        ),
      ),
    );
  }
}
