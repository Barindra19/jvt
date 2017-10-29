<?php

namespace App\Modules\Level\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Level\Models\Level as LevelModel;
use App\Modules\Komisi\Models\Komisi as KomisiModel;

use Auth;
use Theme;
use Entrust;
use Activity;

class LevelController extends Controller
{

    protected $_data = array();

    public function __construct()
    {
        $this->middleware('permission:level-admin-view')->only('index');
        $this->middleware('permission:level-admin-view')->only('show');
        $this->middleware('permission:level-admin-add')->only('add');
        $this->middleware('permission:level-admin-edit')->only('edit');
        $this->middleware('permission:level-admin-delete')->only('delete');

        $this->_data['MenuActive']                      = 'Level';
        $this->_data['form_name']                       = 'level';
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Level';
        $this->_data['Levels']                          = LevelModel::all();

        return Theme::view('modules.level.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Level';
        $LevelLast                                      = LevelModel::orderBy('order','desc')->first();
        $this->_data['next']                            = $LevelLast->order + 1;

        return Theme::view('modules.level.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:50',
            'order'             => 'required',
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Level                                              = new LevelModel();
        $Level->name                                        = $request->name;
        $Level->order                                       = set_clearFormatRupiah($request->order);
        $Level->status                                      = 1;
        $Level->created_by                                  = Auth::id();
        $Level->updated_by                                  = Auth::id();

        try{
            $Level->save();
            return redirect()
                ->route('level_edit',$Level->id)
                ->with('ScsMsg','Data berhasil disimpan. Silakan isi komisi detail');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "level"                             => $request->name,
                "order"                             => $request->id,
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Level',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('level_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function edit($LevelID){
        $this->_data['state']                           = 'edit';
        $this->_data['MenuDescription']                 = 'Form Edit Level';
        $LevelInfo                                      = LevelModel::find($LevelID);

        $this->_data['Level']                           = $LevelInfo;
        $this->_data['KomisiKeagenan']                  = KomisiModel::where('komisi_type_id','=',1)->get(); //Keagenan
        $this->_data['KomisiTransaksi']                 = KomisiModel::where('komisi_type_id','=',2)->get(); //Transaksi

        $this->_data['id']                              = $LevelID;

        return Theme::view('modules.level.admin.form',$this->_data);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:50',
            'order'             => 'required'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Parent                                             = $request->parent;
        $LevelID                                            = $request->id;

        $Level                                              = LevelModel::find($LevelID);
        $Level->name                                        = $request->name;
        $Level->order                                       = set_clearFormatRupiah($request->order);
        $Level->status                                      = 1;
        $Level->updated_by                                  = Auth::id();

        try{
            $Level->save();
            return redirect()
                ->route('level_show')
                ->with('ScsMsg','Perubahan Data berhasil');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "level_id"                          => $LevelID,
                "level"                             => $request->name,
                "komisi_1"                          => set_clearFormatRupiah($request->komisi_1),
                "komisi_2"                          => set_clearFormatRupiah($request->komisi_2),
                "parent_id"                         => $Parent,
            );

            Activity::log([
                'contentId'     => $LevelID,
                'contentType'   => 'Level',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('level_edit', $LevelID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($LevelID){
        if($LevelID){
            $LevelInfo                                  = LevelModel::find($LevelID);
            try{
                $LevelInfo->delete();
                return redirect()
                    ->route('level_show')
                    ->with('ScsMsg', $LevelInfo->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "level_id"                          => $LevelID,
                );

                Activity::log([
                    'contentId'     => $LevelID,
                    'contentType'   => 'Level',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('level_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "level_id"                          => $LevelID,
            );

            Activity::log([
                'contentId'     => $LevelID,
                'contentType'   => 'Level',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('level_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function saveKomisi(Request $request){
        $validator = Validator::make($request->all(), [
            'komisi_type'                               => 'required|min:1',
            'level'                                     => 'required|min:1',
            'komisi'                                    => 'required'
        ],[
            'komisi_type.required'                      => 'Tipe Komisi Wajib diisi!',
            'komisi_type.min'                           => 'Tipe Komisi Wajib diisi!',
            'level.required'                            => 'Level wajib diisi!',
            'level.min'                                 => 'Level wajib diisi',
            'komisi.required'                           => 'Komisi wajib diisi!'
        ]);

        if ($validator->fails()) {
            $data                                   = array(
                "status"                                => false,
                "message"                               => $validator->errors()->all(),
                "validator"                             => $validator->errors()
            );
        }else{
            if($request->statusform == 'edit'){
                $Komisi                                 = KomisiModel::find($request->komisi_id);
            }else{
                $Komisi                                 = new KomisiModel();
            }
            $Komisi->komisi_type_id                     = $request->komisi_type;
            $Komisi->level_id                           = $request->id;
            $Komisi->level                              = $request->level;
            $Komisi->komisi                             = set_clearFormatRupiah($request->komisi);
            $Komisi->created_by                         = Auth::id();
            $Komisi->updated_by                         = Auth::id();

            if($request->statusform == 'edit'){
                if($Komisi->komisi_type_id == $request->komisi_type && $Komisi->level == $request->level && $Komisi->level_id == $request->id){
                    try {
                        $Komisi->save();
                        $LevelInfo                              = LevelModel::find($Komisi->level);
                        $data                                   = array(
                            "status"                                => true,
                            "message"                               => 'Berhasil! Peruahan Komisi berhasil.',
                            "output"                                => array(
                                "id"                                => $Komisi->id,
                                "level_id"                          => $request->id,
                                "komisi_type_id"                    => $request->komisi_type,
                                "level"                             => $LevelInfo->name,
                                "komisi"                            => set_clearFormatRupiah($request->komisi),
                                "statusform"                        => $request->statusform
                            )
                        );

                    }catch (\Exception $e) {
                        $data                                    = array(
                            "status"                                => false,
                            "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
                        );
                        $Details                                = array(
                            "user_id"                           => Auth::id(),
                            "level_id"                          => $request->id,
                            "komisi_type_id"                    => $request->komisi_type,
                            "level"                             => $request->level,
                            "komisi"                            => set_clearFormatRupiah($request->komisi),
                            "statusform"                        => $request->statusform,
                            "komisi_id"                         => $request->komisi_id
                        );
                        Activity::log([
                            'contentId'     => $request->komisi_id,
                            'contentType'   => 'Level Komisi',
                            'action'        => 'saveKomisi',
                            'description'   => "ada error pada saat mengubah level komisi",
                            'details'       => $e->getMessage(),
                            'data'          => json_encode($Details),
                            'updated'       => Auth::id(),
                        ]);
                    }
                }else{
                    $WhereCheck                         = array(
                        'level_id'                      => $request->id,
                        'komisi_type_id'                => $request->komisi_type,
                        'level'                         => $request->level
                    );
                    $Check                                      = KomisiModel::where($WhereCheck)->count();
                    if($Check > 0){
                        try {
                            $Komisi->save();
                            $LevelInfo                              = LevelModel::find($Komisi->level);
                            $data                                   = array(
                                "status"                                => true,
                                "message"                               => 'Berhasil! Peruahan Komisi berhasil..',
                                "output"                                => array(
                                    "id"                                => $Komisi->id,
                                    "level_id"                          => $request->id,
                                    "komisi_type_id"                    => $request->komisi_type,
                                    "level"                             => $LevelInfo->name,
                                    "komisi"                            => set_clearFormatRupiah($request->komisi),
                                    "statusform"                        => $request->statusform
                                )
                            );

                        }catch (\Exception $e) {
                            $data                                    = array(
                                "status"                                => false,
                                "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
                            );
                            $Details                                = array(
                                "user_id"                           => Auth::id(),
                                "level_id"                          => $request->id,
                                "komisi_type_id"                    => $request->komisi_type,
                                "level"                             => $request->level,
                                "komisi"                            => set_clearFormatRupiah($request->komisi),
                                "statusform"                        => $request->statusform,
                                "komisi_id"                         => $request->komisi_id
                            );
                            Activity::log([
                                'contentId'     => $request->komisi_id,
                                'contentType'   => 'Level Komisi',
                                'action'        => 'saveKomisi',
                                'description'   => "ada error pada saat mengubah level komisi",
                                'details'       => $e->getMessage(),
                                'data'          => json_encode($Details),
                                'updated'       => Auth::id(),
                            ]);
                        }
                    }else{
                        $data                                   = array(
                            "status"                                => false,
                            "message"                               => 'Maaf, Data sudah terdaftar.'
                        );
                    }
                }
            }else{
                try {
                    $Komisi->save();
                    $LevelInfo                              = LevelModel::find($Komisi->level);
                    $data                                   = array(
                        "status"                                => true,
                        "message"                               => 'Berhasil! Komisi berhasil ditambahkan.',
                        "output"                                => array(
                            "id"                                => $Komisi->id,
                            "level_id"                          => $request->id,
                            "komisi_type_id"                    => $request->komisi_type,
                            "level"                             => $LevelInfo->name,
                            "komisi"                            => set_clearFormatRupiah($request->komisi),
                            "statusform"                        => $request->statusform
                        )
                    );

                }catch (\Exception $e) {
                    $data                                    = array(
                        "status"                                => false,
                        "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
                    );
                    $Details                                = array(
                        "user_id"                           => Auth::id(),
                        "level_id"                          => $request->id,
                        "komisi_type_id"                    => $request->komisi_type,
                        "level"                             => $request->level,
                        "komisi"                            => set_clearFormatRupiah($request->komisi),
                        "statusform"                        => $request->statusform
                    );
                    Activity::log([
                        'contentId'     => 0,
                        'contentType'   => 'Level Komisi',
                        'action'        => 'saveKomisi',
                        'description'   => "ada error pada saat menyimpan level komisi",
                        'details'       => $e->getMessage(),
                        'data'          => json_encode($Details),
                        'updated'       => Auth::id(),
                    ]);
                }
            }
        }

        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }

    public function deleteKomisi(Request $request){
        $KomisiID                                       = $request->id;
        $Komisi                                         = KomisiModel::find($KomisiID);
        if($Komisi){
            $KomisiType                                 = $Komisi->komisi_type_id;
            try{
                KomisiModel::find($KomisiID)->delete();
                $data                                       = array(
                    "status"                                    => true,
                    'id'                                        => $KomisiID,
                    "komisi_type_id"                            => $KomisiType,
                    "message"                                   => 'Komisi Level berhasil dihapus'
                );
            }catch (\Exception $e){
                $data                                       = array(
                    "status"                                    => false,
                    'komisi_id'                                 => $KomisiID,
                    "komisi_type_id"                            => $KomisiType,
                    "message"                                   => 'Maaf, ada Kesalahan teknis. Mohon hubungi web developer'
                );

                $Details                                = array(
                    'komisi_id'                                 => $KomisiID
                );

                Activity::log([
                    'contentId'     => $KomisiID,
                    'contentType'   => 'Level Komisi',
                    'action'        => 'deleteKomisi',
                    'description'   => "Ada kesalahan pada saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
            }
        }else{
            $data                                       = array(
                "status"                                    => false,
                "komisi_id"                                 => $KomisiID,
                "message"                                   => 'Maaf, ada Kesalahan teknis. Mohon hubungi web developer'
            );

            $Details                                = array(
                'komisi_id'                                 => $KomisiID
            );

            Activity::log([
                'contentId'   => $KomisiID,
                'contentType' => 'Level Komisi',
                'action'      => 'deleteKomisi',
                'description' => "Data Tidak ditemukan di database.",
                'details'     => json_encode($Details),
                'updated'     => Auth::id(),
            ]);
        }
        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }

    public function getKomisi(Request $request){
        $KomisiID                                       = $request->id;
        $KomisiInfo                                     = KomisiModel::find($KomisiID);
        if($KomisiInfo){
            $data                                           = array(
                "status"                                    => true,
                "output"                                    => array(
                    "komisi_id"                             => $KomisiID,
                    "komisi_type_id"                        => $KomisiInfo->komisi_type_id,
                    "level_id"                              => $KomisiInfo->level_id,
                    "level"                                 => $KomisiInfo->level,
                    "komisi"                                => $KomisiInfo->komisi,
                    "statusform"                            => 'edit'
                ),
                "message"                                   => 'Data anda telah ditampilkan'
            );
        }else{
            $data                                       = array(
                "status"                                    => false,
                "komisi_id"                                 => $KomisiID,
                "message"                                   => 'Maaf, ada Kesalahan teknis. Mohon hubungi web developer'
            );

            $Details                                = array(
                'komisi_id'                                 => $KomisiID
            );

            Activity::log([
                'contentId'   => $KomisiID,
                'contentType' => 'Level Komisi',
                'action'      => 'getKomisi',
                'description' => "Data Tidak ditemukan di database.",
                'details'     => json_encode($Details),
                'updated'     => Auth::id(),
            ]);
        }
        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }

    public function searchbylevel(Request $request){
        $LevelID                                    = $request->level_id;
        $LevelInfo                                  = LevelModel::find($LevelID);
        if($LevelID == 2){ ### PILIH CABANG ###
            $Upline                                 = $LevelID - 1;
            $data                                       = array(
                "status"                                    => true,
                "message"                                   => 'OK',
                "output"                                    => array(
                    "param_level_id"                        => $LevelID,
                    "level_id"                              => $Upline,
                    "param_level_caption"                   => $LevelInfo->name,
                    'level_user'                            => Auth::user()->level_id
                )
            );
        }else if($LevelID == 3){ ### PILIH MASTER DISTRIBUTOR ###
            $Upline                                 = $LevelID - 1;
            if(Auth::user()->level_id < $Upline){
                $Users                              = '<option value="0">-- Pilih Cabang --</option>';
                $UserList                           = User::where('level_id','=',$Upline)->get();
                foreach ($UserList as $user){
                    $Users                         .= '<option value="'.$user->id.'">'.$user->name.'</option>';
                }

                $data                                       = array(
                    "status"                                    => true,
                    "message"                                   => 'OK',
                    "output"                                    => array(
                        "param_level_id"                        => $LevelID,
                        "level_id"                              => $Upline,
                        "param_level_caption"                   => $LevelInfo->name,
                        "users"                                 => $Users
                    )
                );
            }else if(Auth::user()->level_id == $LevelID){
                $data                                       = array(
                    "param_level_id"                            => $LevelID,
                    "output"                                    => array(
                        "level_user_id"                             => Auth::user()->level_id,
                        "level_user"                                => Auth::user()->level->name
                    )
                );
            }else{
                $data                                       = array(
                    "param_level_id"                            => $LevelID,
                    "output"                                    => array(
                        "level_user_id"                             => Auth::user()->level_id,
                        "level_user"                                => Auth::user()->level->name
                    )
                );
            }
        }else if($LevelID == 4){ ### PILIH DISTRIBUTOR ###
            $Upline                                 = 2;
            if(Auth::user()->level_id != $LevelID){
                if(Auth::user()->level_id == 1){
                    $Users                              = '<option value="0">-- Pilih Cabang --</option>';
                    $UserList                           = User::where('level_id','=',$Upline)->get();
                    foreach ($UserList as $user){
                        $Users                         .= '<option value="'.$user->id.'">'.$user->name.'</option>';
                    }

                    $data                                       = array(
                        "status"                                    => true,
                        "message"                                   => 'OK',
                        "output"                                    => array(
                            "param_level_id"                        => $LevelID,
                            "level_id"                              => $Upline,
                            "param_level_caption"                   => $LevelInfo->name,
                            "users"                                 => $Users,
                            'level_user'                            => Auth::user()->level_id
                        )
                    );
                }else if(Auth::user()->level_id == 2){ // GET MD //
                    $Users                              = '<option value="0">-- Pilih Master Distribution --</option>';
                    $UserList                           = User::where('level_id','=',3)->get();
                    foreach ($UserList as $user){
                        $Users                         .= '<option value="'.$user->id.'">'.$user->name.'</option>';
                    }

                    $data                                       = array(
                        "status"                                    => true,
                        "message"                                   => 'OK',
                        "output"                                    => array(
                            "param_level_id"                        => $LevelID,
                            "level_id"                              => $Upline,
                            "param_level_caption"                   => $LevelInfo->name,
                            "users"                                 => $Users,
                            'level_user'                            => Auth::user()->level_id
                        )
                    );
                }else if(Auth::user()->level_id == 3) { // GET DISTRIBUTOR //
                    $data                                       = array(
                        "param_level_id"                            => $LevelID,
                        "output"                                    => array(
                            "level_user_id"                             => Auth::user()->level_id,
                            "level_user"                                => Auth::user()->level->name
                        )
                    );
                }


            }else{
                $data                                       = array(
                    "param_level_id"                            => $LevelID,
                    "output"                                    => array(
                        "level_user_id"                             => Auth::user()->level_id,
                        "level_user"                                => Auth::user()->level->name
                    )
                );
            }
        }else if($LevelID == 5){ ### PILIH AGEN ###
            $Upline                                 = 2;
            if(Auth::user()->level_id <  4){
                if(Auth::user()->level_id == 1){
                    $Users                              = '<option value="0">-- Pilih Cabang --</option>';
                    $UserList                           = User::where('level_id','=',$Upline)->get();
                    foreach ($UserList as $user){
                        $Users                         .= '<option value="'.$user->id.'">'.$user->name.'</option>';
                    }
                }else if(Auth::user()->level_id == 2){ // GET MD //
                    $Users                              = '<option value="0">-- Pilih Cabang --</option>';
                    $UserList                           = User::where('level_id','=',$Upline)->get();
                    foreach ($UserList as $user){
                        $Users                         .= '<option value="'.$user->id.'">'.$user->name.'</option>';
                    }
//                    $Users                              = '<option value="0">-- Pilih Master Distribution --</option>';
//                    $UserList                           = User::where('level_id','=',3)->get();
//                    foreach ($UserList as $user){
//                        $Users                         .= '<option value="'.$user->id.'">'.$user->name.'</option>';
//                    }
                }else if(Auth::user()->level_id == 3){ // GET DISTRIBUTOR //
                    $Users                              = '<option value="0">-- Pilih Distribution --</option>';
                    $UserList                           = User::where('level_id','=',4)->get();
                    foreach ($UserList as $user){
                        $Users                         .= '<option value="'.$user->id.'">'.$user->name.'</option>';
                    }
                }

                $data                                       = array(
                    "status"                                    => true,
                    "message"                                   => 'OK',
                    "output"                                    => array(
                        "param_level_id"                        => $LevelID,
                        "level_id"                              => $Upline,
                        "param_level_caption"                   => $LevelInfo->name,
                        "users"                                 => $Users,
                        'level_user'                            => Auth::user()->level_id
                    )
                );
            }else{
                $data                                       = array(
                    "param_level_id"                            => $LevelID,
                    "output"                                    => array(
                        "level"                                     => "Agen",
                        "level_user_id"                             => Auth::user()->level_id,
                        "level_user"                                => Auth::user()->level->name
                    )
                );
            }
        }else{
            $data                                       = array(
                "param_level_id"                                    => $LevelID
            );

        }
//        Activity::log([
//            'contentId'   => $KomisiID,
//            'contentType' => 'Level Komisi',
//            'action'      => 'getKomisi',
//            'description' => "Data Tidak ditemukan di database.",
//            'details'     => json_encode($Details),
//            'updated'     => Auth::id(),
//        ]);
        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }

    public function searchbycabang(Request $request){
        $UserID                                         = $request->user_id;
        $LevelID                                        = $request->level_id;
        $UserInfo                                       = User::find($UserID);
        $LevelInfo                                      = LevelModel::find($UserInfo->level_id);

        if($LevelID > 3){ ### Jika Pilihan lebih dari Master Distributor
            $Users                                      = '<option value="0">-- Pilih Master Distributor --</option>';
            $UserList                                   = User::where('up','=', $UserID)->get();
            foreach ($UserList as $user){
                $Users                                 .= '<option value="'.$user->id.'">'.$user->name.'</option>';
            }
            $data                                       = array(
                "status"                                    => true,
                "message"                                   => 'OK',
                "output"                                    => array(
                    "param_level_id"                        => $LevelID,
                    "level_id"                              => $UserInfo->level_id,
                    "param_level_caption"                   => $LevelInfo->name,
                    "users"                                 => $Users
                )
            );
        }else{
            $data                                       = array(
                "status"                                    => true,
                "message"                                   => 'OK, Pencarian tidak dilakukan'
            );

        }
        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }

    public function searchbymasterdistributor(Request $request){
        $UserID                                         = $request->user_id;
        $LevelID                                        = $request->level_id;
        $UserInfo                                       = User::find($UserID);
        $LevelInfo                                      = LevelModel::find($UserInfo->level_id);

        if($LevelID > 4){ ### Jika Pilihan lebih dari Distributor
            $Users                                      = '<option value="0">-- Pilih Distributor --</option>';
            $UserList                                   = User::where('up','=', $UserID)->get();
            foreach ($UserList as $user){
                $Users                                 .= '<option value="'.$user->id.'">'.$user->name.'</option>';
            }
            $data                                       = array(
                "status"                                    => true,
                "message"                                   => 'OK',
                "output"                                    => array(
                    "param_level_id"                        => $LevelID,
                    "level_id"                              => $UserInfo->level_id,
                    "param_level_caption"                   => $LevelInfo->name,
                    "users"                                 => $Users
                )
            );
        }else{
            $data                                       = array(
                "status"                                    => true,
                "message"                                   => 'OK, Pencarian tidak dilakukan'
            );

        }
        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }

}
