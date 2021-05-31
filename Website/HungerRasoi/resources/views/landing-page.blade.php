@extends ('layout')
@section ('title', 'Home')
@section ('content')
<!-- start banner Area -->
<script>
    $('#myCarousel').carousel({
    interval: 3000,
    })
</script>
<!------ Include the above in your HEAD tag ---------->
<link href="https://raw.githubusercontent.com/daneden/animate.css/master/animate.css" rel="stylesheet">
<div id="myCarousel" class="carousel slide carousel-fade" data-ride="carousel" style="padding-top:150px">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <div class="mask flex-center">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-7 col-12 order-md-1 order-2">
                            <h7 style="font-size:40px; color:#FFFFFF">We are providing "use and throw" plates for PMEC students.</h7>
                        </div>
                        <div class="col-md-5 col-12 order-md-2 order-1"><img src="img/banner/banner1.jpg" class="mx-auto" alt="slide"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="mask flex-center">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-7 col-12 order-md-1 order-2">
                            <h7 style="font-size:40px; color:#FFFFFF">20% off on PMEC specials.</h7>
                        </div>
                        <div class="col-md-5 col-12 order-md-2 order-1"><img src="img/banner/banner2.jpg" class="mx-auto" alt="slide"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="mask flex-center">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-7 col-12 order-md-1 order-2">
                            <h7 style="font-size:40px; color:#FFFFFF">20% off on PMEC specials.</h7>
                        </div>
                        <div class="col-md-5 col-12 order-md-2 order-1"><img src="img/banner/banner3.jpg" class="mx-auto" alt="slide"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a> <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span> </a> 
</div>
<!--slide end--> 
<!-- start features Area -->
<section class="features-area section_gap">
    <div class="container">
        <div class="row features-inner">
            <!-- single features -->
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/features/f-icon3.png" alt=""height = 50px>
                    </div>
                    <h6>Additional Offers</h6>
                    <p>We provide cashbacks and coupons.</p>
                </div>
            </div>
            <!-- single features -->
            <div class="col-lg-3 col-md-4 col-sm-4">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/features/f-icon5.png" alt="" height = 50px>
                    </div>
                    <h6>Best quality</h6>
                    <p>We provide best quality products.</p>
                </div>
            </div>
            <!-- single features -->
            <div class="col-lg-3 col-md-4 col-sm-4">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/features/f-icon4.png" alt="">
                    </div>
                    <h6>Secure Payment</h6>
                    <p>Our website is encrypted for our security.</p>
                </div>
            </div>
            <!-- single features -->
            <div class="col-lg-3 col-md-4 col-sm-4">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/features/f-icon6.png" alt=""height = 50px>
                    </div>
                    <h6>Delivery timings</h6>
                    <p>12:30 PM to 02:00 PM</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end features Area -->
@php ( $i = 0 )
@php ( $col = array(0, 8, 4, 4, 8, 8, 4, 4, 8) )
<!-- Start category Area -->
<section class="category-area">
    <h1 align='center'>Categories</h1>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-12 col-md-12">
                <div class="row">
                    @foreach ($categories as $category)
                    @php ($i = $i + 1)
                    <a href="{{ route('shop.index', ['category' => $category->slug]) }}">
                        <div class="col-lg-8 col-md-8">
                            <div class="single-deal">
                                <div class="overlay"></div>
                                <img  src="img/category/{{$category->slug}}.jpg" class="img-fluid w-100" height='290' width='345'>
                                <div class="deal-details">
                                    <h6 class="deal-title">{{$category->name}}</h6>
                                </div>
                            </div>
                    </a>
                    </div>
                    @endforeach 
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End category Area -->
<!-- start product Area -->
<section class="section_gap">
    <!-- single product slide -->
    <div class="single-product-slider">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 text-center">
                    <div class="section-title">
                        <h1>Latest Products</h1>
                    </div>
                </div>
            </div>
            <div class="row">
                <!-- single product -->
                @php ($i = 0)
                @foreach ($latest as $product)
                <div class="col-lg-3 col-md-6">
                    <div class="single-product">
                        <a href="{{ route('shop.show', $product->slug) }}">
                        <img  src="{{ productImage($product->image) }}" alt="" width="200px" height="200px">
                        </a>
                        <div class="product-details">
                            <a href="{{ route('shop.show', $product->slug) }}">
                                <h6>{{$product->name}}</h6>
                            </a>
                            <div class="price">
                                @if ($product->quantity == 0)
                                {{ "Out of stock" }}</br>
                                @else
                                {{ "In stock" }}</br>
                                @endif
                                <h6>{{ $product->presentPrice() }}</h6>
                            </div>
                            <form action="{{ route('cart.store', $product) }}" method="POST" class = "link-form-bag">
                                {{ csrf_field() }}
                            </form>
                            <div class="prd-bottom">
                                <a href="javascript:document.getElementsByClassName('link-form-bag')[{{$i}}].submit()"  class="social-info">
                                    <span class="ti-bag"></span>
                                    <p class="hover-text">add to bag</p>
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
            </div>
        </div>
    </div>
    <!-- single product slide -->
    <div class="single-product-slider">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 text-center">
                    <div class="section-title">
                        <h1>HungerRasoi Specials</h1>
                    </div>
                </div>
            </div>
            <div class="row">
                @php ($j = $i - 1)
                @foreach ($special as $product)
                <!-- single product -->
                <div class="col-lg-3 col-md-6">
                    <div class="single-product">
                        <a href="{{ route('shop.show', $product->slug) }}">
                        <img  src="{{ productImage($product->image) }}" alt="" width="200px" height="200px">
                        </a>
                        <div class="product-details">
                            <a href="{{ route('shop.show', $product->slug) }}">
                                <h6>{{$product->name}}</h6>
                            </a>
                            <div class="price">
                                @if ($product->quantity == 0)
                                {{ "Out of stock" }}</br>
                                @else
                                {{ "In stock" }}</br>
                                @endif
                                <h6>{{ $product->presentPrice() }}</h6>
                            </div>
                            <form action="{{ route('cart.store', $product) }}" method="POST" class = "link-form-bag">
                                {{ csrf_field() }}
                            </form>
                            <div class="prd-bottom">
                                <a href="javascript:document.getElementsByClassName('link-form-bag')[{{$i}}].submit()"  class="social-info">
                                    <span class="ti-bag"></span>
                                    <p class="hover-text">add to bag</p>
                                </a>
                                <a href="{{ route('shop.show', $product->slug) }}" class="social-info">
                                    <span class="lnr lnr-move"></span>
                                    <p class="hover-text">view more</p>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                @php ($j = $j + 1)
                @endforeach
            </div>
        </div>
    </div>
</section>
<!-- end product Area -->
<!-- Start related-product Area -->
@if ($products->count())
<section class="related-product-area section_gap_bottom" >
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 text-center">
                <div class="section-title">
                    <h1>Deals of the Week</h1>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="row">
                    @foreach ($products as $product)
                    <div class="col-lg-4 col-md-4 col-sm-6 mb-20">
                        <div class="single-related-product d-flex">
                            <a href="{{ route('shop.show', $product->slug) }}"><img src="{{ productImage($product->image) }}" alt="" width="100px" height="100px"></a>
                            <div class="desc">
                                <a href="{{ route('shop.show', $product->slug) }}" class="title">{{$product->name}}</a>
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
@endif
<!-- End related-product Area -->
<!--<script>
    var is_mobile = !!navigator.userAgent.match(/iphone|android|blackberry/ig) || false;
    if(is_mobile) {
    	var all = document.getElementsByClassName('img-fluid w-100');
    	var i=0;
    for (i, max=all.length; i < max; i++) {
    	document.getElementsByClassName('img-fluid w-100');
    }
    for (i, max=all.length; i < max; i++) {
    	document.getElementsByClassName('img-fluid w-100')[i].removeAttribute('class');
    }
    }
</script> -->
@endsection
