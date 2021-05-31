<?php
 
 namespace App\Http\Controllers;
 
 use Illuminate\Http\Request;
 
 use App\Payment;
 
 use Redirect,Response;
 
 class RazorpayController extends Controller
 {
     public function index()
     {
       return view('razorpay');
     }
 
     public function razorPaySuccess(Request $request){
         
         $data = [
                   'user_id' => '1',
                   'product_id' => $_REQUEST['product_id'],
                   'r_payment_id' => $_REQUEST['payment_id'],
                   'amount' => $_REQUEST['amount'],
                ];
 
         $getId = Payment::insertGetId($data);  
 
         $arr = array('msg' => 'Payment successfully credited', 'status' => true);
 
         return view('thankyou');    
     }
 
     public function RazorThankYou()
     {
       return view('thankyou');
     }
 
 }
