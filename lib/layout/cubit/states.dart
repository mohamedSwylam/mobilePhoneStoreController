abstract class StoreAppStates {}

class StoreAppInitialState extends StoreAppStates {}

class StoreAppBottomBarChangeState extends StoreAppStates {}

class StoreAppBottomBarSearchState extends StoreAppStates {}

class StoreAppChangeThemeModeState extends StoreAppStates {}

class StoreAppAddToCartSuccessState extends StoreAppStates {}

class StoreAppReduceCartItemByOneSuccessState extends StoreAppStates {}

class StoreAppClearCartSuccessState extends StoreAppStates {}

class StoreAppRemoveCartItemSuccessState extends StoreAppStates {}

class StoreAppClearWishListSuccessState extends StoreAppStates {}

class StoreAppRemoveWishListItemSuccessState extends StoreAppStates {}

class StoreAppAddItemToWishListSuccessState extends StoreAppStates {}

class StoreAppSearchQuerySuccessState extends StoreAppStates {}

class StoreAppPickedProfileImageSuccessState extends StoreAppStates {}

class StoreAppPickedProfileImageErrorState extends StoreAppStates {}

class UploadProfileImageLoadingState extends StoreAppStates {}

class UploadPickedProfileImageSuccessState extends StoreAppStates {}

class UploadPickedProfileImageErrorState extends StoreAppStates {}

class StoreAppPickedProfileImageCameraSuccessState extends StoreAppStates {}

class StoreAppRemoveProfileImageSuccessState extends StoreAppStates {}

class StoreAppChangeUploadProductCategorySuccessState extends StoreAppStates {}

class StoreAppChangeUploadProductBrandSuccessState extends StoreAppStates {}

class StoreAppChangeUploadProductIsPopularSuccessState extends StoreAppStates {}
class CreateProductSuccessState extends StoreAppStates {}


class CreateProductErrorState extends StoreAppStates {
  final String error;

  CreateProductErrorState(this.error);
}
class GetProductLoadingStates extends StoreAppStates {}

class GetProductSuccessStates extends StoreAppStates {}

class GetProductErrorStates extends StoreAppStates {}

class RemoveProductLoadingStates extends StoreAppStates {}

class RemoveProductSuccessStates extends StoreAppStates {}

class StoreAppInputPriceSuccessState extends StoreAppStates {}




class RemoveProductErrorStates extends StoreAppStates {}