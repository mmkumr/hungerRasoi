<!DOCTYPE html>
<html lang="zxx" class="no-js">
    <head>
<!-- Mobile Specific Meta -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Favicon-->
        <link rel="shortcut icon" href="img/fav.png">
        <!-- Author Meta -->
        <meta name="author" content="CodePixar">
        <!-- Meta Description -->
        <meta name="description" content="">
        <!-- Meta Keyword -->
        <meta name="keywords" content="">
        <!-- CSRF Token -->
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <!-- meta character set -->
        <meta charset="UTF-8">
        <!-- Site Title -->
        <title>HungerRasoi | @yield('title', '')</title>

    </head>
    @include('partials.css')
<body>
    @include('partials.nav') 
    @yield('content')
    @include('partials.footer')
    @include('partials.js')
    @yield('extra-js')
</body>
</html>
