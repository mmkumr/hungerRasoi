@extends('layout')

@section('title', 'My Orders')

@section('content')
	<!--================Order Details Area =================-->
	<section class="order_details section_gap" style = "padding-top:150px">
        <div class="container">
            <div class="container">
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
            </div>
            @foreach ($orders as $order)
            <div class="row order_d_inner" style = "padding-top:50px">
				<div class="col-lg-6">
					<div class="details_item">
						<h4>Order Info</h4>
						<ul class="list">
							<li><span>Order number:</span> {{ $order->id }}</li>
							<li><span>Date:</span> {{ presentDate($order->created_at) }}</li>
                            <li><span>Total:</span> {{ presentPrice($order->billing_total) }}</li>
                            <li><span>Discount:</span> {{ presentPrice($order->billing_discount) }}</li>
                            <li><span>Payment method:</span> {{ $order->payment_gateway }}</li>
                            @if ($order->shipped == 1)
                                <li><span>Shipped:</span> Yes</li>
                            @else
                                <li><span>Shipped:</span> No</li>
                            @endif
                        </ul>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="details_item">
						<h4>Shipping Address</h4>
						<ul class="list">
							<li><span>Street:</span> {{$order->billing_address}}</li>
							<li><span>City:</span> {{$order->billing_city}}</li>
							<li><span>State:</span> {{$order->billing_province}}</li>
							<li><span>PIN Code:</span> {{$order->billing_postalcode}}</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="order_details_table">
				<h2>Order Details</h2>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">Product</th>
								<th scope="col">Quantity</th>
								<th scope="col">Total</th>
							</tr>
						</thead>
                        <tbody>
                            @foreach ($order->products as $product)
							<tr>
								<td>
									@if($product->pivot->product_name)
									<p><a href="{{ route('shop.show', $product->slug) }}">{{ $product->pivot->product_name }}</a></p>
									@else
									<p><a href="{{ route('shop.show', $product->slug) }}">{{ $product->name }}</a></p>
									@endif
								</td>
								<td>
									<h5>x {{ $product->pivot->quantity }}</h5>
								</td>
								<td>
									@if($product->pivot->product_price)
									<p>{{ presentPrice($product->pivot->product_price * $product->pivot->quantity) }}</p>

									@else
									<p>{{ presentPrice($product->price * $product->pivot->quantity) }}</p>
									@endif
								</td>
                            </tr>
                            @endforeach 
						</tbody>
                    </table>
                </div>
            </div>
        @endforeach
        </div>
	</section>
	<!--================End Order Details Area =================-->
@endsection
