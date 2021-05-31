<?php

namespace App\Http\Controllers\Auth;

use App\User;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\RegistersUsers;

class RegisterController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Register Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users as well as their
    | validation and creation. By default this controller uses a trait to
    | provide this functionality without requiring any additional code.
    |
    */

    use RegistersUsers;

    /**
     * Where to redirect users after registration.
     *
     * @var string
     */
    protected $redirectTo = '/checkout';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest');
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'dp' => 'sometimes|image|mimes:jpeg,png,jpg',
            'phone' => 'required|numeric|digits:10', 
            'address' => 'required',
            'city' => 'required',
            'state' => 'required', 
            'pin_code' => 'required|numeric|digits:6',
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\User
     */
    protected function create(array $data)
    {
       if(request()->file('dp')) {
            $image = request()->file('dp');
            $name = request()->email.'.'.$image->getClientOriginalExtension();
            $destinationPath = base_path().'/storage/app/public/users';
            $image->move($destinationPath, $name);
       }
       else {
            $name = "users/default.jpg";
       }
            return User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => bcrypt($data['password']),
            'dp' => 'users/'.$name,
            'phone' => $data['phone'],
            'block' => $data['block'],
            'address' => $data['address'],
            'city' => $data['city'],
            'state' => $data['state'], 
            'pin_code' => $data['pin_code'],
        ]);
    }
}
