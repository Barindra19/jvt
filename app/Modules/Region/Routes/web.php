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

Route::group(['prefix' => 'region', 'middleware' => 'auth'], function () {
    Route::get('/','RegionController@show')->name('region');
    Route::get('/show','RegionController@show')->name('region_show');
    Route::get('/datatables','RegionController@datatables')->name('region_datatables');
    Route::get('/add','RegionController@add')->name('region_add');
    Route::post('/post','RegionController@post')->name('region_post');
    Route::get('/edit/{id}','RegionController@edit')->name('region_edit');
    Route::post('/update','RegionController@update')->name('region_update');
    Route::get('/delete/{id}','RegionController@delete')->name('region_delete');
    Route::get('/inactive/{id}','RegionController@inactive')->name('region_inactive');
    Route::get('/activate/{id}','RegionController@activate')->name('region_activate');
});
