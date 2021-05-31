@extends('layout')

@section('title', 'Reset Password')

@section('content')
<div class="container" style = "padding-top:150px;padding-bottom:50px">
    <div class="auth-pages">
        <div class="auth-left">
            @if (session()->has('status'))
            <div class="alert alert-success">
                {{ session()->get('status') }}
            </div>
            @endif @if(count($errors) > 0)
            <div class="alert alert-danger">
                <ul>
                    @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
            @endif
            <h2>Reset Password</h2>
            <div class="spacer"></div>
            <form class="row login_form" method="POST" action="{{ route('password.request') }}">
                {{ csrf_field() }}

                <input type="hidden" name="token" value="{{ $token }}">
                <div class="col-md-12 form-group">
                    <input id="email" type="email" class="form-control" name="email" value="" placeholder="Email" required autofocus>
                </div>
                <div class="col-md-12 form-group">
                    <input id="password" type="password" class="form-control" name="password" placeholder="Password" required>
                </div>
                <div class="col-md-12 form-group">
                    <input id="password-confirm" type="password" class="form-control" name="password_confirmation" placeholder="Confirm Password" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="primary-btn">Reset Password</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
