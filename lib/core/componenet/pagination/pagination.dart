sealed class Pagination<T> {
  final List<T> data;
  int page = 1;
  Pagination(this.data);
}

class NotInitialized<T> extends Pagination<T> {
  NotInitialized(super.data);
}

class RefreshingPage<T> extends Pagination<T> {
  RefreshingPage(super.data){
    page = 1;
  }
}

class LoadingMorePage<T> extends Pagination<T> {
  LoadingMorePage(super.data){
    page++;
  }
}

class Loaded<T> extends Pagination<T> {
  Loaded(super.data);
}

class AllLoaded<T> extends Pagination<T> {
  AllLoaded(super.data);
}

