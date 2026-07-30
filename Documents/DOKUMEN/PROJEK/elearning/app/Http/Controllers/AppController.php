<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AppController extends Controller
{
    public function index() {
        return view ('welcome');
    }

    public function berita() {
        return view ('user.berita.berita');
    }

    public function contact() {
        return view ('user.contact.contact');
    }

    public function testimonial() {
        return view ('user.contact.testimonial');
    }

    public function about() {
        return view('user.about.about');
    }

    public function team() {
        return view('user.about.team');
    }

    public function courses() {
        return view ('user.courses.courses');
    }
}