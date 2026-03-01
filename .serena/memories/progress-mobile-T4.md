## Context
- Project: Flutter Cross-Platform Dashboard with Toy Games
- Pre-requisite: Task T3 (Dashboard UI) completed.
- Goal: Extract `_GameDashboardCard` from `home_page.dart` into a standalone `GameCard` component.

## Requirements
- Create `lib/features/home/presentation/widgets/game_card.dart`. (Completed)
- Move the logic from `_GameDashboardCard` in `home_page.dart` to this new file. (Completed)
- Enhance styling:
  - Better Glassmorphism effects. (Completed)
  - Hover animations (scaling up). (Completed)
  - Use `thumbnailPath` from `GameEntity`. (Completed)
- Update `home_page.dart` to use this new `GameCard` widget. (Completed)
