import 'package:admin/Application/Presentation/screens/Home/widgets/search_widget.dart';


import 'package:admin/Data/service/product/product_functions.dart';


import 'package:admin/Domain/models/product/get%20product%20model/get_product_model.dart';


import 'package:admin/Domain/models/product/add%20product%20model/product_model.dart';


import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';


part 'product_event.dart';


part 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {

  List<GetProductModel>? allProducts;


  ProductBloc() : super(LoadingProductState()) {

    on<FetchProductsEvent>((event, emit) async {

      try {

        List<GetProductModel> products = await getProducts();


        allProducts = products;


        emit(LoadededProductState(products));

      } catch (e) {

        emit(ErrorProductState('Error Fetching Categories $e'));

      }

    });


    on<SearchProductsEvent>((event, emit) async {

      try {

        List<GetProductModel> searchResults =

            await getSearchedProducts(event.query);


        emit(SearchProductsState(searchResults: searchResults));

      } catch (e) {

        emit(ErrorProductState('Error Searching Products $e'));

      }

    });

  }

}

