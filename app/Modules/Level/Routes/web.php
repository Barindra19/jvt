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

Route::group(['prefix' => 'level','middleware' => 'auth'], function () {
    Route::get('/','LevelController@show')->name('level');
    Route::get('/show','LevelController@show')->name('level_show');
    Route::get('/datatables','LevelController@datatables')->name('level_datatables');
    Route::get('/add','LevelController@add')->name('level_add');
    Route::post('/post','LevelController@post')->name('level_post');
    Route::get('/edit/{id}','LevelController@edit')->name('level_edit');
    Route::post('/update','LevelController@update')->name('level_update');
    Route::get('/delete/{id}','LevelController@delete')->name('level_delete');

    Route::post('/komisi/get','LevelController@getKomisi')->name('level_komisi_get');
    Route::post('/komisi/save','LevelController@saveKomisi')->name('level_komisi_save');
    Route::post('/komisi/delete','LevelController@deleteKomisi')->name('level_komisi_delete');


    Route::post('/searchbylevel','LevelController@searchbylevel')->name('level_komisi_searchbylevel');
    Route::post('/searchbycabang','LevelController@searchbycabang')->name('level_komisi_searchbycabang');
    Route::post('/searchbymasterdistributor','LevelController@searchbymasterdistributor')->name('level_komisi_searchbymasterdistributor');
    Route::post('/searchbydistributor','LevelController@searchbydistributor')->name('level_komisi_searchbydistributor');

});
