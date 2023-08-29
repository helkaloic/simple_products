import 'package:go_router/go_router.dart';
import 'package:simple_products/models/product_model.dart';
import 'package:simple_products/utils/navigator.dart';
import 'package:simple_products/views/bookmark/bookmark_view.dart';
import 'package:simple_products/views/home/product_add_view.dart';
import 'package:simple_products/views/home/product_update_view.dart';
import 'package:simple_products/views/home/product_list_view.dart';
import 'package:simple_products/views/main_screen.dart';
import 'package:simple_products/views/search/search_view.dart';

part 'routes.dart';

final navigationKey = NavigatorService.instance.navigationKey;

final GoRouter router = GoRouter(
  initialLocation: AppRoute.home,
  navigatorKey: navigationKey,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: navigationKey,
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.home,
              builder: (context, state) => const ProductListView(),
            ),
            GoRoute(
              path: AppRoute.addProduct,
              builder: (context, state) => const ProductAddView(),
            ),
            GoRoute(
              path: AppRoute.updateProduct,
              builder: (context, state) => ProductUpdateView(
                product: state.extra as ProductModel,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.search,
              builder: (context, state) => const SearchView(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.bookmark,
              builder: (context, state) => const BookmarkView(),
            )
          ],
        ),
      ],
      builder: (context, state, navigationShell) =>
          MainScreen(nagivationShell: navigationShell),
    )
  ],
);
