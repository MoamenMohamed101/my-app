import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_app/layout/shop_app/cubit/states.dart';
import 'package:first_app/models/shop_app/favorites_model.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, states) => ConditionalBuilder(
        builder: (BuildContext context) => ListView.separated(
            itemBuilder: (context, index) => buildFavoriteItem(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product!,
                context),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    width: double.infinity,
                  ),
                ),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length),
        fallback: (BuildContext context) =>
            const Center(child: CircularProgressIndicator()),
        condition: states is! ShopLoadingGetFavoritesStates,
      ),
      listener: (context, states) {},
    );
  }

  buildFavoriteItem( data, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(data.profileImage!),
                    width: 120,
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                  if (data.discount != 0)
                    Container(
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                    ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          data.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15, color: primryswatsh),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (data.discount != 0)
                          Text(
                            data.oldPrice.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(data.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[data.id]!
                                    ? primryswatsh
                                    : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
