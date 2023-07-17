import 'package:flutter/material.dart';
import 'package:henry_flutter_news/core/clippers/oval_bottom_clipper.dart';
import 'package:henry_flutter_news/core/colors.dart';
import 'package:henry_flutter_news/features/news/domain/entities/news.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final News news;

  const DetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: OvalBottomClipper(),
                child: Container(
                  height: size.height / 2.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.multiply),
                        fit: BoxFit.cover,
                        image: news.urlToImage != null
                            ? NetworkImage(news.urlToImage!)
                            : const AssetImage(
                                    'assets/images/breaking_news.png')
                                as ImageProvider),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: Colours.kTextColorOnDark),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        news.description != null
                            ? Text(
                                news.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colours.kTextColorOnDark),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height / 2,
            width: size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMEEEEd().format(news.publishedDate),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    news.author != null
                        ? Text(
                            news.author!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey[700]),
                          )
                        : const SizedBox(
                            height: 16,
                          ),
                    Text(
                      news.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    news.content != null
                        ? Text(
                            news.content!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
