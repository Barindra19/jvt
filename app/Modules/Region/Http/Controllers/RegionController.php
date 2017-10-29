<?php

namespace App\Modules\Region\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Region\Models\Region as RegionModel;

use Auth;
use Theme;
use Entrust;
use Activity;

class RegionController extends Controller
{

    protected $_data = array();


    public function __construct()
    {
        $this->middleware(['permission:region-admin-view']);
        $this->middleware('permission:region-admin-add')->only('add');
        $this->middleware('permission:region-admin-edit')->only('edit');
        $this->middleware('permission:region-admin-delete')->only('delete');
        $this->middleware('permission:region-admin-inactive')->only('inactive');
        $this->middleware('permission:region-admin-activate')->only('activate');


        $this->_data['MenuActive']                      = 'Region';
        $this->_data['form_name']                       = 'region';
    }

    public function datatables(){
        $Region = RegionModel::select(['id','name','is_active']);

        return Datatables::of($Region)
            ->addColumn('href', function ($Region) {
                if($Region->is_active == 0){
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-success btn-rounded" onclick="activateList('.$Region->id.')"><i class="fa fa-check-circle"></i></a>';
                }else{
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-warning btn-rounded" onclick="inactiveList('.$Region->id.')"><i class="fa fa-ban"></i></a>';
                }
                return '
                        <a href="'.route('region_edit',$Region->id).'" class="btn btn-outline-primary btn-rounded"><i class="fa fa-edit"></i></a>&nbsp;
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$Region->id.')"><i class="fa fa-trash"></i></a>&nbsp;'. $BtnActive;
            })

            ->editColumn('is_active', function ($Region) {
                if($Region->is_active == 1){
                    return '<span class="label label-sm label-success">'.get_active($Region->is_active).'</span>';
                }else{
                    return '<span class="label label-sm label-danger">'.get_active($Region->is_active).'</span>';
                }

            })

            ->rawColumns(['href','is_active'])
            ->withTrashed()
            ->make(true);
    }

    public function index(){
        $this->_data['MenuDescription']                 = 'Daftar Region';
        $this->_data['datatables']                      = 'region';

        return Theme::view('modules.region.admin.show',$this->_data);
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Region';
        $this->_data['datatables']                      = 'region';

        return Theme::view('modules.region.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Region';
        return Theme::view('modules.region.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Region                                         = new RegionModel();
        $Region->name                                   = $request->name;
        $Region->is_active                              = 1;
        $Region->created_by                             = Auth::id();
        $Region->updated_by                             = Auth::id();

        try{
            $Region->save();
            return redirect()
                ->route('region_show')
                ->with('ScsMsg','Data berhasil disimpan');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region"                            => $request->name,
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Region',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('region_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");

        }

    }

    public function edit($RegionID){
        $this->_data['state']                           = 'edit';
        $this->_data['MenuDescription']                 = 'Form Edit Region';

        $this->_data['Region']                          = RegionModel::find($RegionID);
        $this->_data['id']                              = $RegionID;
        return Theme::view('modules.region.admin.form',$this->_data);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }
        $RegionID                                       = $request->id;
        $Region                                         = RegionModel::find($RegionID);
        $Region->name                                   = $request->name;
        $Region->is_active                              = 1;
        $Region->updated_by                             = Auth::id();

        try{
            $Region->save();
            return redirect()
                ->route('region_show')
                ->with('ScsMsg','Perubahan data berhasil.');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region"                            => $request->name,
            );

            Activity::log([
                'contentId'     => $RegionID,
                'contentType'   => 'Region',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('region_edit',$RegionID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");

        }

    }

    public function inactive($RegionID){
        if($RegionID){
            $RegionInfo                             = RegionModel::find($RegionID);
            $RegionInfo->is_active                  = 0;
            $RegionInfo->updated_by                 = Auth::id();
            try{
                $RegionInfo->save();
                return redirect()
                    ->route('region_show')
                    ->with('ScsMsg', $RegionInfo->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "region_id"                         => $RegionID,
                );

                Activity::log([
                    'contentId'     => $RegionID,
                    'contentType'   => 'Region',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('region_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region_id"                         => $RegionID,
            );

            Activity::log([
                'contentId'     => $RegionID,
                'contentType'   => 'Region',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('region_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($RegionID){
        if($RegionID){
            $RegionInfo                             = RegionModel::find($RegionID);
            $RegionInfo->is_active                  = 1;
            $RegionInfo->updated_by                 = Auth::id();
            try{
                $RegionInfo->save();
                return redirect()
                    ->route('region_show')
                    ->with('ScsMsg', $RegionInfo->name.' berhasil di aktifkan.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "region_id"                         => $RegionID,
                );

                Activity::log([
                    'contentId'     => $RegionID,
                    'contentType'   => 'Region',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('region_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region_id"                         => $RegionID,
            );

            Activity::log([
                'contentId'     => $RegionID,
                'contentType'   => 'Region',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('region_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($RegionID){
        if($RegionID){
            $RegionInfo                             = RegionModel::find($RegionID);
            try{
                $RegionInfo->delete();
                return redirect()
                    ->route('region_show')
                    ->with('ScsMsg', $RegionInfo->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "region_id"                         => $RegionID,
                );

                Activity::log([
                    'contentId'     => $RegionID,
                    'contentType'   => 'Region',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('region_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region_id"                         => $RegionID,
            );

            Activity::log([
                'contentId'     => $RegionID,
                'contentType'   => 'Region',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('region_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

}
