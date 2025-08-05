import 'package:flutter/material.dart';

import '../../../components/components.dart';

class DashboardLoadingPage extends StatelessWidget {
  const DashboardLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: _HeaderSkeleton(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: _QuickTasksSkeleton(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
                child: _TaskGroupsHeaderSkeleton(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(24),
              sliver: _TaskGroupsGridSkeleton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSkeleton extends StatelessWidget {
  const _HeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerContainer(width: 80, height: 24),
            SizedBox(height: 8),
            ShimmerContainer(width: 120, height: 32),
          ],
        ),
        ShimmerContainer(width: 64, height: 64, borderRadius: 32),
      ],
    );
  }
}

class _QuickTasksSkeleton extends StatelessWidget {
  const _QuickTasksSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerContainer(width: 200, height: 28),
        SizedBox(height: 16),
        ShimmerContainer(width: double.infinity, height: 68),
        SizedBox(height: 8),
        ShimmerContainer(width: double.infinity, height: 68),
        SizedBox(height: 8),
        ShimmerContainer(width: double.infinity, height: 68),
      ],
    );
  }
}

class _TaskGroupsHeaderSkeleton extends StatelessWidget {
  const _TaskGroupsHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShimmerContainer(width: 220, height: 28),
        ShimmerContainer(width: 32, height: 32, borderRadius: 16),
      ],
    );
  }
}

class _TaskGroupsGridSkeleton extends StatelessWidget {
  const _TaskGroupsGridSkeleton();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 2;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => const ShimmerContainer(
          width: double.infinity,
          height: double.infinity,
          borderRadius: 20,
        ),
        childCount: 6,
      ),
    );
  }
}
