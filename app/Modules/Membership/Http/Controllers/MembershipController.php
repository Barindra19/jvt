<?php

namespace App\Modules\Membership\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;


use App\Modules\Membership\Models\Membership as MembershipModel;

use Auth;
use Theme;
use Entrust;
use Activity;


class MembershipController extends Controller
{
    protected $_data = array();

    public function __construct()
    {
        $this->middleware('permission:pendaftaran-agen-add')->only('add');

        $this->_data['MenuActive']                      = 'Form Pendaftaran Agen';
        $this->_data['form_name']                       = 'pendaftaran_agen';
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Pendaftaran keagenan';

        return Theme::view('modules.membership.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'store_name'                => 'required|max:150',
            'name'                      => 'required|max:100',
            'address'                   => 'required',
            'province'                  => 'required',
            'phone'                     => 'required|max:15',
            'mobile'                    => 'required|max:15',
            'email'                     => 'required|email|max:150'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }
        $Level                                              = $request->level;
        if($Level == 2){ ### CABANG -> SISTEM ###
            $Upline                                         = 1;
        }else if($Level == 3){ ### MD -> CABANG ###
            if(Auth::user()->level_id == 3 || Auth::user()->level_id == 2){
                $Upline                                         = Auth::id();
            }else{
                $Upline                                         = $request->cabang;
            }
        }else if($Level == 4){ ### DISTRIBUTOR -> MD
            if(Auth::user()->level_id == 4 || Auth::user()->level_id == 3){
                $Upline                                         = Auth::id();
            }else{
                $Upline                                         = $request->masterdistributor;
            }
        }else if($Level == 5){ ### AGEN -> DISTRIBUTOR
            if(Auth::user()->level_id == 5 || Auth::user()->level_id == 4){
                $Upline                                         = Auth::id();
            }else{
                $Upline                                         = $request->distributor;
            }
        }

        if($Upline == ""){
            return redirect()
                ->back()
                ->with('ErrMsg',"Upline masih kosong. Upline Wajib diisi")
                ->withInput($request->input());
        }


        $Membership                                         = new MembershipModel();
        $Membership->name                                   = $request->name;
        $Membership->store_name                             = $request->store_name;
        $Membership->address                                = $request->address;
        $Membership->province_id                            = $request->province;
        $Membership->phone                                  = $request->phone;
        $Membership->mobile                                 = $request->mobile;
        $Membership->email                                  = $request->email;
        $Membership->upline                                 = $Upline;
        $Membership->is_active                              = 0;
        $Membership->created_by                             = Auth::id();
        $Membership->updated_by                             = Auth::id();

        try{
            $Membership->save();
            return redirect()
                ->route('membership_add')
                ->with('ScsMsg','Data berhasil disimpan');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "store_name"                        => $request->store_name,
                "name"                              => $request->name,
                "address"                           => $request->address,
                "province_id"                       => $request->province_id,
                "phone"                             => $request->phone,
                "mobile"                            => $request->mobile,
                "email"                             => $request->email,
                "upline"                            => $request->upline
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Membership',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('membership_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }


}
