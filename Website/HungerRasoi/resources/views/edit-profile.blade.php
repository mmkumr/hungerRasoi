@extends ('layout')
@section ('title', 'Profile')
@section ('content')

    <!-- Start Banner Area -->
<div class="col-lg-12 col-md-12 col-sm-12">
    <section class="banner-area organic-breadcrumb">
        <div class="container">
            <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            </div>
        </div>
        <img class="author_img rounded-circle" src="{{usersImage($user->dp)}}" alt="" style="display: block;margin-left: auto;margin-right: auto;height:200px;">
    </section>
    <!-- End Banner Area -->

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
        <!--================Blog Area =================-->
    <section class="blog_area single-post-area section_gap">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog_right_sidebar text-center">
                        <aside class="single_sidebar_widget author_widget">
                            <form class="row login_form" action="{{ route('users.update') }}" method="POST" id="contactForm" enctype="multipart/form-data">
                                <div class="col-lg-6 col-md-6">
                                </div>
                                @method('patch')
                                @csrf
                                <div class="col-md-12 form-group">
                                    <div>Ignore the fields you don't want to change</div>
                                    <h5>Profile Pic</h5><input name="dp" type="file">
                                    <input type="text" class="form-control" id="name" name="name" placeholder = 'Name' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Name'" value = "{{$user->name}}"required>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="email" class="form-control" id="email" name="email" placeholder = 'Email' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" value = "{{$user->email}}"required>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="tel" class="form-control" id="phone" name="phone"  placeholder = 'Phone Number' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Phone Number'" value = "{{$user->phone}}"required>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="text" class="form-control" id="address" name="address" placeholder = 'Address' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Address'" value = "{{$user->address}}"required>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="text" class="form-control" id="city" name="city" placeholder = 'City' onfocus="this.placeholder = ''" onblur="this.placeholder = 'City'" value = "{{$user->city}}"required>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="text" class="form-control" id="state" name="state" placeholder = 'State' onfocus="this.placeholder = ''" onblur="this.placeholder = 'State'" value = "{{$user->state}}"required>
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="text" class="form-control" id="pin_code" name="pin_code" placeholder = 'Pin Code' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Pin Code'" value = "{{$user->pin_code}}"required>
                                </div>
                                <div class="col-md-12 form-group">
                                    
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'">
                                </div>
                                <div class="col-md-12 form-group">
                                    <input type="password" class="form-control" id="password-confirm" name="password_confirmation"  placeholder="Confirm Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Confirm Password'">
                                </div>
                                <div class="br"></div>
                                <div class="col-md-12 form-group">
                                    <button type="submit" class="primary-btn">Update</button>
                                </div>
                            </form>
                            
                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
