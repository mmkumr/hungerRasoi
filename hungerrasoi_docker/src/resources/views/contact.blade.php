@extends ('layout')
@section ('title', 'Contact us')

@section ('content')
    <!--================Contact Area =================-->
<section class="contact_area section_gap_bottom">
    <div class="container">
        <div class="row">

    <div class = mapBox style="overflow:hidden;width: 1500px;position: relative;"><iframe width="700" height="440" src="https://maps.google.com/maps?width=700&amp;height=440&amp;hl=en&amp;q=Berhampur%2Codisha+(HungerRasoi)&amp;ie=UTF8&amp;t=&amp;z=10&amp;iwloc=B&amp;output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><div style="position: absolute;width: 80%;bottom: 10px;left: 0;right: 0;margin-left: auto;margin-right: auto;color: #000;text-align: center;"><small style="line-height: 1.8;font-size: 2px;background: #fff;">Powered by <a href="https://embedgooglemaps.com/">Embedgooglemaps.com/</a> & </small></div><style>#gmap_canvas img{max-width:none!important;background:none!important}</style></div>
            <div class="col-lg-3">

                <div class="contact_info">
                    <div class="info_item">
                        <i class="lnr lnr-home"></i>
                        <p>Berhampur, Odisha, India</p>
                    </div>
                    <div class="info_item">
                        <i class="lnr lnr-phone-handset"></i>
                        <h6>+918337908779 </h6>
                        <p>Mon to Fri 9am to 6 pm</p>
                    </div>
                    <div class="info_item">
                        <i class="lnr lnr-envelope"></i>
                        <h6><a href="mailto:hungerrsoicare@gmail.com">hungerrasoicare@</br>gmail.com</a></h6>
                        <p>Send us your query anytime!</p>
                    </div>
                </div>
            </div>
                
            <div class="col-lg-9">
                @if (session()->has('success_message'))
                <div class="alert alert-success">
                    {{ session()->get('success_message') }}
                </div>
                @endif
                @if (count($errors) > 0)
                <div class="alert alert-danger">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
                @endif
                <form class="row contact_form" action="{{ route('contact.store') }}" method="post" id="contactForm" novalidate="novalidate">
                    {{ csrf_field() }}
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your name'" required>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email address" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter email address'"required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="subject" name="subject" placeholder="Enter Subject" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Subject'"required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <textarea class="form-control" name="message" id="message" rows="1" placeholder="Enter Message" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Message'"required></textarea>
                        </div>
                    </div>
                    <div class="col-md-12 text-right">
                        <button type="submit" value="submit" class="primary-btn">Send Message</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
@endsection 
<!--================Contact Area =================-->

<!--================End Contact Success and Error message Area =================-->

