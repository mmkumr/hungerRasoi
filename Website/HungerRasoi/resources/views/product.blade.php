@extends ('layout')

@section ('title', $product->name)

@section ('content')

	<!--================Single Product Area =================-->
	<div class="product_image_area" style = "padding-top: 150px">
		<div class="container">
			<div class="row s_product_inner">
                <div class="col-lg-6  col-md-6 col-sm-6">
                @if (session()->has('success_message'))
                    <div class="alert alert-success">
                        {{ session()->get('success_message') }}
                    </div>
                @endif

                @if (count($errors) > 0)
                <div class="alert alert-danger">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
                @endif
                    @if ($product->images)
                    <div class="s_Product_carousel">
                    @else
                    <div>
                    @endif
                        <div class="single-prd-item">
                                <img class="img-fluid" src="{{ productImage($product->image) }}" alt=""style = "height: 300px">
                        </div>
                        @if ($product->images)
                            @foreach (json_decode($product->images, true) as $image)
                                <div class="single-prd-item">
                                    <img class="img-fluid" src="{{ productImage($image) }}" alt=""style = "height: 500px">
                                </div>
                            @endforeach
                        @endif
					</div>
				</div>
                <div class="col-lg-5 offset-lg-1"> 
					<div class="s_product_text">
						<h3>{{ $product->name }}</h3>
						@if ($categories->where('id', $cid)->first()->name == 'Cakes')
						<h2>Select weight to display the price.</h2>
						@else
                        			<h2>{{ $product->presentPrice() }}</h2> 
                        			@endif
						<ul class="list">
                            <li><span>Category</span> : {{$categories->where('id', $cid)->first()->name}}</li>
                            <li><span>{{$product->details}}</li>
							<li><span>Availibility</span> : {!! $stockLevel !!}</li>
						</ul>
			                            
                        		
                        <div class="card_area d-flex align-items-center">
                        @if ($product->quantity > 0)
                        <form action="{{ route('cart.store', $product) }}" method="POST" id = "cart">
				@if ($categories->where('id', $cid)->first()->name == 'Cakes')	
				<div>	
					<select name="weight" onchange="document.getElementsByTagName('h2')[0].innerHTML = '₹' + ({{ trim($product->presentPrice(), '₹') }} * parseFloat(document.getElementsByName('weight')[0].value)); document.getElementsByClassName('primary-btn')[0].style.display = 'block'">
					    <option>Weight of the cake</option>
					    @foreach ($product->weights()->orderby('id')->get() as $weight)
						<option value = {{$weight['id']}}>{{$weight['weight']}} kg</option>
					    @endforeach 
					</select>
				</div>
				@endif
                                {{ csrf_field() }}
                        </form> 
				    @if ($categories->where('id', $cid)->first()->name == 'Cakes')
				    <a class="primary-btn" href="#" onclick="document.getElementById('cart').submit()" style='display:none'>Add to Cart</a>
				    @else
				    <a class="primary-btn" href="#" onclick="document.getElementById('cart').submit()">Add to Cart</a>
				    @endif
                            @endif
                        </div>

                        <label for="referral id">Copy the below text and send us as message/WhatsApp to our official phone no. 8337908779. We will call you as soon as possible.</label>
                        <input type="text" class="form-control" id="referral id" name="referral id" value="Queries related to the product which has product id '{{ $product->id }}'."readonly style = "margin-bottom:10px">
                        <a class="primary-btn" href="https://api.whatsapp.com/send?phone=918337908779&text=Queries related to the product which has product id '{{ $product->id }}'.">Send to WhatsApp</a>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!--================End Single Product Area =================-->
@if ($product->description != '--')
	<!--================Product Description Area =================-->
	<section class="product_description_area">
		<div class="container">
		    <h1>Description</h1>	
            <p>{{$product->description}}</p>
        </div>
	</section>
    <!--================End Product Description Area =================-->
@endif
	<!-- Start related-product Area -->
	<section class="related-product-area section_gap_bottom" style = "padding-top:30px">
		<div class="container">
            <h2 align = 'center'>Might Also Like to Purchase.</h2>
			<div class="row" style = "padding-top:20px">
				<div class="col-lg-12">
					<div class="row">
                    @foreach ($mightAlsoLike as $product)
						<div class="col-lg-4 col-md-4 col-sm-6 mb-20">
							<div class="single-related-product d-flex">
								<a href="{{ route('shop.show', $product->slug) }}"><img src="{{ productImage($product->image) }}" alt=""width="100px" height="100px"></a>
								<div class="desc">
									<a href="{{ route('shop.show', $product->slug) }}" class="title">{{ $product->name }}</a>
									<div class="price">
                                        <h6>{{ $product->presentPrice() }}</h6>
                                        <h6 class="l-through">₹{{ trim($product->presentPrice(), '₹') + 10}}</h6>
									</div>
								</div>
							</div>
                        </div>
                        @endforeach
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End related-product Area -->

@endsection
