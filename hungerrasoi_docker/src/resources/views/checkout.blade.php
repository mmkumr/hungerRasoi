@extends ('layout')
@section ('title', 'Checkout')
@section ('content')
    <!--================Checkout Area =================-->
    <section class="checkout_area section_gap" style = "padding-top:150px">
        <div class="container">
        @if (session()->has('success_message'))
            <div class="spacer"></div>
            <div class="alert alert-success">
                {{ session()->get('success_message') }}
            </div>
        @endif

        @if(count($errors) > 0)
            <div class="spacer"></div>
            <div class="alert alert-danger">
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{!! $error !!}</li>
                    @endforeach
                </ul>
            </div>
        @endif

            <div class="billing_details">
                <div class="row">
                    <div class="col-lg-8">
                        <h3>Billing Details</h3>
                            <form class="row contact_form" name = "paymentform" id="payment-form" action="{{ route('checkout.store') }}" method="POST">
                                {{ csrf_field() }}
                                <div class="col-md-6 form-group">
                                    @if (auth()->user())
                                    <input type="email" class="form-control" id="email" name="email" value="{{ auth()->user()->email }}"readonly>
                                    @else
                                    <input type="email" class="form-control" id="email" name="email" value="{{ old('email') }}" placeholder = "Email" required>
                                    @endif                            
                                </div>
                                <div class="col-md-6 form-group p_star">
                                    <input type="text" class="form-control" id="name" name="name" value="{{$name}}" placeholder = "Name" required>
                                </div>
                                
                                <div class="col-md-12 form-group p_star">
                                    <input type="text" class="form-control" id="address" name="address" value="{{$address}}" placeholder = "Address" required>                            
                                </div>
                                <div class="col-md-6 form-group p_star">
                                    <input type="text" class="form-control" id="city" name="city" value="{{$city}}" placeholder = "City" required>
                                </div>
                                <div class="col-md-6 form-group p_star">
                                    <input type="text" class="form-control" id="postalcode" name="postalcode" value="{{$pin_code}}" placeholder = "Pin Code" required>
                                </div>
                                <div class="col-md-6 form-group p_star">
                                    <input type="text" class="form-control" id="province" name="province" value="{{$state}}" placeholder = "State" required>
                                </div>
                                <div class="col-md-6 form-group p_star">
                                    <input type="tel" class="form-control" id="phone" name="phone" value="{{$phone}}" placeholder = "Phone No." required>
                                </div>
                            <div class="radion_btn">
                                <input type="radio" id="cod" name="payment" value="cod" checked>
                                <label for="cod">Cash on Delivery</label>
                                <div class="check"></div>
                            </div>
                            <div class="radion_btn">
                                <input type="radio" id="online" name="payment" value="online">
                                <label for="online">Online Payment</label>
                                <div class="check"></div>
                            </div>
                            </form>
                            <div class="row contact_form">
                            <!--@if (!session()->get('refer')['id'] && !request()->is('guestCheckout'))
                                <form action="{{ route('refer.store') }}" method="POST">
                                    {{ csrf_field() }}
                                    <input type="number" class="form-control" id="refer" name="refer_id" placeholder = "Enter the referral code">
                                    
                                    <button type="submit" class="primary-btn">Apply</button>
                                </form>
                            @elseif (session()->get('refer')['id'] && !request()->is('guestCheckout'))
                                <h3>Referral Code</h3>
                                <div style = "margin-left:-80px"><br>
                                {{session()->get('refer')['id']}}
                                </div>
                                <div style = "margin-left:-30px"><br><br>
                                    <form action="{{ route('refer.destroy') }}" method="POST">
                                        {{ csrf_field() }}
                                        {{ method_field('delete') }}
                                        <button type="submit">Remove</button>
                                    </form>
                                </div>
                            @endif -->
                            </div>
                            <!--@if (!request()->is('guestCheckout') && $referred == 0)
                            <label for="referral id">Copy the below code and send to any other person. If he/she will use this code while checkout the cart then he/she will get discount and you will get cashback to your vegifruit wallet. <sup>*T&C If anyone else has already referred by him/her then your code will be invalid.</sup></label>
                            <input type="text" class="form-control" id="referral id" name="referral id" value="{{ substr(auth()->user()->phone, 3, -3) . auth()->user()->id }}"readonly>
                            @elseif ($referred == 1)
                                <label for="referral id">Same person can't be referred twice.</sup></label>
                            <input type="text" class="form-control" id="referral id" name="referral id" value="Somebody has already referred you"readonly>
                            @endif -->
                    </div> 
                    <div class="col-lg-4">
                        <div class="order_box">
                            <h2>Your Order</h2>
                            <ul class="list">
                                <li>
                                    <a href="#">Product <span>Total</span></a>
                                </li>
                                @foreach (Cart::content() as $item)
                                <li>
                                    <img src="{{ productImage($item->model->image) }}" alt="item" width="100px" height="100px">
                                    <a href="#">{{ $item->name }}<span class="middle">x {{ $item->qty }}</span> <span class="last">{{ presentPrice($item->price() * $item->qty) }}</span></a>
                                </li>
                                @endforeach
                            </ul>
                            <ul class="list list_2">
                                @if (session()->has('coupon'))
                                    <li><a href="#">Coupon code <span>{{ session()->get('coupon')['name'] }}</span></a></li>
                                @endif
                                <li><a href="#">Subtotal <span>{{ presentPrice(Cart::subtotal()) }}</span></a></li>
                                @if ($discount != 0)
                                    <li><a href="#">Discount <span>-{{ presentPrice($discount) }} </span></a></li>
                                @endif
                                <li><a href="#">Tax <span>{{ presentPrice($newTax) }}</span></a></li>
                                <li><a href="#">Total <span>{{ presentPrice($newTotal) }}</span></a></li>
                            </ul>
                            <div class="row contact_form" style="padding-left:20px"> 
                            @if (!session()->get('wallet')['value'] && !request()->is('guestCheckout'))
                                @if (auth()->user()->wallet != 0)
                                    <form action="{{ route('wallet.store') }}" method="POST">
                                        {{ csrf_field() }}
                                        <h5>Use wallet money:  ₹{{ auth()->user()->wallet }}</h5>
                                        <button type="submit" class="primary-btn">Use it</button>
                                    </form>
                                @endif
                            @elseif (session()->get('wallet')['value'] && !request()->is('guestCheckout')) 
                                <h3>Referral Code</h3>
                                <div style = "margin-left:-80px"><br>
                                </div>
                                <div style = "margin-left:-30px"><br><br>
                                    <form action="{{ route('wallet.destroy') }}" method="POST">
                                        {{ csrf_field() }}
                                        <h5>Using wallet money:  ₹{{ auth()->user()->wallet }}
                                        {{ method_field('delete') }} 
                                        <button type="submit" class="primary-btn">Don't Use</button>
                                    </form>
                                </div>
                                @endif
                            </div>
                            <!--
                            <div class="payment_item active">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option6" name="payment" onchange = "if(document.getElementsByName('payment')[1].checked) {document.paymentform.action = 'online'}">
                                    <label for="f-option6">Online Payment</label>
                                    <img src="img/product/card.jpg" alt="">
                                    <div class="check"></div>
                                </div>
                            </div> 
                            -->
                            <a class="primary-btn" href="#" onclick="document.getElementById('payment-form').submit(); alert('Please wait. We are conforming your order. Do not press the proceed to checkout button again.')";>Proceed to Checkout</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </section>
    <!--================End Checkout Area =================-->
@endsection 
@section ('extra-js')
<script src="https://js.braintreegateway.com/web/dropin/1.13.0/js/dropin.min.js"></script>
<script>
    (function(){
        // Create a Stripe client
        var stripe = Stripe('{{ config('services.stripe.key') }}');
    
        // Create an instance of Elements
        var elements = stripe.elements();
    
        // Custom styling can be passed to options when creating an Element.
        // (Note that this demo uses a wider set of styles than the guide below.)
        var style = {
          base: {
            color: '#32325d',
            lineHeight: '18px',
            fontFamily: '"Roboto", Helvetica Neue", Helvetica, sans-serif',
            fontSmoothing: 'antialiased',
            fontSize: '16px',
            '::placeholder': {
              color: '#aab7c4'
            }
          },
          invalid: {
            color: '#fa755a',
            iconColor: '#fa755a'
          }
        };
    
        // Create an instance of the card Element
        var card = elements.create('card', {
            style: style,
            hidePostalCode: true
        });
    
        // Add an instance of the card Element into the `card-element` <div>
        card.mount('#card-element');
    
        // Handle real-time validation errors from the card Element.
        card.addEventListener('change', function(event) {
          var displayError = document.getElementById('card-errors');
          if (event.error) {
            displayError.textContent = event.error.message;
          } else {
            displayError.textContent = '';
          }
        });
    
        // Handle form submission
        var form = document.getElementById('payment-form');
        form.addEventListener('submit', function(event) {
          event.preventDefault();
    
          // Disable the submit button to prevent repeated clicks
          document.getElementById('complete-order').disabled = true;
    
          var options = {
            name: document.getElementById('name_on_card').value,
            address_line1: document.getElementById('address').value,
            address_city: document.getElementById('city').value,
            address_state: document.getElementById('province').value,
            address_zip: document.getElementById('postalcode').value
          }
    
          stripe.createToken(card, options).then(function(result) {
            if (result.error) {
              // Inform the user if there was an error
              var errorElement = document.getElementById('card-errors');
              errorElement.textContent = result.error.message;
    
              // Enable the submit button
              document.getElementById('complete-order').disabled = false;
            } else {
              // Send the token to your server
              stripeTokenHandler(result.token);
            }
          });
        });
    
        function stripeTokenHandler(token) {
          // Insert the token ID into the form so it gets submitted to the server
          var form = document.getElementById('payment-form');
          var hiddenInput = document.createElement('input');
          hiddenInput.setAttribute('type', 'hidden');
          hiddenInput.setAttribute('name', 'stripeToken');
          hiddenInput.setAttribute('value', token.id);
          form.appendChild(hiddenInput);
    
          // Submit the form
          form.submit();
        }
    
        // PayPal Stuff
        var form = document.querySelector('#paypal-payment-form');
        var client_token = "{{ $paypalToken }}";
    
        braintree.dropin.create({
          authorization: client_token,
          selector: '#bt-dropin',
          paypal: {
            flow: 'vault'
          }
        }, function (createErr, instance) {
          if (createErr) {
            console.log('Create Error', createErr);
            return;
          }
    
          // remove credit card option
          var elem = document.querySelector('.braintree-option__card');
          elem.parentNode.removeChild(elem);
    
          form.addEventListener('submit', function (event) {
            event.preventDefault();
    
            instance.requestPaymentMethod(function (err, payload) {
              if (err) {
                console.log('Request Payment Method Error', err);
                return;
              }
    
              // Add the nonce to the form and submit
              document.querySelector('#nonce').value = payload.nonce;
              form.submit();
            });
          });
        });
    
    })();
</script>
@endsection
