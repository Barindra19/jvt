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

Route::group(['prefix' => 'includes', 'middleware' => 'auth'], function () {
    Route::get('/','IncludesController@show')->name('includes');
    Route::get('/show','IncludesController@show')->name('includes_show');
    Route::get('/datatables','IncludesController@datatables')->name('includes_datatables');
    Route::get('/add','IncludesController@add')->name('includes_add');
    Route::post('/post','IncludesController@post')->name('includes_post');
    Route::get('/edit/{id}','IncludesController@edit')->name('includes_edit');
    Route::post('/update','IncludesController@update')->name('includes_update');
    Route::get('/delete/{id}','IncludesController@delete')->name('includes_delete');
    Route::get('/inactive/{id}','IncludesController@inactive')->name('includes_inactive');
    Route::get('/activate/{id}','IncludesController@activate')->name('includes_activate');
});
