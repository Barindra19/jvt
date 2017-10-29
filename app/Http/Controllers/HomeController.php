<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Theme;

use App\Modules\News\Models\News as NewsModel;

use Auth;
use App\User;


class HomeController extends Controller
{
    protected $_data = array();

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $Users                                          = Auth::user();
        if(bool_CheckUserRole('mitra')){
            $News                                       = NewsModel::where('is_active','=',1)->where('date_active', '>=',date('Y-m-d'))->paginate(5);
            $this->_data['NewsCount']                   = NewsModel::where('is_active','=',1)->where('date_active', '>=',date('Y-m-d'))->count();
            $this->_data['News']                        = $News;
            $this->_data['MyWallet']                    = $Users->wallet;
        }elseif (bool_CheckUserRole('admin')){
            $this->_data['CountCabang']                 = User::where('is_active','=',1)->where('level_id','=',2)->count();
            $this->_data['CountMD']                     = User::where('is_active','=',1)->where('level_id','=',3)->count();
            $this->_data['CountDistributor']            = User::where('is_active','=',1)->where('level_id','=',4)->count();
            $this->_data['CountAgen']                   = User::where('is_active','=',1)->where('level_id','=',5)->count();
        }

        return Theme::view('home',$this->_data);
    }
}
