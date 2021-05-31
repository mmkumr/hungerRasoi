@extends ('layout')
@section ('title', 'cart')
@section ('content')
    <!--================Cart Area =================-->
    <section class="cart_area">
        <div class="container">
            <div class="cart_inner">
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
                <div class="table-responsive">
                @if (Cart::count() > 0)
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Product</th>
                                <th scope="col">Price</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Total</th>
                                <th scope="col">Buttons</th>

                            </tr>
                        </thead>
                        <tbody>
                        @php ($t = 0) 
                        @foreach (Cart::content() as $item)
                            <tr>
                                <td>
                                    <div class="media">
                                        <div class="d-flex">
                                            <a href="{{ route('shop.show', $item->model->slug) }}">
                                                <img src="{{ productImage($item->model->image) }}" alt="item" width="200px" height="200px">
                                            </a>
                                        </div>
                                        <div class="media-body">
                                            <a href="{{ route('shop.show', $item->model->slug) }}">
						<h3>{{$item->name}}</h3>
                                            </a>
                                            <p>{{ $item->model->details }}</p>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <h5>{{presentPrice($item->price)}}</h5>
                                </td>
                                <td>
                                    @php ($tprice = $item->price)
                                    <div class="product_count">
                                    <select class="quantity" data-id="{{ $item->rowId }}" data-productQuantity="{{ $item->model->quantity }}" onchange="x = {{$tprice}} * (this.value); document.getElementsByTagName('h4')[{{$t}}].innerHTML = '₹' + x/100;
                                   var sum = 0;
                                   Array.from(document.querySelectorAll('h4')).forEach(function(element) { 
                                   sum += Number(element.innerHTML.slice(1)) 
                                   });
                                   element = document.getElementsByTagName('select')['{{$t}}'];
                                   const id = element.getAttribute('data-id');
                                   const productQuantity = element.getAttribute('data-productQuantity');
                                   axios.patch(`/cart/${id}`, {
                        										quantity: this.value,
                        										productQuantity: productQuantity
                                   });
                                   document.querySelectorAll('p')[{{count(Cart::content())}}].innerText = '₹' + sum;
                                   document.querySelectorAll('p')[{{count(Cart::content())}} + 2].innerText = '₹' + (sum - {{ trim(presentPrice($discount), '₹')}});
                                   sum = 0
                                        ">
                                            @for ($i = 1; $i < 5 + 1 ; $i++)
                                                <option {{ $item->qty == $i ? 'selected' : '' }}>{{ $i }}</option>
                                            @endfor

                                        </select>
                                    </div>
                                       <td> 
                                           <h4>{{presentPrice($tprice * $item->qty)}}</h4>
                                        </td>
                                    </div>
                                </td>
                                <td>
                                <form action="{{ route('cart.destroy', $item->rowId) }}" method="POST">
                                    {{ csrf_field() }}
                                    {{ method_field('DELETE') }}

                                    <button type="submit" class="cart-options">Remove</button>
                                </form>

                                <form action="{{ route('cart.switchToSaveForLater', $item->rowId) }}" method="POST">
                                    {{ csrf_field() }}
                                    <button type="submit" class="cart-options">Add to wishlist</button>
                                </form>
                                </td>
                            </tr>
                            @php ($t = $t + 1)
                            @endforeach
                            <tr>
                            </tr>
                            <tr class="bottom_button">
                                <td>
                                </td>
                                <td>

                                </td>
                                <td>

                                </td>
                                <td>
                                    @if (!session()->has('coupon'))
                                    <div class="cupon_text d-flex align-items-center" align = right>
                                        <form action="{{ route('coupon.store') }}" method="POST">
                                            {{ csrf_field() }}
                                            <input type="text" name="coupon_code" placeholder="Coupon Code">
                                            <button type="submit" class="primary-btn">Apply</button>
                                        </form>
                                    </div>
                                    @endif
                                </td>
                            </tr>
                            <tr>
                                <td>

                                </td>
                                <td>

                                </td>
                                <td>
                                    @if (session()->has('coupon'))
                                    <h3>Coupon code</h3>
                                        Code ({{ session()->get('coupon')['name'] }})
                                        <form action="{{ route('coupon.destroy') }}" method="POST">
                                            {{ csrf_field() }}
                                            {{ method_field('delete') }}
                                            <button type="submit" style="font-size:14px;">Remove</button>
                                        </form>
                                        @endif
                                </td>
                                <td>
                                    <h3>Subtotal</h3>
                                    <p align = 'center'>₹{{ trim(presentPrice($newTotal), '₹') + trim(presentPrice($discount), '₹') }}</p>
                                    <p align = 'center'>- {{ presentPrice($discount) }}</p>
                                    <h5 align = 'center'>Total</h5>
                                    <p align = 'center'>₹{{ trim(presentPrice($newTotal), '₹') }}</p>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr class="shipping_area">

                                </td>
                                <td>

                                </td>
                                <tr class="out_button_area">
                                <td>

                                </td>
                                <td>

                                </td>
                                <td>

                                </td>
                                <td>
                                    <div class="checkout_btn_inner d-flex align-items-center">
                                        <a class="gray_btn" href="/">Continue Shopping</a>
                                        <a class="primary-btn" href="{{ route('checkout.index') }}">Proceed to checkout</a>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    @else
                    <table class="table">
                        <thead>
                            <tr>
                                <h3 align = center>No items in the cart!</h3>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="bottom_button">
                                <tr class="out_button_area">
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <div class="checkout_btn_inner d-flex align-items-center">
                                        <a class="gray_btn" href="/">Continue Shopping</a>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    @endif
                    @if (Cart::instance('saveForLater')->count() > 0)
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Product</th>
                                <th scope="col"></th>
                                <th scope="col"></th>
                                <th scope="col">Price</th>
                                <th scope="col">Buttons</th>

                            </tr>
                        </thead>
                        <tbody>
                        <h2 align = 'center'>Wishlist</h2> 
                        @foreach (Cart::instance('saveForLater')->content() as $item)
                            <tr>
                                <td>
                                    <div class="media">
                                        <div class="d-flex">
                                            <a href="{{ route('shop.show', $item->model->slug) }}">
                                                <img src="{{ productImage($item->model->image) }}" alt="item"width="200px" height="200px">
                                            </a>
                                        </div>
                                        <div class="media-body">
                                            <a href="{{ route('shop.show', $item->model->slug) }}">
                                                <h3>{{ $item->model->name }}</h3><br>
                                            </a>
                                            <p>{{ $item->model->details }}</p>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                    
                                       <td> 
                                           <h5>{{presentPrice($item->model->price)}}</h5>
                                        </td>
                                    </div>
                                </td>
                                <td>
                                <form action="{{ route('saveForLater.destroy', $item->rowId) }}" method="POST">
                                    {{ csrf_field() }}
                                    {{ method_field('DELETE') }}
                                    <button type="submit" class="cart-options">Remove</button>
                                </form>
                                <form action="{{ route('saveForLater.switchToCart', $item->rowId) }}" method="POST">
                                    {{ csrf_field() }}
                                    <button type="submit" class="cart-options">Move to Cart</button>
                                </form>
                                </td>
                            </tr>
                            @endforeach
                            <tr>
                            </tr>
                            <tr class="bottom_button">
                            <tr class="shipping_area">
                                </td>
                                <td>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    @endif
                </div>
            </div>
        </div>
    </section>
    <!--================End Cart Area =================-->
@endsection
