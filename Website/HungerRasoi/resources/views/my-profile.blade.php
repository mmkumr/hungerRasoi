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
        <img class="author_img rounded-circle" src="{{usersImage($user->dp)}}" alt="" style="display: block;margin-left: auto;margin-right:auto;" height = 200px>
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
                            <h4>{{$user->name}}</h4>
                            <p><strong>E-Mail:-</strong>{{$user->email}}</p>
                            <p><strong>Phone No.:-</strong>{{$user->phone}}</p>
                            <p><strong>Address:-</strong>{{$user->address . '(' . $user->block . ')' . ', ' . $user->city  . ', ' . $user->state . ', ' . $user->pin_code}}</p>
                            <p><strong>Wallet Balance:-</strong>{{ "₹" . $user->wallet }}</p>
                            <div class="br"></div>
                            <div class="hover">
                                <a class="primary-btn" href="{{ route('users.edit') }}">Edit Profile</a>
                            </div>

                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
