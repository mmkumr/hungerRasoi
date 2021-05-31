<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Mail;

class ContactController extends Controller
{

    public function index()
    {
        return view('contact');
    }


    public function store(Request $request)
    { 
        $this->validate($request, [
        'name' => 'required',
        'email' => 'required|email',
        'subject' => 'required',
        'message' => 'required'
        ]);
        Mail::send('emails.contact',
        array(
           'name' => $request->name,
           'email' => $request->email,
           'subject' => $request->subject,
           'user_message' => $request->message
       ), function($message) {
       $message->from(request()->email);
       $message->to('mmkumr.ping@gmail.com', 'Admin')->subject('Vegifruit Feedback');
                            });
        return back()->with('success_message', 'Thanks for contacting us!');    
    }

}
