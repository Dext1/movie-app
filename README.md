# movie-app


Mobile application where user can search for movies and TV-series. These will be displayed on a list where user can click on an individual item for more information. Uses OMDb API (http://www.omdbapi.com).

Target: iOS/Swift

- User can search for movies and results are displayed on a list.
- User can click on list items and display additional info in a separate view.
- User can search for movies and series in their own tabs.

Known bugs:
- User can only view first 10 items (no pagination).
- Doesn't hide searchbar on first transition to detailed view after startup.
- Doesn't hide tabs on detailed view.
- Clicking on tabs in detailed view can break view hierarchy.
