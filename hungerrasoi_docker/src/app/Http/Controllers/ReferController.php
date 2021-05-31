<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Jobs\UpdateRefer;

class ReferController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $refer_id = User::where('id', substr($request->refer_id, 4))->first();
        if (!$refer_id || auth()->user()->id == substr($request->refer_id, 4) || substr($request->refer_id, 0, 4) != substr($refer_id->phone, 3, -3)) {
            return back()->withErrors('Invalid referral code. Please try Another code.');
        }
        dispatch_now(new UpdateRefer($request->refer_id));
        User::where('id', substr($request->refer_id, 4))->first()->referred = 1;
        User::where('id', substr($request->refer_id, 4))->first()->save();
        return back()->with('success_message', 'Referral code has been applied!');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {
        
        User::where('id', substr(session()->get('refer')['id'], 4))->first()->referred = 0;
        User::where('id', substr(session()->get('refer')['id'], 4))->first();
        session()->forget('refer');
        return back()->with('success_message', 'Referral code has been removed.');
    }
}
