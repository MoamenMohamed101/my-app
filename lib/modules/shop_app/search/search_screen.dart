import 'package:first_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:first_app/modules/shop_app/search/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(SearchInitialState()),
      child: BlocConsumer<SearchCubit, SearchStates>(
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'search is empty';
                        }
                      },
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSucsessState)
                     Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildFavoriteItem(SearchCubit.get(context).searchModel!.data!.data![index], context , oldPrice: false),
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsetsDirectional.only(start: 10),
                            child: Container(
                              height: 1,
                              color: Colors.grey,
                              width: double.infinity,
                            ),
                          ),
                          itemCount:
                          SearchCubit.get(context).searchModel!.data!.data!.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, state) {},
      ),
    );
  }
  buildFavoriteItem( data, context , {oldPrice = false}) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(data.image!),
                width: 120,
                height: 120,
              ),
              if (data.discount != 0 && oldPrice)
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
                const Spacer(),
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
                    if (data.discount != 0 && oldPrice)
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
