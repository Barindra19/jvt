<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of the routes that are handled
| by your module. Just tell Laravel the URIs it should respond
| to using a Closure or controller method. Build something great!
|
*/

Route::group(['prefix' => 'membership','middleware' => 'auth'], function () {
    Route::get('/add','MembershipController@add')->name('membership_add');
    Route::post('/post','MembershipController@post')->name('membership_post');
});
