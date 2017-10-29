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

Route::group(['prefix' => 'opentrip/admin', 'middleware' => 'auth'], function () {
    Route::get('/','OpenTripAdminController@show')->name('opentrip_admin');
    Route::get('/show','OpenTripAdminController@show')->name('opentrip_admin_show');
    Route::get('/datatables','OpenTripAdminController@datatables')->name('opentrip_admin_datatables');
    Route::get('/add','OpenTripAdminController@add')->name('opentrip_admin_add');
    Route::post('/post','OpenTripAdminController@post')->name('opentrip_admin_post');
    Route::get('/edit/{id}','OpenTripAdminController@edit')->name('opentrip_admin_edit');
    Route::post('/update','OpenTripAdminController@update')->name('opentrip_admin_update');
    Route::get('/delete/{id}','OpenTripAdminController@delete')->name('opentrip_admin_delete');
    Route::get('/inactive/{id}','OpenTripAdminController@inactive')->name('opentrip_admin_inactive');
    Route::get('/activate/{id}','OpenTripAdminController@activate')->name('opentrip_admin_activate');

    Route::post('/get','OpenTripAdminController@getQuota')->name('opentrip_admin_get');
    Route::post('/save','OpenTripAdminController@saveQuota')->name('opentrip_admin_save');
    Route::post('/deletedetail','OpenTripAdminController@deleteQuota')->name('opentrip_admin_delete');

});
