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

Route::group(['prefix' => 'news/admin','middleware' => 'auth'], function () {
    Route::get('/','NewsAdminController@show')->name('news_admin_show');
    Route::get('/datatables','NewsAdminController@datatables')->name('news_admin_datatables');
    Route::get('/add','NewsAdminController@add')->name('news_admin_add');
    Route::post('/post','NewsAdminController@post')->name('news_admin_post');
    Route::get('/edit/{id}','NewsAdminController@edit')->name('news_admin_edit');
    Route::post('/update','NewsAdminController@update')->name('news_admin_update');
    Route::get('/delete/{id}','NewsAdminController@delete')->name('news_admin_delete');
    Route::get('/inactive/{id}','NewsAdminController@inactive')->name('news_admin_inactive');
    Route::get('/activate/{id}','NewsAdminController@activate')->name('news_admin_activate');

});
