import 'package:flutter/material.dart';

import '../../../components/components.dart';

class SettingsLoadingPage extends StatelessWidget {
  const SettingsLoadingPage({super.key});

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
                child: _AccountSkeleton(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
                child: _AccountSkeleton(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
                child: _AccountSkeleton(),
              ),
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
    return Column(
      children: [
        ShimmerContainer(width: 104, height: 104, borderRadius: 52),
        const SizedBox(height: 16),
        ShimmerContainer(width: 100, height: 24),
        const SizedBox(height: 4),
        ShimmerContainer(width: 200, height: 24),
      ],
    );
  }
}

class _AccountSkeleton extends StatelessWidget {
  const _AccountSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerContainer(width: 80, height: 24),
        const SizedBox(height: 8),
        ShimmerContainer(width: double.infinity, height: 112, borderRadius: 8),
      ],
    );
  }
}
