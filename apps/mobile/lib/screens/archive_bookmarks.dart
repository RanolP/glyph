import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glyph/components/horizontal_divider.dart';
import 'package:glyph/components/post_card.dart';
import 'package:glyph/ferry/widget.dart';
import 'package:glyph/graphql/__generated__/archive_bookmarks_screen_query.data.gql.dart';
import 'package:glyph/graphql/__generated__/archive_bookmarks_screen_query.req.gql.dart';
import 'package:glyph/themes/colors.dart';

@RoutePage()
class ArchiveBookmarksScreen extends ConsumerWidget {
  const ArchiveBookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GraphQLOperation(
      operation: GArchiveBookmarksScreen_QueryReq(),
      builder: (context, client, data) {
        final posts = data.me!.bookmarkGroups.isNotEmpty
            ? data.me!.bookmarkGroups[0].posts.toList()
            : <GArchiveBookmarksScreen_QueryData_me_bookmarkGroups_posts>[];

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(
              posts[index],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            );
          },
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: HorizontalDivider(color: BrandColors.gray_50),
            );
          },
        );
      },
    );
  }
}
