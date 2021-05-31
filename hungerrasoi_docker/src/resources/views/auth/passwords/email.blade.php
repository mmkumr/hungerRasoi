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
            <h2>Forgot Password?</h2>
            <div class="spacer"></div>
            <form action="{{ route('password.email') }}" method="POST" class="row login_form">
                {{ csrf_field() }}
                <div class="col-md-12 form-group">
                    <input type="email" class="form-control" id="email" name="email" value="{{ old('email') }}" placeholder="Email" required autofocus>
                </div>
                <div class="form-group">
                    <button type="submit" class="primary-btn">Send Password Reset Link</button>
                </div>
            </form>
        </div>
        <div class="auth-right">
            <h2>Forgotten Password Information</h2>
            <div class="spacer"></div>
            <p>Enter your E-mail Id. We will send you the password reset link to your E-Mail.</p>
        </div>
    </div>
</div>
@endsection

