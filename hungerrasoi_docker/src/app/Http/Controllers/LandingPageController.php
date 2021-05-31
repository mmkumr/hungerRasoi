<?php

namespace App\Http\Controllers;

use App\Category;
use App\Product;
use App\CategoryProduct;
use Illuminate\Http\Request;

class LandingPageController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $products = Product::where('featured', true)->take(9)->inRandomOrder()->get();
        $latest = Product::orderby('created_at', 'desc')->take(8)->get();
        $special = Product::with('categories')->whereHas('categories', function ($query) {
            $query->where('slug', '=', 'pmec-specials')->orWhere('slug', '=', 'non-veg-thali');
            })->take(8)->inRandomOrder()->get();
        return view('landing-page')->with([
            'products' => $products,
            'latest' => $latest,
            'special' => $special,
        ]);

    }
}
