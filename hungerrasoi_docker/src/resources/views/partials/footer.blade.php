<footer class="footer-area section_gap">
    <div class="container">
        <div class="row">
            <div class="col-lg-6  col-md-6 col-sm-6">
                <div class="single-footer-widget">
                    <h6>About Us</h6>
                    <p>
                       We deliver veg thali, non-veg thali, curries.
                    </p>
                </div>
            </div>
            <div class="col-lg-4  col-md-6 col-sm-6">
                <div class="single-footer-widget">
                    @if (session()->has('subscribe_message'))
                        <div class="alert alert-success">
                            {{ session()->get('subscribe_message') }}
                        </div>
                    @endif
                    
                    <h6>Newsletter</h6>
                    <p>Stay update with our latest(This feature will be soon available for all.)</p>
                    
                    <div class="" id="mc_embed_signup">
                        <form class="row login_form" action="{{ route('subscribe') }}" method="POST" id="subscribe">
                            {{ csrf_field() }}
                            <div class="d-flex flex-row">
                                <input class="form-control" id = "subemail" name="email" placeholder="Enter your E-Mail ID" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your E-Mail ID'" required type="email">
                                <input class="form-control" name="name" placeholder="Enter your name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your name'" required>
                                
                            </div>
                            <a class="click-btn btn btn-default" href="#" onclick="document.getElementById('subscribe').submit()"><span class="lnr lnr-arrow-right"></span></a>
                           
                            <div class="info"></div>
                        </form>
                        @if (session()->has('subscribe_message'))
                            <script>
                                document.getElementById("subemail").focus();
                            </script>
                            
                        @endif
                        
                    </div>
                </div>
            </div>
            <div class="col-lg-2 col-md-6 col-sm-6">
                <div class="single-footer-widget" style = "padding-left:60px">
                    <h6>Follow Us</h6>
                    <p>Let us be social</p>
                    <div class="footer-social d-flex align-items-center">
                        <a href="#"><i class="fa fa-facebook"></i></a>
                        <a href="#"><i class="fa fa-twitter"></i></a>
                        <a href="#"><i class="fa fa-instagram"></i></a>
                        <a href="mailto:vegifruit@gmail.com"><i class="fa fa-envelope"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom d-flex justify-content-center align-items-center flex-wrap">
            <p class="footer-text m-0">
Copyright &copy;2019 All rights reserved by hungerrasoi
</p>
        </div>
    </div>
</footer>
