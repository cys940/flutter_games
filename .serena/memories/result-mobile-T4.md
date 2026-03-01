## Task T4: GameCard Component Creation

### Objective:
Extracted `_GameDashboardCard` from `home_page.dart` into a standalone `GameCard` component, enhancing its styling and integrating it back into the home page.

### Changes Made:

1.  **File Creation**: Created `lib/features/home/presentation/widgets/game_card.dart`.
2.  **Widget Extraction and Renaming**:
    *   The `_GameDashboardCard` widget and its corresponding state (`_GameDashboardCardState`) were moved from `lib/features/home/presentation/pages/home_page.dart` to the newly created `game_card.dart`.
    *   The widget and its state were renamed to `GameCard` and `_GameCardState` respectively, aligning with standard widget naming conventions.
3.  **Styling Enhancements**:
    *   **Hover Animation**: Implemented a scaling hover effect using `SingleTickerProviderStateMixin`, `AnimationController`, `Tween<double>`, `CurvedAnimation`, `MouseRegion`, `GestureDetector`, `AnimatedBuilder`, and `Transform.scale`. The card now scales up slightly when hovered over, providing a more interactive user experience.
    *   **Glassmorphism Effects**: The existing `GlassPanel` was utilized, and color opacities were standardized using `withOpacity` for consistency and clarity.
    *   **Thumbnail Integration**: Ensured `widget.game.thumbnailPath` is correctly used for displaying game images, with a fallback icon (`Icons.videogame_asset`) in case of image loading errors.
4.  **Integration**:
    *   `lib/features/home/presentation/pages/home_page.dart` was updated to import `game_card.dart`.
    *   The usage of `_GameDashboardCard(game: game)` within the `_buildMainContent` method of `home_page.dart` was replaced with `GameCard(game: game)`.

These changes successfully modularized the game card UI, improved its visual appeal with animations, and maintained data integrity by correctly using `GameEntity` properties.