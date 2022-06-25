import 'package:first_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const Image(
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://img.freepik.com/free-photo/full-positive-emotions-glad-guy-red-hat-with-red-thick-beard-openes-mouth-widely-excitement_295783-15774.jpg?w=1060')),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    'communicate with friends',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => builderItem(context),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 10),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  builderItem(context) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/success-celebration-excitement-victory-concept-cheerful-senior-man-with-thick-beard-clenching-fists-screaming-yes_343059-4057.jpg?w=1060'),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('Moamen Mohamed'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 20,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'January 21 , 2021 at 11:00 pm',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz, size: 16),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
              ),
              Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  style: Theme.of(context).textTheme.subtitle1),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '#software',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue),
                            ),
                            padding: EdgeInsets.zero,
                            minWidth: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '#Flutter',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.blue),
                            ),
                            padding: EdgeInsets.zero,
                            minWidth: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-photo/full-positive-emotions-glad-guy-red-hat-with-red-thick-beard-openes-mouth-widely-excitement_295783-15774.jpg?w=1060'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: const [
                              Icon(IconBroken.Heart,
                                  size: 20, color: Colors.red),
                              SizedBox(
                                width: 5,
                              ),
                              Text('120'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(IconBroken.Chat,
                                  size: 20, color: Colors.amber),
                              SizedBox(
                                width: 5,
                              ),
                              Text('120 comment'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-photo/success-celebration-excitement-victory-concept-cheerful-senior-man-with-thick-beard-clenching-fists-screaming-yes_343059-4057.jpg?w=1060'),
                            radius: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'write a comment....',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(IconBroken.Heart, size: 20, color: Colors.red),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}