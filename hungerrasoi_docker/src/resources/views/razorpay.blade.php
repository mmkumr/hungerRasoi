<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Laravel 8 Razorpay Payment Gateway - Tutsmake.com</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <style>
        .card-product .img-wrap {
        border-radius: 3px 3px 0 0;
        overflow: hidden;
        position: relative;
        height: 220px;
        text-align: center;
        }
        .card-product .img-wrap img {
        max-height: 100%;
        max-width: 100%;
        object-fit: cover;
        }
        .card-product .info-wrap {
        overflow: hidden;
        padding: 15px;
        border-top: 1px solid #eee;
        }
        .card-product .bottom-wrap {
        padding: 15px;
        border-top: 1px solid #eee;
        }
        .label-rating { margin-right:10px;
        color: #333;
        display: inline-block;
        vertical-align: middle;
        }
        .card-product .price-old {
        color: #999;
        }
    </style>
</head>
<body>
    <form method="POST" action="{{ route('checkout.online') }}" id="hidden">
      {{ csrf_field() }}
      <input type="hidden" name="email" value="{{$email}}">
      <input type="hidden" name="name" value="{{$name}}">
      <input type="hidden" name="address" value="{{$address}}">
      <input type="hidden" name="city" value="{{$city}}">
      <input type="hidden" name="state" value="{{$state}}">
      <input type="hidden" name="postalcode" value="{{$postalcode}}">
      <input type="hidden" name="phone" value="{{$phone}}">
      <input type="hidden" name="payment_id" id="payment_id"> 
    </form>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
        var SITEURL = "{{URL::to('')}}";
        $.ajaxSetup({
        headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
        }); 
        window.onload = function(e){
        var options = {
        "key": "rzp_test_2Eh5LSk1v3ujdn",
        "amount": "{{getNumbers()->get('newTotal')}}",// 2000 paise = INR 20
        "name": "HungerRasoi",
        "description": "{{$name}}",
        "image": "{{ asset('img/logo.png') }}",
        "handler": function (response){
            document.getElementById("payment_id").value = response.razorpay_payment_id
            document.getElementById('hidden').submit();
        },
        "prefill": {
        "contact": "{{$phone}}",
        "email":   "{{$email}}",
        },
        "theme": {
        "color": "#528FF0"
        }
        };
        var rzp1 = new Razorpay(options);
        rzp1.open();
        e.preventDefault();
        };
        /*document.getElementsClass('buy_plan1').onclick = function(e){
        rzp1.open();
        e.preventDefault();
        }*/
    </script>
</body>

</html>
