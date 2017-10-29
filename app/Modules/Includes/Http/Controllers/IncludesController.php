<?php

namespace App\Modules\Includes\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Includes\Models\Includes as IncludeModel;

use Auth;
use Theme;
use Entrust;
use Activity;


class IncludesController extends Controller
{

    protected $_data = array();

    public function __construct()
    {
        $this->middleware('permission:include-admin-view')->only('index');
        $this->middleware('permission:include-admin-view')->only('show');
        $this->middleware('permission:include-admin-add')->only('add');
        $this->middleware('permission:include-admin-edit')->only('edit');
        $this->middleware('permission:include-admin-delete')->only('delete');
        $this->middleware('permission:include-admin-inactive')->only('inactive');
        $this->middleware('permission:include-admin-activate')->only('activate');

        $this->_data['MenuActive']                      = 'Include & Exclude';
        $this->_data['form_name']                       = 'include';
    }


    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Include & Exclude';
        $this->_data['datatables']                      = 'include';
        $this->_data['Includes']                         = IncludeModel::all();

        return Theme::view('modules.includes.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Include & Exclude';

        return Theme::view('modules.includes.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:50'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Includes                                           = new IncludeModel();
        $Includes->name                                     = $request->name;
        $Includes->icon                                     = $request->icon;
        $Includes->description                              = $request->description;
        $Includes->is_active                                = 1;
        $Includes->created_by                               = Auth::id();
        $Includes->updated_by                               = Auth::id();

        try{
            $Includes->save();
            return redirect()
                ->route('includes_show')
                ->with('ScsMsg','Data berhasil disimpan');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "name"                              => $request->name,
                "icon"                              => $request->icon,
                "description"                       => $request->description
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Includes',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('includes_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function edit($IncludesID){
        $this->_data['state']                           = 'edit';
        $this->_data['MenuDescription']                 = 'Form Edit Include & Exclude';
        $IncludeInfo                                    = IncludeModel::find($IncludesID);

        $this->_data['Includes']                        = $IncludeInfo;
        $this->_data['id']                              = $IncludesID;

        return Theme::view('modules.includes.admin.form',$this->_data);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:50'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $IncludesID                                         = $request->id;

        $Includes                                           = IncludeModel::find($IncludesID);
        $Includes->name                                     = $request->name;
        $Includes->icon                                     = $request->icon;
        $Includes->description                              = $request->description;
        $Includes->is_active                                = 1;
        $Includes->created_by                               = Auth::id();
        $Includes->updated_by                               = Auth::id();

        try{
            $Includes->save();
            return redirect()
                ->route('includes_show')
                ->with('ScsMsg','Perubahan Data berhasil');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "include_id"                        => $IncludesID,
                "name"                              => $request->name,
                "icon"                              => $request->icon,
                "description"                       => $request->description
            );

            Activity::log([
                'contentId'     => $IncludesID,
                'contentType'   => 'Includes',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('includes_edit',$IncludesID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function inactive($IncludesID){
        if($IncludesID){
            $IncludesInfo                               = IncludeModel::find($IncludesID);
            $IncludesInfo->is_active                    = 0;
            $IncludesInfo->updated_by                   = Auth::id();
            try{
                $IncludesInfo->save();
                return redirect()
                    ->route('includes_show')
                    ->with('ScsMsg', $IncludesInfo->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "includes_id"                       => $IncludesID,
                );

                Activity::log([
                    'contentId'     => $IncludesID,
                    'contentType'   => 'Includes',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('includes_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                                   => Auth::id(),
                "includes_id"                               => $IncludesID,
            );

            Activity::log([
                'contentId'     => $IncludesID,
                'contentType'   => 'Includes',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('includes_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($IncludesID){
        if($IncludesID){
            $IncludesInfo                                   = IncludeModel::find($IncludesID);
            $IncludesInfo->is_active                     = 1;
            $IncludesInfo->updated_by                    = Auth::id();
            try{
                $IncludesInfo->save();
                return redirect()
                    ->route('includes_show')
                    ->with('ScsMsg', $IncludesInfo->name.' telah aktif.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "includes_id"                       => $IncludesID,
                );

                Activity::log([
                    'contentId'     => $IncludesID,
                    'contentType'   => 'Includes',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('includes_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "includes_id"                       => $IncludesID,
            );

            Activity::log([
                'contentId'     => $IncludesID,
                'contentType'   => 'Includes',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('includes_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($IncludesID){
        if($IncludesID){
            $IncludesInfo                                = IncludeModel::find($IncludesID);
            try{
                $IncludesInfo->delete();
                return redirect()
                    ->route('includes_show')
                    ->with('ScsMsg', $IncludesInfo->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "includes_id"                        => $IncludesID,
                );

                Activity::log([
                    'contentId'     => $IncludesID,
                    'contentType'   => 'Includes',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('includes_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "includes_id"                         => $IncludesID,
            );

            Activity::log([
                'contentId'     => $IncludesID,
                'contentType'   => 'Includes',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('includes_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }



}
