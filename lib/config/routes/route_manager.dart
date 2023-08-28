import 'package:go_router/go_router.dart';
import 'package:simple_products/utils/navigator.dart';
import 'package:simple_products/views/product_add_view.dart';
import 'package:simple_products/views/product_detail_view.dart';
import 'package:simple_products/views/product_list_view.dart';

part 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoute.home,
  navigatorKey: NavigatorService.instance.navigationKey,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoute.home,
      builder: (context, state) => const ProductListView(),
    ),
    GoRoute(
      path: AppRoute.addProduct,
      builder: (context, state) => const ProductAddView(),
    ),
    GoRoute(
      path: AppRoute.productDetail,
      builder: (context, state) => const ProductDetailView(),
    ),
  ],
);
