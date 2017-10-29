<?php

namespace App\Modules\Destination\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Destination\Models\Destination as DestinationModel;

use Auth;
use Theme;
use Entrust;
use Activity;

class DestinationController extends Controller
{
    protected $_data = array();

    public function __construct()
    {
        $this->middleware('permission:destination-admin-add')->only('add');
        $this->middleware('permission:destination-admin-edit')->only('edit');
        $this->middleware('permission:destination-admin-delete')->only('delete');
        $this->middleware('permission:destination-admin-inactive')->only('inactive');
        $this->middleware('permission:destination-admin-activate')->only('activate');

        $this->_data['MenuActive']                      = 'Destination';
        $this->_data['form_name']                       = 'destination';
    }

    public function datatables(){
        $Destination = DestinationModel::join('countrys','countrys.id','=','destinations.country_id')
            ->join('regions','regions.id','=','countrys.region_id')
            ->select(['destinations.id','destinations.name','regions.name as region','countrys.name as country','destinations.is_active']);

        return Datatables::of($Destination)
            ->addColumn('href', function ($Destination) {
                if($Destination->is_active == 0){
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-success btn-rounded" onclick="activateList('.$Destination->id.')"><i class="fa fa-check-circle"></i></a>';
                }else{
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-warning btn-rounded" onclick="inactiveList('.$Destination->id.')"><i class="fa fa-ban"></i></a>';
                }

                return '
                        <a href="'.route('destination_edit',$Destination->id).'" class="btn btn-outline-primary btn-rounded"><i class="fa fa-edit"></i></a>&nbsp;
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$Destination->id.')"><i class="fa fa-trash"></i></a>&nbsp;'. $BtnActive;
            })

            ->editColumn('is_active', function ($Destination) {
                if($Destination->is_active == 1){
                    return '<span class="label label-sm label-success">'.get_active($Destination->is_active).'</span>';
                }else{
                    return '<span class="label label-sm label-danger">'.get_active($Destination->is_active).'</span>';
                }

            })

            ->rawColumns(['href','is_active'])
            ->withTrashed()
            ->make(true);
    }

    public function index(){
        $this->_data['MenuDescription']                 = 'Daftar Destinasi';
        $this->_data['datatables']                      = 'destination';

        return Theme::view('modules.destination.admin.show',$this->_data);
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Destinasi';
        $this->_data['datatables']                      = 'destination';

        return Theme::view('modules.destination.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Destinasi';

        return Theme::view('modules.destination.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150',
            'region'            => 'required|min:1',
            'country'           => 'required|min:1'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Destination                                        = new DestinationModel();
        $Destination->name                                  = $request->name;
        $Destination->region_id                             = $request->region;
        $Destination->country_id                            = $request->country;
        $Destination->is_active                             = 1;
        $Destination->created_by                            = Auth::id();
        $Destination->updated_by                            = Auth::id();

        try{
            $Destination->save();
            return redirect()
                ->route('destination_show')
                ->with('ScsMsg','Data berhasil disimpan');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "destination"                       => $request->name,
                "region_id"                         => $request->region,
                "country_id"                        => $request->country,
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Destination',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('destination_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function edit($DestinationID){
        $this->_data['state']                           = 'edit';
        $this->_data['MenuDescription']                 = 'Form Edit Negara';

        $this->_data['Destination']                     = DestinationModel::find($DestinationID);
        $this->_data['id']                              = $DestinationID;
        return Theme::view('modules.destination.admin.form',$this->_data);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150',
            'region'            => 'required|min:1',
            'country'           => 'required|min:1'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $DestinationID                                      = $request->id;
        $Destination                                        = DestinationModel::find($DestinationID);
        $Destination->name                                  = $request->name;
        $Destination->region_id                             = $request->region;
        $Destination->country_id                            = $request->country;
        $Destination->is_active                             = 1;
        $Destination->updated_by                            = Auth::id();

        try{
            $Destination->save();
            return redirect()
                ->route('destination_show')
                ->with('ScsMsg','Perubahan Data berhasil');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "destination"                       => $request->name,
                "region_id"                         => $request->region,
                "country_id"                        => $request->country
            );

            Activity::log([
                'contentId'     => $DestinationID,
                'contentType'   => 'Destination',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat perubahan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('destination_edit',$DestinationID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function inactive($DestinationID){
        if($DestinationID){
            $DestinationInfo                            = DestinationModel::find($DestinationID);
            $DestinationInfo->is_active                 = 0;
            $DestinationInfo->updated_by                = Auth::id();
            try{
                $DestinationInfo->save();
                return redirect()
                    ->route('destination_show')
                    ->with('ScsMsg', $DestinationInfo->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "destination_id"                    => $DestinationID,
                );

                Activity::log([
                    'contentId'     => $DestinationID,
                    'contentType'   => 'Destination',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('destination_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "destination_id"                         => $DestinationID,
            );

            Activity::log([
                'contentId'     => $DestinationID,
                'contentType'   => 'Destination',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('destination_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($DestinationID){
        if($DestinationID){
            $DestinationInfo                                = DestinationModel::find($DestinationID);
            $DestinationInfo->is_active                     = 1;
            $DestinationInfo->updated_by                    = Auth::id();
            try{
                $DestinationInfo->save();
                return redirect()
                    ->route('destination_show')
                    ->with('ScsMsg', $DestinationInfo->name.' telah aktif.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "destination_id"                    => $DestinationID,
                );

                Activity::log([
                    'contentId'     => $DestinationID,
                    'contentType'   => 'Destination',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('destination_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "destination_id"                    => $DestinationID,
            );

            Activity::log([
                'contentId'     => $DestinationID,
                'contentType'   => 'Destination',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('destination_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($DestinationID){
        if($DestinationID){
            $DestinationInfo                                = DestinationModel::find($DestinationID);
            try{
                $DestinationInfo->delete();
                return redirect()
                    ->route('destination_show')
                    ->with('ScsMsg', $DestinationInfo->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "destination_id"                        => $DestinationID,
                );

                Activity::log([
                    'contentId'     => $DestinationID,
                    'contentType'   => 'Destination',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('destination_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "destination_id"                         => $DestinationID,
            );

            Activity::log([
                'contentId'     => $DestinationID,
                'contentType'   => 'Destination',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('destination_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function searchbycountry(Request $request){
        $RegionID                                       = $request->region_id;
        $CountryID                                      = $request->country_id;

        $Where                                          = array(
            "is_active"                                 => 1,
            "region_id"                                 => $RegionID,
            "country_id"                                => $CountryID
        );
        $Destination                                    = DestinationModel::where($Where)->orderBy('name')->get();

        echo '<option value="0">Pilih Destinasi</option>';
        foreach($Destination as $item){
            echo '<option value="'.$item->id.'">' . $item->name . '</option>';
        }
    }
}
