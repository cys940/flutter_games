Task: Implement Auth Guard in AppRouter
Status: Completed

The `app_router.dart` file already contains the `redirect` logic that fulfills the requirements.
- It uses `AuthRepository` to check the user's session.
- It redirects unauthenticated users to `/login` for all routes except `/login`.
- It redirects authenticated users from `/login` to `/`.

No code changes are needed as the functionality is already implemented.