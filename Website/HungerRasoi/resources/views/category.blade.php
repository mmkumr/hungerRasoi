@extends ('layout')
@section ('title', 'shop')

@section ('content')
    <div class="container" style = 'padding-top: 150px;padding-bottom: 30px;'>
                @if (session()->has('success_message'))
                <div class="alert alert-success">
                    {{ session()->get('success_message') }}
                </div>
                @endif

                @if(count($errors) > 0)
                <div class="alert alert-danger">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
                @endif

        <div class="row">
			<div class="col-xl-3 col-lg-4 col-md-5">
				<div class="sidebar-categories">
					<div class="head">Browse Categories</div>
					<ul class="main-categories">
						@foreach ($categories as $category)
                        <li class="main-nav-list child"><a href="{{ route('shop.index', ['category' => $category->slug]) }}">{{ $category->name }}<span class="number">({{$productcount($category->id)}})</span></a></li>
                        @endforeach </ul>
				</div>
			</div>
			<div class="col-xl-9 col-lg-8 col-md-7">
				<!-- Start Filter Bar -->
				<div class="filter-bar d-flex flex-wrap align-items-center ">
					<div class="sorting">
                        <select onchange="if(this.value == 1){
                                                                window.location.href = '{{ route('shop.index', ['category'=> request()->category, 'sort' => 'low_high']) }}'
                                                             }
                                          else {
                                                    window.location.href = '{{ route('shop.index', ['category'=> request()->category, 'sort' => 'high_low']) }}'
                                                }">
							<option value="1">Price: Low to High</option>
							<option value="2">Price: Higt to Low</option>
						</select>
					</div>
				</div>
				<!-- End Filter Bar -->
                <!-- Start Best Seller -->
                <section class="lattest-product-area pb-40 category-list">
                    <div class="row">
                    @php ($i = 0)
                    @foreach ($products as $product)
						<!-- single product -->
						<div class="col-lg-4 col-md-6">
                            <div class="single-product">
                                <a href="{{ productImage($product->image) }}" class="img-pop-up" target="_blank">
                                    <img src="{{ productImage($product->image) }}" alt="" width="200px" height="200px">
								</a>
								<!--<a href="{{ route('shop.show', $product->slug) }}"><img src="{{ productImage($product->image) }}" alt="" width="200px" height="200px"></a> -->
								<div class="product-details">
									<a href="{{ route('shop.show', $product->slug) }}"><h6>{{ $product->name }}</h6></a>
                                    <div class="price">
                                        @if ($product->quantity == 0)
                                            {{ "Out of stock" }}</br>
                                        @else
                                            {{ "In stock" }}</br>
                                        @endif
                                        {{ $product->details }}</br>
                                        <h6>{{ $product->presentPrice() }}</h6>
                                    </div>
                                    <form action="{{ route('cart.store', $product) }}" method="POST" class = "link-form-bag">
                                        {{ csrf_field() }}
                                    </form>
									<div class="prd-bottom">
										@if (request()->category != "cakes")
										<a href="javascript:document.getElementsByClassName('link-form-bag')[{{$i}}].submit()"  class="social-info">
											<span class="ti-bag"></span>
											<p class="hover-text">add to bag</p>
										@endif
										</a>
										<a href="{{ route('shop.show', $product->slug) }}" class="social-info">
											<span class="lnr lnr-move"></span>
											<p class="hover-text">view more</p>
										</a>
									</div>
								</div>
							</div>
                        </div>
                        @php ($i = $i + 1)
                    @endforeach  
                </section>
                <div class="spacer"></div>
                    {{ $products->appends(request()->input())->links() }}
			</div>
		</div>
	</div>
@endsection
