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

Route::group(['prefix' => 'hotoffer/admin','middleware' => 'auth'], function () {
    Route::get('/','HotOfferAdminController@show')->name('hotoffer_admin');
    Route::get('/show','HotOfferAdminController@show')->name('hotoffer_admin_show');
    Route::get('/datatables','HotOfferAdminController@datatables')->name('hotoffer_admin_datatables');
    Route::get('/add','HotOfferAdminController@add')->name('hotoffer_admin_add');
    Route::post('/post','HotOfferAdminController@post')->name('hotoffer_admin_post');
    Route::get('/edit/{id}','HotOfferAdminController@edit')->name('hotoffer_admin_edit');
    Route::post('/update','HotOfferAdminController@update')->name('hotoffer_admin_update');
    Route::get('/delete/{id}','HotOfferAdminController@delete')->name('hotoffer_admin_delete');
    Route::get('/inactive/{id}','HotOfferAdminController@inactive')->name('hotoffer_admin_inactive');
    Route::get('/activate/{id}','HotOfferAdminController@activate')->name('hotoffer_admin_activate');
});
