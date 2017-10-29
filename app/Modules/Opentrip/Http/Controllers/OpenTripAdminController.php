<?php

namespace App\Modules\Opentrip\Http\Controllers;

use App\Modules\Opentrip\Models\OpenTrip;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Classtour\Models\ClassTour as ClassTourModel;
use App\Modules\Opentrip\Models\OpenTripQuota as OpenTripQuotaModel;
use App\Modules\Tour\Models\Tour as TourModel;

use Auth;
use Theme;
use Entrust;
use Activity;


class OpenTripAdminController extends Controller
{
    protected $_data = array();

    public function __construct()
    {

        $this->middleware('permission:opentrip-admin-view')->only('show');
        $this->middleware('permission:opentrip-admin-add')->only('add');
        $this->middleware('permission:opentrip-admin-edit')->only('edit');
        $this->middleware('permission:opentrip-admin-delete')->only('delete');
        $this->middleware('permission:opentrip-admin-inactive')->only('inactive');
        $this->middleware('permission:opentrip-admin-activate')->only('activate');


        $this->_data['MenuActive']                          = 'Open Trip';
        $this->_data['form_name']                           = 'opentrip';
    }

    public function datatables(){
        $OpenTrip = OpenTrip::join('tours','tours.id','=','open_trips.tour_id')
                            ->select(['open_trips.id','tours.name as tour','open_trips.departure_date','open_trips.is_active']);

        return Datatables::of($OpenTrip)
            ->addColumn('href', function ($OpenTrip) {
                if($OpenTrip->is_active == 0){
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-success btn-rounded" onclick="activateList('.$OpenTrip->id.')"><i class="fa fa-check-circle"></i></a>';
                }else{
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-warning btn-rounded" onclick="inactiveList('.$OpenTrip->id.')"><i class="fa fa-ban"></i></a>';
                }
                return '
                        <a href="'.route('opentrip_admin_edit',$OpenTrip->id).'" class="btn btn-outline-primary btn-rounded"><i class="fa fa-edit"></i></a>&nbsp;
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$OpenTrip->id.')"><i class="fa fa-trash"></i></a>&nbsp;'. $BtnActive;
            })

            ->editColumn('departure_date', function ($OpenTrip) {
                return DateFormat($OpenTrip->departure_date,'d F Y');
            })

            ->editColumn('is_active', function ($OpenTrip) {
                if($OpenTrip->is_active == 1){
                    return '<span class="label label-sm label-success">'.get_active($OpenTrip->is_active).'</span>';
                }else{
                    return '<span class="label label-sm label-danger">'.get_active($OpenTrip->is_active).'</span>';
                }

            })

            ->rawColumns(['href','is_active'])
            ->withTrashed()
            ->make(true);
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Open Trip';
        $this->_data['datatables']                      = 'opentrip';

        return Theme::view('modules.opentrip.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Open Trip';
        return Theme::view('modules.opentrip.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'region'            => 'required|min:1',
            'country'           => 'required|min:1',
            'destination'       => 'required|min:1',
            'tour'              => 'required|min:1',
            'departure_date'    => 'required|date|date_format:d-m-Y|after:today'

        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

//        dd($request);
        $Tour                                           = TourModel::find($request->tour);

        $OpenTrip                                       = new OpenTrip();
        $OpenTrip->tour_id                              = $request->tour;
        $OpenTrip->name                                 = $Tour->name;
        $OpenTrip->departure_date                       = DateFormat($request->departure_date,"Y-m-d");
        $OpenTrip->guide                                = $request->guide;
        $OpenTrip->is_active                            = 1;
        $OpenTrip->created_by                           = Auth::id();
        $OpenTrip->updated_by                           = Auth::id();

        try{
            $OpenTrip->save();
            return redirect()
                ->route('opentrip_admin_edit',$OpenTrip->id)
                ->with('InfoMsg','Open Trip <strong>'.$Tour->name.'</strong> telah dibuat. Silakan isi detail trip');
        }catch (\Exception $e){
            $data                                    = array(
                "status"                                => false,
                "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
            );
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region"                            => $request->region,
                "country"                           => $request->country,
                "destination"                       => $request->destination,
                "tour"                              => $request->tour,
                "departure_date"                    => $request->departure_date,
                "guide"                             => $request->guide
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Open Trip',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data Open Trip",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->back()
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function edit($OpenTripID){
        $this->_data['state']                           = 'edit';
        $OpenTrip                                       = OpenTrip::find($OpenTripID);

        $this->_data['MenuDescription']                 = 'Form Ubah Open Trip <label class="text-danger">' . $OpenTrip->tour->name. '</label>';
        $this->_data['OpenTrip']                        = $OpenTrip;
        $this->_data['id']                              = $OpenTripID;

        return Theme::view('modules.opentrip.admin.form',$this->_data);

    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'departure_date'    => 'required|date|date_format:d-m-Y|after:today'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $OpenTripID                                         = $request->id;

        $OpenTrip                                           = OpenTrip::find($OpenTripID);
        $OpenTrip->departure_date                           = DateFormat($request->departure_date,"Y-m-d");
        $OpenTrip->guide                                    = $request->guide;
        $OpenTrip->is_active                                = 1;
        $OpenTrip->updated_by                               = Auth::id();

        $OpentripInfo                                       = OpenTrip::find($OpenTripID);
        try{
            $OpenTrip->save();
            return redirect()
                ->route('opentrip_admin_show')
                ->with('ScsMsg','Perubahan Data berhasil');
        }catch (\Exception $e){
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "open_trip_id"                      => $OpenTripID,
                "tour_id"                           => $OpentripInfo->tour_id,
                "departure_date"                    => DateFormat($request->departure_date,"Y-m-d"),
                "guide"                             => $request->guide
            );

            Activity::log([
                'contentId'     => $OpenTripID,
                'contentType'   => 'Open Trip Quota',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat menyimpan data",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('opentrip_admin_edit', $OpenTripID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function inactive($OpenTripID){
        if($OpenTripID){
            $OpenTripInfo                               = OpenTrip::find($OpenTripID);
            $OpenTripInfo->is_active                   = 0;
            $OpenTripInfo->updated_by                  = Auth::id();
            try{
                $OpenTripInfo->save();
                return redirect()
                    ->route('opentrip_admin_show')
                    ->with('ScsMsg', $OpenTripInfo->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "opentrip_id"                       => $OpenTripID,
                );

                Activity::log([
                    'contentId'     => $OpenTripID,
                    'contentType'   => 'Open Trip',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('opentrip_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "opentrip_id"                       => $OpenTripID,
            );

            Activity::log([
                'contentId'     => $OpenTripID,
                'contentType'   => 'Open Trip',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('opentrip_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($OpenTripID){
        if($OpenTripID){
            $OpenTripInfo                               = OpenTrip::find($OpenTripID);
            $OpenTripInfo->is_active                    = 1;
            $OpenTripInfo->updated_by                   = Auth::id();
            try{
                $OpenTripInfo->save();
                return redirect()
                    ->route('opentrip_admin_show')
                    ->with('ScsMsg', $OpenTripInfo->name.' berhasil di aktifkan.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "opentrip_id"                       => $OpenTripID,
                );

                Activity::log([
                    'contentId'     => $OpenTripID,
                    'contentType'   => 'Open Trip',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('opentrip_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "opentrip_id"                       => $OpenTripID,
            );

            Activity::log([
                'contentId'     => $OpenTripID,
                'contentType'   => 'Open Trip',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('opentrip_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($OpenTripID){
        if($OpenTripID){
            $OpenTripInfo                                  = OpenTrip::find($OpenTripID);
            try{
                $OpenTripInfo->delete();
                $OpenTripQuota                              = OpenTripQuotaModel::where('open_trip_id','=',$OpenTripID)->delete();

                return redirect()
                    ->route('opentrip_admin_show')
                    ->with('ScsMsg', $OpenTripInfo->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "open_trip_id"                          => $OpenTripID,
                );

                Activity::log([
                    'contentId'     => $OpenTripID,
                    'contentType'   => 'Open Trip',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('opentrip_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "open_trip_id"                          => $OpenTripID,
            );

            Activity::log([
                'contentId'     => $OpenTripID,
                'contentType'   => 'Open Trip',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('opentrip_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }
    }

    public function saveQuota(Request $request){
        $validator = Validator::make($request->all(), [
            'tour_class'                                => 'required|min:1',
            'cost_of_good'                              => 'required|min:1',
            'selling_price'                             => 'required',
            'quota'                                     => 'required'
        ],[
            'tour_class.required'                      => 'Tour Class Wajib diisi!',
            'tour_class.min'                           => 'Tour Class Wajib diisi!',
            'cost_of_good.required'                    => 'Harga Modal wajib diisi!',
            'quota.required'                           => 'Quota wajib diisi!'
        ]);

        if ($validator->fails()) {
            $data                                   = array(
                "status"                                => false,
                "message"                               => $validator->errors()->all(),
                "validator"                             => $validator->errors()
            );
        }else{
            if($request->statusform == 'edit'){
                $OpenTripQuota                          = OpenTripQuotaModel::find($request->quota_id);
            }else{
                $OpenTripQuota                          = new OpenTripQuotaModel();
            }
            $OpenTripQuota->open_trip_id                = $request->id;
            $OpenTripQuota->class_tour_id               = $request->tour_class;
            $OpenTripQuota->cost_of_good                = set_clearFormatRupiah($request->cost_of_good);
            $OpenTripQuota->selling_price               = set_clearFormatRupiah($request->selling_price);
            $OpenTripQuota->quota                       = set_clearFormatRupiah($request->quota);
            $OpenTripQuota->quota_update                = date('Y-m-d H:i:s');
            $OpenTripQuota->created_by                  = Auth::id();
            $OpenTripQuota->updated_by                  = Auth::id();

            if($request->statusform == 'edit'){
                $OpenTripQuotaInfo                      = OpenTripQuotaModel::find($request->quota_id);
                if($OpenTripQuotaInfo->open_trip_id == $request->id && $OpenTripQuotaInfo->class_tour_id == $request->tour_class && $OpenTripQuotaInfo->cost_of_good == $request->cost_of_good  && $OpenTripQuotaInfo->selling_price == $request->selling_price  && $OpenTripQuotaInfo->quota == $request->quota){
                    try {
                        $OpenTripQuota->save();
                        $OpenTripInfo                               = OpenTrip::find($OpenTripQuota->open_trip_id);
                        $data                                       = array(
                            "status"                                => true,
                            "message"                               => 'Berhasil! Perubahan Open Trip berhasil.',
                            "output"                                => array(
                                "id"                                => $OpenTripQuota->id,
                                "open_trip_id"                      => $request->open_trip_id,
                                "class_tour"                        => $OpenTripQuota->tour_class->name,
                                "tour_name"                         => $OpenTripInfo->tour->name,
                                "cost_of_good"                      => "Rp " . number_format(set_clearFormatRupiah($request->cost_of_good),0,",","."),
                                "selling_price"                     => "Rp " . number_format(set_clearFormatRupiah($request->selling_price),0,",","."),
                                "quota"                             => number_format(set_clearFormatRupiah($request->quota),0,",","."),
                                "volume"                            => $OpenTripQuota->volume,
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
                            'contentId'     => $request->quota_id,
                            'contentType'   => 'Open Trip Quota',
                            'action'        => 'saveQuota',
                            'description'   => "ada error pada saat mengubah Open Trip Quota",
                            'details'       => $e->getMessage(),
                            'data'          => json_encode($Details),
                            'updated'       => Auth::id(),
                        ]);
                    }
                }else{
                    $WhereCheck                         = array(
                        'open_trip_id'                  => $request->id,
                        'id'                            => $request->quota_id,
                        'class_tour_id'                 => $request->tour_class
                    );
                    $Check                                      = OpenTripQuotaModel::where($WhereCheck)->count();
                    if($Check > 0){
                        try {
                            $OpenTripQuota->save();
                            $OpenTripInfo                               = OpenTrip::find($OpenTripQuota->open_trip_id);
                            $data                                   = array(
                                "status"                                => true,
                                "message"                               => 'Berhasil! Peruahan Komisi berhasil..',
                                "output"                                => array(
                                    "id"                                => $OpenTripQuota->id,
                                    "open_trip_id"                      => $request->open_trip_id,
                                    "class_tour"                        => $OpenTripQuota->tour_class->name,
                                    "tour_name"                         => $OpenTripInfo->tour->name,
                                    "cost_of_good"                      => "Rp " . number_format(set_clearFormatRupiah($request->cost_of_good),0,",","."),
                                    "selling_price"                     => "Rp " . number_format(set_clearFormatRupiah($request->selling_price),0,",","."),
                                    "quota"                             => number_format(set_clearFormatRupiah($request->quota),0,",","."),
                                    "volume"                            => $OpenTripQuota->volume,
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
                                "id"                                => $OpenTripInfo->id,
                                "open_trip_id"                      => $request->open_trip_id,
                                "class_tour_id"                     => $request->tour_class,
                                "cost_of_good"                      => set_clearFormatRupiah($request->cost_of_good),
                                "selling_price"                     => set_clearFormatRupiah($request->selling_price),
                                "quota"                             => set_clearFormatRupiah($request->quota),
                                "statusform"                        => $request->statusform
                            );
                            Activity::log([
                                'contentId'     => $request->quota_id,
                                'contentType'   => 'Open Trip Quota',
                                'action'        => 'saveQuota',
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
                    $OpenTripQuota->save();
                    $OpenTripInfo                               = OpenTrip::find($OpenTripQuota->open_trip_id);
                    $data                                   = array(
                        "status"                                => true,
                        "message"                               => 'Berhasil! Komisi berhasil ditambahkan.',
                        "output"                                => array(
                            "id"                                => $OpenTripQuota->id,
                            "open_trip_id"                      => $request->open_trip_id,
                            "class_tour"                        => $OpenTripQuota->tour_class->name,
                            "tour_name"                         => $OpenTripInfo->tour->name,
                            "cost_of_good"                      => "Rp " . number_format(set_clearFormatRupiah($request->cost_of_good),0,",","."),
                            "selling_price"                     => "Rp " . number_format(set_clearFormatRupiah($request->selling_price),0,",","."),
                            "quota"                             => number_format(set_clearFormatRupiah($request->quota),0,",","."),
                            "volume"                            => 0,
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
                        "open_trip_id"                      => $request->open_trip_id,
                        "class_tour_id"                     => $request->tour_class,
                        "cost_of_good"                      => set_clearFormatRupiah($request->cost_of_good),
                        "selling_price"                     => set_clearFormatRupiah($request->selling_price),
                        "quota"                             => set_clearFormatRupiah($request->quota),
                        "statusform"                        => $request->statusform
                    );
                    Activity::log([
                        'contentId'     => 0,
                        'contentType'   => 'Open Trip Quota',
                        'action'        => 'saveQuota',
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

    public function deleteQuota(Request $request){
        $OpenTripQuotaID                                = $request->id;
        $OpenTrip                                       = OpenTripQuotaModel::find($OpenTripQuotaID);
        if($OpenTrip){
            try{
                OpenTripQuotaModel::find($OpenTripQuotaID)->delete();
                $data                                       = array(
                    "status"                                    => true,
                    'id'                                        => $OpenTripQuotaID,
                    "message"                                   => 'Open Trip berhasil dihapus'
                );
            }catch (\Exception $e){
                $data                                       = array(
                    "status"                                    => false,
                    'komisi_id'                                 => $OpenTripQuotaID,
                    "message"                                   => 'Maaf, ada Kesalahan teknis. Mohon hubungi web developer'
                );

                $Details                                = array(
                    'open_trip_id'                              => $OpenTripQuotaID
                );

                Activity::log([
                    'contentId'     => $OpenTripQuotaID,
                    'contentType'   => 'Open Trip Quota',
                    'action'        => 'deleteDetail',
                    'description'   => "Ada kesalahan pada saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
            }
        }else{
            $data                                       = array(
                "status"                                    => false,
                "quoda_id"                                  => $OpenTripQuotaID,
                "message"                                   => 'Maaf, ada Kesalahan teknis. Mohon hubungi web developer'
            );

            $Details                                = array(
                'quoda_id'                                  => $OpenTripQuotaID
            );

            Activity::log([
                'contentId'   => $OpenTripQuotaID,
                'contentType' => 'Open Trip Quota',
                'action'      => 'deleteDetail',
                'description' => "Data Tidak ditemukan di database.",
                'details'     => json_encode($Details),
                'updated'     => Auth::id(),
            ]);
        }
        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }

    public function getQuota(Request $request){
        $OpenTripQuotaID                                = $request->id;
        $OpenTripQuotaInfo                              = OpenTripQuotaModel::find($OpenTripQuotaID);
        if($OpenTripQuotaInfo){
            $data                                           = array(
                "status"                                    => true,
                "output"                                    => array(
                    "id"                                    => $OpenTripQuotaID,
                    "open_trip"                             => $OpenTripQuotaInfo->open_trip_id,
                    "class_tour"                            => $OpenTripQuotaInfo->class_tour_id,
                    "cost_of_good"                          => $OpenTripQuotaInfo->cost_of_good,
                    "selling_price"                         => $OpenTripQuotaInfo->selling_price,
                    "quota"                                 => $OpenTripQuotaInfo->quota,
                    "volume"                                => $OpenTripQuotaInfo->volume,
                    "statusform"                            => 'edit'
                ),
                "message"                                   => 'Data anda telah ditampilkan'
            );
        }else{
            $data                                       = array(
                "status"                                    => false,
                "open_tour_quota_id"                        => $OpenTripQuotaID,
                "message"                                   => 'Maaf, ada Kesalahan teknis. Mohon hubungi web developer'
            );

            $Details                                = array(
                'open_tour_quota_id'                        => $OpenTripQuotaID
            );

            Activity::log([
                'contentId'   => $OpenTripQuotaID,
                'contentType' => 'Oepn Tour Quota',
                'action'      => 'getQuota',
                'description' => "Data Tidak ditemukan di database.",
                'details'     => json_encode($Details),
                'updated'     => Auth::id(),
            ]);
        }
        return response($data, 200)
            ->header('Content-Type', 'text/plain');
    }



}
