import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glyph/components/horizontal_divider.dart';
import 'package:glyph/components/post_card.dart';
import 'package:glyph/ferry/widget.dart';
import 'package:glyph/graphql/__generated__/archive_comments_screen_query.req.gql.dart';
import 'package:glyph/themes/colors.dart';

@RoutePage()
class ArchiveCommentsScreen extends ConsumerWidget {
  const ArchiveCommentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GraphQLOperation(
      operation: GArchiveCommentsScreen_QueryReq(),
      builder: (context, client, data) {
        final posts = data.me!.comments.map((e) => e.post).nonNulls.toList();

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
