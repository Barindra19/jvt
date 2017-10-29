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

Route::group(['prefix' => 'tour/admin','middleware' => 'auth'], function () {
    Route::get('/show','TourAdminController@show')->name('tour_admin_show');
    Route::get('/datatables','TourAdminController@datatables')->name('tour_admin_datatables');
    Route::get('/add','TourAdminController@add')->name('tour_admin_add');
    Route::post('/post','TourAdminController@post')->name('tour_admin_post');
    Route::get('/edit/{id}','TourAdminController@edit')->name('tour_admin_edit');
    Route::post('/update','TourAdminController@update')->name('tour_admin_update');
    Route::get('/delete/{id}','TourAdminController@delete')->name('tour_admin_delete');

    Route::post('/upload','TourAdminController@upload')->name('tour_admin_upload');
    Route::get('/load/{TourID}','TourAdminController@load')->name('tour_admin_load');

    Route::post('/get','TourAdminController@get')->name('tour_admin_get');

});


Route::group(['prefix' => 'tour/search','middleware' => 'auth'], function () {
    Route::get('/','TourSearchController@show')->name('tour_search_show');
    Route::post('/show','TourSearchController@search')->name('tour_search_action');
    Route::get('/view/{TourID}','TourSearchController@view')->name('tour_search_view');
    Route::post('/checkquotas','TourSearchController@checkquotas')->name('tour_search_checkquotas');
    Route::get('/custom','TourSearchController@custom')->name('tour_search_custom');

});