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

Route::group(['prefix' => 'classtour','middleware' => 'auth'], function () {
    Route::get('/','ClassTourController@show')->name('classtour');
    Route::get('/add','ClassTourController@add')->name('classtour_add');
    Route::post('/post','ClassTourController@post')->name('classtour_post');
    Route::get('/edit/{id}','ClassTourController@edit')->name('classtour_edit');
    Route::post('/update','ClassTourController@update')->name('classtour_update');
    Route::get('/delete/{id}','ClassTourController@delete')->name('classtour_delete');
    Route::get('/inactive/{id}','ClassTourController@inactive')->name('classtour_inactive');
    Route::get('/activate/{id}','ClassTourController@activate')->name('classtour_activate');
});
