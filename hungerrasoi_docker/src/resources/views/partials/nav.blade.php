<!--
<header>
    <div class="top-nav container">
      <div class="top-nav-left">
          <div class="logo"><a href="/">Ecommerce</a></div>
          @if (! (request()->is('checkout') || request()->is('guestCheckout')))
          {{ menu('main', 'partials.menus.main') }}
          @endif
      </div>
      <div class="top-nav-right">
          @if (! (request()->is('checkout') || request()->is('guestCheckout')))
          @include('partials.menus.main-right')
          @endif
      </div>
    </div>  
</header>
-->
<header class="header_area sticky-header">
    <div class="main_menu">
        <nav class="navbar navbar-expand-lg navbar-light main_box">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <a class="navbar-brand logo_h" href="{{ route('landing-page') }}"><img src="{{ asset('img/logo.png') }}" alt="" width="137px" height="70px"></a>

  		<ul class="nav navbar-nav navbar-right">
                        <li class="nav-item">
                            
                        </li>
                        <li class="nav-item">
                            <a href="{{ route('cart.index') }}" class="cart"><span class="ti-bag"></span>@if (Cart::instance('default')->count() > 0)<span class="cart-count"><span>{{ Cart::instance('default')->count() }}</span></span>@endif</a>
                            <button class="search" style = "padding-left:30px"><span class="lnr lnr-magnifier" id="search"></span></button>
                        </li>
                </ul>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">Menu
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                    <ul class="nav navbar-nav menu_nav ml-auto">
                        <li class="nav-item active"><a class="nav-link" href="/">Home</a></li>

                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                             aria-expanded="false">Categories</a>
                            <ul class="dropdown-menu">
                                @foreach ($categories as $category)
                                    <li class="nav-item"><a class="nav-link" href="{{ route('shop.index', ['category' => $category->slug]) }}">{{ $category->name }}</a></li>
                                @endforeach
                            </ul>
                        </li>
                        @guest
                        <li class="nav-item"><a class="nav-link" href="{{ route('login') }}">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="{{ route('register') }}">Create account</a></li>
                        @endguest
                        <li class="nav-item"><a class="nav-link" href="{{ route('contact') }}">Contact us</a></li>
                        @guest 
                        @else 
                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                             aria-expanded="false"><i class="fa fa-user"></i> {{ Auth::user()->name }}</a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="{{ route('orders.index') }}">Orders</a></li>
                                <li class="nav-item"><a class="nav-link" href="{{ route('users.edit') }}">Edit account</a></li>
                                <li class="nav-item"><a class="nav-link" href="{{ route('profile') }}">Account details</a></li>

                                <li class="nav-item"><a class="nav-link" href="{{ route('logout') }}"
                                    onclick="event.preventDefault();
                                    document.getElementById('logout-form').submit();">Logout</a>
                                </li>

                                <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                                    {{ csrf_field() }}
                                </form>
   
                            </ul>
                        </li>
                        @endguest
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="nav-item">
                            
                        </li>
                        <li class="nav-item">
                            <a href="{{ route('cart.index') }}" class="cart"><span class="ti-bag"></span>@if (Cart::instance('default')->count() > 0)<span class="cart-count"><span>{{ Cart::instance('default')->count() }}</span></span>@endif</a>
                            <button class="search" style = "padding-left:30px"><span class="lnr lnr-magnifier" id="search"></span></button>
                        </li>
                </ul>
                </div>
            </div>
        </nav>
    </div>
    </div>
    <div class="search_input" id="search_input_box">
        <div class="container">
            <form class="d-flex justify-content-between">
<div class="aa-input-container" id="aa-input-container">
    <input type="search" id="aa-search-input" class="aa-input-search" placeholder="Search products" name="search"
        autocomplete="off" />
    <svg class="aa-input-icon" viewBox="654 -372 1664 1664">
        <path d="M1806,332c0-123.3-43.8-228.8-131.5-316.5C1586.8-72.2,1481.3-116,1358-116s-228.8,43.8-316.5,131.5  C953.8,103.2,910,208.7,910,332s43.8,228.8,131.5,316.5C1129.2,736.2,1234.7,780,1358,780s228.8-43.8,316.5-131.5  C1762.2,560.8,1806,455.3,1806,332z M2318,1164c0,34.7-12.7,64.7-38,90s-55.3,38-90,38c-36,0-66-12.7-90-38l-343-342  c-119.3,82.7-252.3,124-399,124c-95.3,0-186.5-18.5-273.5-55.5s-162-87-225-150s-113-138-150-225S654,427.3,654,332  s18.5-186.5,55.5-273.5s87-162,150-225s138-113,225-150S1262.7-372,1358-372s186.5,18.5,273.5,55.5s162,87,225,150s113,138,150,225  S2062,236.7,2062,332c0,146.7-41.3,279.7-124,399l343,343C2305.7,1098.7,2318,1128.7,2318,1164z" />
    </svg>
</div>
                <button type="submit" class="btn"></button>
                <span class="lnr lnr-cross" id="close_search" title="Close Search"></span>
            </form>
        </div>
    </div>
    <script>
    	var is_mobile = !!navigator.userAgent.match(/iphone|android|blackberry/ig) || false;
    	if(!is_mobile) {
    		document.getElementsByClassName('cart')[0].innerHTML=' ';
    		document.getElementsByClassName('search')[0].innerHTML=' ';
    	}
    </script>
</header>
