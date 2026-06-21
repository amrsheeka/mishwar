import 'package:flutter/material.dart';
import 'package:see_more/see_more.dart';

Widget descriptionCard(BuildContext context, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
      Text("Description", style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      SeeMoreWidget(
        description!=''?description:'No Description',
        trimMode: TrimMode.line,
        maxLines: 2,
      ),
    ],
  );
}
