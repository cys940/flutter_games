The `AppRouter` in `lib/core/router/app_router.dart` already has a correctly implemented authentication guard.

The existing `redirect` logic:
- Utilizes `AuthRepository` to determine the current user's authentication status.
- Successfully redirects unauthenticated users attempting to access any route (other than `/login`) to the `/login` page.
- Prevents authenticated users from navigating to the `/login` page by redirecting them to the home page (`/`).

Therefore, no modifications were required for `lib/core/router/app_router.dart` to implement the Auth Guard as it was already in place and functioning as described in the requirements.