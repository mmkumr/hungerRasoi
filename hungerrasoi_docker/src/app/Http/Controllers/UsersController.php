<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;

class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function edit()
    {
        return view('edit-profile')->with('user', auth()->user());
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
        //
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
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('my-profile')->with('user', auth()->user());
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,'.auth()->id(),
            'password' => 'sometimes|nullable|string|min:6|confirmed',
            'dp' => 'sometimes|image|mimes:jpeg,png,jpg',
            'phone' => 'required|numeric|digits:10', 
            'address' => 'required',
            'city' => 'required',
            'state' => 'required', 
            'pin_code' => 'required|numeric|digits:6',
        ]);
        $user = auth()->user();
        $input = $request->except('password', 'password_confirmation', 'dp');
        if ($request->hasFile('dp')) {
            $image = request()->file('dp');
            $name = request()->email.'.'.$image->getClientOriginalExtension();
            $destinationPath = base_path().'storage/app/public/users';
            $image->move($destinationPath, $name);
            $user->dp = 'users/'.$name;
        }
        if (! $request->filled('password')) {
            $user->fill($input)->save();
            return redirect()->route('profile')->with('success_message', 'Profile has been updated successfully!');
        }
        $user->password = bcrypt($request->password);
        $user->fill($input)->save();

        return redirect()->route('profile')->with('success_message', 'Profile has been updated successfully!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
