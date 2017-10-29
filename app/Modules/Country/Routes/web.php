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

Route::group(['prefix' => 'country','middleware' => 'auth'], function () {

    Route::get('/','CountryController@show')->name('country');
    Route::get('/show','CountryController@show')->name('country_show');
    Route::get('/datatables','CountryController@datatables')->name('country_datatables');
    Route::get('/add','CountryController@add')->name('country_add');
    Route::post('/post','CountryController@post')->name('country_post');
    Route::get('/edit/{id}','CountryController@edit')->name('country_edit');
    Route::post('/update','CountryController@update')->name('country_update');
    Route::get('/delete/{id}','CountryController@delete')->name('country_delete');
    Route::get('/inactive/{id}','CountryController@inactive')->name('country_inactive');
    Route::get('/activate/{id}','CountryController@activate')->name('country_activate');


    Route::get('/searchcountry/{RegionID}','CountryController@searchcountry')->name('country_searchcountry');
    Route::post('/searchbyregion','CountryController@searchbyregion')->name('country_searchbyregion');
    Route::post('/searchbyregionid','CountryController@searchbyregionid')->name('country_searchbyregionid');
});
