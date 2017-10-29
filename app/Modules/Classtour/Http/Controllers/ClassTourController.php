<?php

namespace App\Modules\Classtour\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Classtour\Models\ClassTour as ClassTourModel;

use Auth;
use Theme;
use Entrust;
use Activity;

class ClassTourController extends Controller
{
    protected $_data = array();

    public function __construct()
    {

        $this->middleware('permission:classtour-admin-view')->only('show');
        $this->middleware('permission:classtour-admin-add')->only('add');
        $this->middleware('permission:classtour-admin-edit')->only('edit');
        $this->middleware('permission:classtour-admin-delete')->only('delete');
        $this->middleware('permission:classtour-admin-inactive')->only('inactive');
        $this->middleware('permission:classtour-admin-activate')->only('activate');


        $this->_data['MenuActive']                      = 'Tour Class';
        $this->_data['form_name']                       = 'classtour';
    }

    public function datatables(){
        $ClassTour = ClassTourModel::select(['id','name','is_active']);

        return Datatables::of($ClassTour)
            ->addColumn('href', function ($ClassTour) {
                if($ClassTour->is_active == 0){
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-success btn-rounded" onclick="activateList('.$ClassTour->id.')"><i class="fa fa-check-circle"></i></a>';
                }else{
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-warning btn-rounded" onclick="inactiveList('.$ClassTour->id.')"><i class="fa fa-ban"></i></a>';
                }
                return '
                        <a href="'.route('classtour_edit',$ClassTour->id).'" class="btn btn-outline-primary btn-rounded"><i class="fa fa-edit"></i></a>&nbsp;
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$ClassTour->id.')"><i class="fa fa-trash"></i></a>&nbsp;'. $BtnActive;
            })

            ->editColumn('is_active', function ($ClassTour) {
                if($ClassTour->is_active == 1){
                    return '<span class="label label-sm label-success">'.get_active($ClassTour->is_active).'</span>';
                }else{
                    return '<span class="label label-sm label-danger">'.get_active($ClassTour->is_active).'</span>';
                }

            })

            ->rawColumns(['href','is_active'])
            ->withTrashed()
            ->make(true);
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Tour Class';
        $this->_data['datatables']                      = 'classtour';

        return Theme::view('modules.classtour.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Tour Class';
        return Theme::view('modules.classtour.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $ClassTour                                      = new ClassTourModel();
        $ClassTour->name                                = $request->name;
        $ClassTour->is_active                           = 1;
        $ClassTour->created_by                          = Auth::id();
        $ClassTour->updated_by                          = Auth::id();

        try{
            $ClassTour->save();
            return redirect()
                ->route('classtour_show')
                ->with('ScsMsg','Data berhasil disimpan');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "class"                             => $request->name,
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Class Tour',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('classtour_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");

        }

    }

    public function edit($ClassTourID){
        $this->_data['state']                           = 'edit';
        $this->_data['MenuDescription']                 = 'Form Edit Tour Class';

        $this->_data['ClassTour']                       = ClassTourModel::find($ClassTourID);
        $this->_data['id']                              = $ClassTourID;
        return Theme::view('modules.classtour.admin.form',$this->_data);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }
        $ClassTourID                                    = $request->id;
        $ClassTour                                      = ClassTourModel::find($ClassTourID);
        $ClassTour->name                                = $request->name;
        $ClassTour->is_active                           = 1;
        $ClassTour->updated_by                          = Auth::id();

        try{
            $ClassTour->save();
            return redirect()
                ->route('classtour_show')
                ->with('ScsMsg','Perubahan data berhasil.');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "class"                             => $request->name,
            );

            Activity::log([
                'contentId'     => $ClassTourID,
                'contentType'   => 'Class Tour',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('classtour_edit',$ClassTourID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");

        }

    }

    public function inactive($ClassTourID){
        if($ClassTourID){
            $ClassTourInfo                              = ClassTourModel::find($ClassTourID);
            $ClassTourInfo->is_active                   = 0;
            $ClassTourInfo->updated_by                  = Auth::id();
            try{
                $ClassTourInfo->save();
                return redirect()
                    ->route('classtour_show')
                    ->with('ScsMsg', $ClassTourInfo->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "class_tour_id"                     => $ClassTourID,
                );

                Activity::log([
                    'contentId'     => $ClassTourID,
                    'contentType'   => 'Class Tour',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('classtour_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "class_tour_id"                         => $ClassTourID,
            );

            Activity::log([
                'contentId'     => $ClassTourID,
                'contentType'   => 'Class Tour',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('classtour_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($ClassTourID){
        if($ClassTourID){
            $ClassTourInfo                              = ClassTourModel::find($ClassTourID);
            $ClassTourInfo->is_active                   = 1;
            $ClassTourInfo->updated_by                  = Auth::id();
            try{
                $ClassTourInfo->save();
                return redirect()
                    ->route('classtour_show')
                    ->with('ScsMsg', $ClassTourInfo->name.' berhasil di aktifkan.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "class_tour_id"                     => $ClassTourID,
                );

                Activity::log([
                    'contentId'     => $ClassTourID,
                    'contentType'   => 'Class Tour',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('classtour_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region_id"                         => $ClassTourID,
            );

            Activity::log([
                'contentId'     => $ClassTourID,
                'contentType'   => 'Class Tour',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('classtour_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($ClassTourID){
        if($ClassTourID){
            $ClassTourInfo                              = ClassTourModel::find($ClassTourID);
            try{
                $ClassTourInfo->delete();
                return redirect()
                    ->route('classtour_show')
                    ->with('ScsMsg', $ClassTourInfo->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "class_tour_id"                     => $ClassTourID,
                );

                Activity::log([
                    'contentId'     => $ClassTourID,
                    'contentType'   => 'Class Tour',
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
                "class_tour_id"                         => $ClassTourID,
            );

            Activity::log([
                'contentId'     => $ClassTourID,
                'contentType'   => 'Class Tour',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('classtour_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }



}
