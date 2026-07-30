<?php

use App\Http\Controllers\AppController;
use Illuminate\Support\Facades\Route;

// ###############################################################################

// Route tampilan (frontend)
Route::get('/', [AppController::class, 'index']);
Route::get('/berita', [AppController::class, 'berita']);
Route::get('/about', [AppController::class, 'about']);
Route::get('/testimonial', [AppController::class, 'testimonial']);
Route::get('/contact', [AppController::class, 'contact']);
Route::get('/team', [AppController::class, 'team']);
Route::get('/courses', [AppController::class, 'courses']);

// ###############################################################################


