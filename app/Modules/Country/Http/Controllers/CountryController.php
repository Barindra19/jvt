<?php

namespace App\Modules\Country\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Country\Models\Country as CountryModel;


use Auth;
use Theme;
use Entrust;
use Activity;

class CountryController extends Controller
{
    protected $_data = array();
    public function __construct()
    {
        $this->middleware('permission:country-admin-add')->only('add');
        $this->middleware('permission:country-admin-edit')->only('edit');
        $this->middleware('permission:country-admin-delete')->only('delete');
        $this->middleware('permission:country-admin-inactive')->only('inactive');
        $this->middleware('permission:country-admin-activate')->only('activate');


        $this->_data['MenuActive']                      = 'Country';
        $this->_data['form_name']                       = 'country';
    }

    public function datatables(){
        $Country = CountryModel::join('regions','regions.id','=','countrys.region_id')
                                ->select(['countrys.id','countrys.name','regions.name as region','countrys.is_active']);

        return Datatables::of($Country)
            ->addColumn('href', function ($Country) {
                if($Country->is_active == 0){
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-success btn-rounded" onclick="activateList('.$Country->id.')"><i class="fa fa-check-circle"></i></a>';
                }else{
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-warning btn-rounded" onclick="inactiveList('.$Country->id.')"><i class="fa fa-ban"></i></a>';
                }

                return '
                        <a href="'.route('country_edit',$Country->id).'" class="btn btn-outline-primary btn-rounded"><i class="fa fa-edit"></i></a>&nbsp;
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$Country->id.')"><i class="fa fa-trash"></i></a>&nbsp;'. $BtnActive;
            })

            ->editColumn('is_active', function ($Country) {
                if($Country->is_active == 1){
                    return '<span class="label label-sm label-success">'.get_active($Country->is_active).'</span>';
                }else{
                    return '<span class="label label-sm label-danger">'.get_active($Country->is_active).'</span>';
                }

            })

            ->rawColumns(['href','is_active'])
            ->withTrashed()
            ->make(true);
    }

    public function index(){
        $this->_data['MenuDescription']                 = 'Daftar Negara';
        $this->_data['datatables']                      = 'country';

        return Theme::view('modules.country.admin.show',$this->_data);
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Negara';
        $this->_data['datatables']                      = 'country';

        return Theme::view('modules.country.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Negara';

        return Theme::view('modules.country.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150',
            'region'            => 'required|min:1'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Country                                         = new CountryModel();
        $Country->name                                   = $request->name;
        $Country->region_id                              = $request->region;
        $Country->is_active                              = 1;
        $Country->created_by                             = Auth::id();
        $Country->updated_by                             = Auth::id();

        try{
            $Country->save();
            return redirect()
                ->route('country_show')
                ->with('ScsMsg','Data berhasil disimpan');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "country"                           => $request->name,
                "region_id"                         => $request->region,
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Country',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('country_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");

        }

    }

    public function edit($CountryID){
        $this->_data['state']                           = 'edit';
        $this->_data['MenuDescription']                 = 'Form Edit Country';

        $this->_data['Country']                         = CountryModel::find($CountryID);
        $this->_data['id']                              = $CountryID;
        return Theme::view('modules.country.admin.form',$this->_data);

    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150',
            'region'            => 'required|min:1'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $CountryID                                      = $request->id;
        $Country                                        = CountryModel::find($CountryID);
        $Country->name                                  = $request->name;
        $Country->region_id                             = $request->region;
        $Country->is_active                             = 1;
        $Country->updated_by                            = Auth::id();

        try{
            $Country->save();
            return redirect()
                ->route('country_show')
                ->with('ScsMsg','Perubahan Data berhasil');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "country"                           => $request->name,
                "region_id"                         => $request->region,
            );

            Activity::log([
                'contentId'     => $CountryID,
                'contentType'   => 'Country',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat perubahan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('country_edit',$CountryID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function inactive($CountryID){
        if($CountryID){
            $CountryInfo                                = CountryModel::find($CountryID);
            $CountryInfo->is_active                     = 0;
            $CountryInfo->updated_by                    = Auth::id();
            try{
                $CountryInfo->save();
                return redirect()
                    ->route('country_show')
                    ->with('ScsMsg', $CountryInfo->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "country_id"                        => $CountryID,
                );

                Activity::log([
                    'contentId'     => $CountryID,
                    'contentType'   => 'Country',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('country_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "country_id"                         => $CountryID,
            );

            Activity::log([
                'contentId'     => $CountryID,
                'contentType'   => 'Country',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('country_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($CountryID){
        if($CountryID){
            $CountryInfo                                = CountryModel::find($CountryID);
            $CountryInfo->is_active                     = 1;
            $CountryInfo->updated_by                    = Auth::id();
            try{
                $CountryInfo->save();
                return redirect()
                    ->route('country_show')
                    ->with('ScsMsg', $CountryInfo->name.' telah aktif.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "country_id"                        => $CountryID,
                );

                Activity::log([
                    'contentId'     => $CountryID,
                    'contentType'   => 'Country',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('country_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "country_id"                         => $CountryID,
            );

            Activity::log([
                'contentId'     => $CountryID,
                'contentType'   => 'Country',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('country_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($CountryID){
        if($CountryID){
            $CountryInfo                                = CountryModel::find($CountryID);
            try{
                $CountryInfo->delete();
                return redirect()
                    ->route('country_show')
                    ->with('ScsMsg', $CountryInfo->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "country_id"                        => $CountryID,
                );

                Activity::log([
                    'contentId'     => $CountryID,
                    'contentType'   => 'Country',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('country_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "country_id"                         => $CountryID,
            );

            Activity::log([
                'contentId'     => $CountryID,
                'contentType'   => 'Country',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('country_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function searchbyregionid(Request $request){
        $RegionID                                       = $request->region_id;

        $Where                                          = array(
            "region_id"                                 => $RegionID,
        );
        $Country                                        = CountryModel::where($Where)->orderBy('name')->get();

        $x                          = 0;
        $Arr                        = array();
        foreach ($Country as $item){
            $Arr[$x]['id']            = $item->id;
            $Arr[$x]['name']          = $item->name;
            $x++;
        }

        return json_encode($Arr);
    }

    public function searchbyregion(Request $request){
        $RegionID                                       = $request->region_id;

        $Where                                          = array(
            "is_active"                                 => 1,
            "region_id"                                 => $RegionID,
        );
        $Country                                        = CountryModel::where($Where)->orderBy('name')->get();
            echo '<option value="0">Pilih Negara</option>';
        foreach($Country as $item){
            echo '<option value="'.$item->id.'">' . $item->name . '</option>';
        }
    }

    public function searchcountry($RegionID){
        $Country                                        = CountryModel::where('region_id','=',$RegionID)->get();
        $this->_data['ListCountry']                     = $Country;
        return Theme::view('modules.country.admin.select',$this->_data);
    }
}
