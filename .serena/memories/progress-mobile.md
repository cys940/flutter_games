# Dashboard UI Implementation Progress

## Current Status
- Analyzed existing `home_page.dart` and found it uses `CustomScrollView`, `SliverAppBar`, `GlassPanel`, and `GoRouter`.
- `GlassPanel` is well-suited for Glassmorphism and will be leveraged.
- Game data is fetched via `HomeViewModel` using `GetGamesUseCase`, which returns `List<GameEntity>`.

## Refactoring Plan
1.  **Modify `HomePage` `build` method**:
    *   Keep `_buildBackgroundDeco` and `_buildSliverHeader`.
    *   Keep `_buildSearchBar`.
    *   Modified `_buildMainContent` to be a `SliverGrid.builder` that displays `_GameDashboardCard` widgets.
    *   Keep `_buildBottomNav`.

2.  **Created `_GameDashboardCard` widget**:
    *   Renamed `_TrendingCard` to `_GameDashboardCard`.
    *   Modified its constructor to accept a `GameEntity` object.
    *   Updated its UI to display `GameEntity`'s properties (title, icon, etc.).
    *   Ensured it uses `GlassPanel` internally.
    *   Added `GestureDetector` for navigation using `GoRouter`, pushing to a dynamic route based on `GameEntity`.

3.  **Updated `_buildMainContent`**:
    *   Changed `Column` to `SliverPadding` containing `SliverGrid.builder`.
    *   Used `widget.viewModel.games.value` to populate the `SliverGrid.builder`.
    *   Calculated `crossAxisCount` dynamically based on `isMobile` from `ResponsiveLayout`.

4.  **Removed Unused Code**: Deleted `_buildFeaturedCard`, `_buildEngineCard`, `_buildRecentOpsList`, `_buildTrendingGrid`, and `_buildSectionHeader`. Also removed `NeonButton` import.

## Routing Updates
- Added a new `GoRoute` for `/game/:id` in `lib/core/router/app_router.dart`.
- Created a placeholder `GameDetailPage` widget in `lib/features/home/presentation/pages/game_detail_page.dart` to handle the new route.
- Added necessary import for `GameDetailPage` in `app_router.dart`.