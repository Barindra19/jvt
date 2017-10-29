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

Route::group(['prefix' => 'destination','middleware' => 'auth'], function () {

    Route::get('/','DestinationController@show')->name('destination');
    Route::get('/show','DestinationController@show')->name('destination_show');
    Route::get('/datatables','DestinationController@datatables')->name('destination_datatables');
    Route::get('/add','DestinationController@add')->name('destination_add');
    Route::post('/post','DestinationController@post')->name('destination_post');
    Route::get('/edit/{id}','DestinationController@edit')->name('destination_edit');
    Route::post('/update','DestinationController@update')->name('destination_update');
    Route::get('/delete/{id}','DestinationController@delete')->name('destination_delete');
    Route::get('/inactive/{id}','DestinationController@inactive')->name('destination_inactive');
    Route::get('/activate/{id}','DestinationController@activate')->name('destination_activate');

    Route::post('/searchbycountry','DestinationController@searchbycountry')->name('destination_searchbycountryn');
});
