<?php

namespace App\Modules\Hotoffer\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Hotoffer\Models\HotOffer as HotOfferModel;
use App\Modules\Tour\Models\Tour as TourModel;
use App\Modules\Opentrip\Models\OpenTrip as OpenTripModel;

use Auth;
use Theme;
use Entrust;
use Activity;


class HotOfferAdminController extends Controller
{

    protected $_data = array();

    public function __construct()
    {

        $this->middleware('permission:hotoffer-admin-view')->only('show');
        $this->middleware('permission:hotoffer-admin-add')->only('post');
        $this->middleware('permission:hotoffer-admin-delete')->only('delete');
        $this->middleware('permission:hotoffer-admin-inactive')->only('inactive');
        $this->middleware('permission:hotoffer-admin-activate')->only('activate');

        $this->_data['MenuActive']                          = 'Hot Offer';
        $this->_data['form_name']                           = 'hotoffer';
    }

    public function datatables(){
        $HotOffer = HotOfferModel::join('tours','tours.id','=','hot_offers.tour_id')
            ->select(['hot_offers.id','tours.name as tour','hot_offers.order as urut','hot_offers.is_active']);

        return Datatables::of($HotOffer)
            ->addColumn('href', function ($HotOffer) {
                if($HotOffer->is_active == 0){
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-success btn-rounded" onclick="activateList('.$HotOffer->id.')"><i class="fa fa-check-circle"></i></a>';
                }else{
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-warning btn-rounded" onclick="inactiveList('.$HotOffer->id.')"><i class="fa fa-ban"></i></a>';
                }
                return '
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$HotOffer->id.')"><i class="fa fa-trash"></i></a>&nbsp;'. $BtnActive;
            })


            ->editColumn('is_active', function ($HotOffer) {
                if($HotOffer->is_active == 1){
                    return '<span class="label label-sm label-success">'.get_active($HotOffer->is_active).'</span>';
                }else{
                    return '<span class="label label-sm label-danger">'.get_active($HotOffer->is_active).'</span>';
                }

            })

            ->rawColumns(['href','is_active'])
            ->withTrashed()
            ->make(true);
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Hot Offer';
        $this->_data['datatables']                      = 'hotoffer';

        return Theme::view('modules.hotoffer.admin.show',$this->_data);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Hot Offer';
        return Theme::view('modules.hotoffer.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'region'            => 'required|min:1',
            'country'           => 'required|min:1',
            'destination'       => 'required|min:1',
            'tour'              => 'required|min:1|unique:hot_offers,tour_id'
        ],[
            'region.min'                            => 'Region Wajib diisi!',
            'country.min'                           => 'Negara Wajib diisi!',
            'destination.min'                       => 'Destinasi wajib diisi!',
            'tour.min'                              => 'Tour wajib diisi!',
            'tour.required'                         => 'Tour wajib diisi!',
            'tour.unique'                           => 'Tour Sudah terdaftar sebagai Hot Offer!'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Tour                                           = TourModel::find($request->tour);

        $HotOffer                                       = new HotOfferModel();
        $HotOffer->tour_id                              = $request->tour;
        $HotOffer->order                                = $request->order;
        $HotOffer->is_active                            = 1;
        $HotOffer->created_by                           = Auth::id();
        $HotOffer->updated_by                           = Auth::id();

        try{
            $HotOffer->save();
            return redirect()
                ->route('hotoffer_admin_show')
                ->with('ScsMsg','Hot Offer <strong>'.$Tour->name.'</strong> telah berhasil ditambahkan');
        }catch (\Exception $e){
            $data                                    = array(
                "status"                                => false,
                "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
            );
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "tour_id"                            => $request->tour,
                "order"                             => $request->order
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Hot Offer',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data Hot Offer",
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

    public function delete($HotOfferID){

        if($HotOfferID){
            $HotOfferInfo                                  = HotOfferModel::find($HotOfferID);
            try{
                $HotOfferInfo->delete();
                return redirect()
                    ->route('hotoffer_admin_show')
                    ->with('ScsMsg', 'Hot Offer ' . $HotOfferInfo->tour->name.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "hot_offer_id"                      => $HotOfferID,
                );

                Activity::log([
                    'contentId'     => $HotOfferID,
                    'contentType'   => 'Hot Offer',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('hotoffer_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "hot_offer_id"                          => $HotOfferID,
            );

            Activity::log([
                'contentId'     => $HotOfferID,
                'contentType'   => 'Hot Offer',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('hotoffer_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function inactive($HotOfferID){
        if($HotOfferID){
            $HotOfferInfo                                   = HotOfferModel::find($HotOfferID);
            $HotOfferInfo->is_active                        = 0;
            $HotOfferInfo->updated_by                       = Auth::id();
            try{
                $HotOfferInfo->save();
                return redirect()
                    ->route('hotoffer_admin_show')
                    ->with('ScsMsg','Data Hot Offer '. $HotOfferInfo->tour->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "hot_offer_id"                      => $HotOfferID,
                );

                Activity::log([
                    'contentId'     => $HotOfferID,
                    'contentType'   => 'Hot Offer',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('hotoffer_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "hot_offer_id"                       => $HotOfferID,
            );

            Activity::log([
                'contentId'     => $HotOfferID,
                'contentType'   => 'Hot Offer',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('hotoffer_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($HotOfferID){
        if($HotOfferID){
            $HotOfferInfo                               = HotOfferModel::find($HotOfferID);
            $HotOfferInfo->is_active                    = 1;
            $HotOfferInfo->updated_by                   = Auth::id();
            try{
                $HotOfferInfo->save();
                return redirect()
                    ->route('hotoffer_admin_show')
                    ->with('ScsMsg', 'Data Hot Offer '. $HotOfferInfo->tour->name.' berhasil di aktifkan.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "hot_offer_id"                       => $HotOfferID,
                );

                Activity::log([
                    'contentId'     => $HotOfferID,
                    'contentType'   => 'Hot Offer',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('hotoffer_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "hot_offer_id"                       => $HotOfferID,
            );

            Activity::log([
                'contentId'     => $HotOfferID,
                'contentType'   => 'Hot Offer',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('hotoffer_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }


}
