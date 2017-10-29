<?php

namespace App\Modules\Tour\Http\Controllers;

use App\Modules\Opentrip\Models\OpenTrip;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Illuminate\Support\Facades\Validator;

use App\Modules\Tour\Models\Tour as TourModel;
use App\Modules\Tour\Models\TourBanner as TourBannerModel;
use App\Modules\Tour\Models\TourType as TourTypeModel;
use App\Modules\Hotoffer\Models\HotOffer as HotOfferModel;
use App\Modules\Opentrip\Models\OpenTrip as OpenTripModel;

use Auth;
use Theme;
use Entrust;
use Activity;
use File;


class TourSearchController extends Controller
{

    protected $_data = array();
    protected $bannerPath = array();

    public function __construct()
    {
        $this->middleware(['permission:layanan-menu']);
        $this->middleware(['permission:tour-menu']);

        $this->urlBanner                                = '/media/banner/';
        $this->bannerPath                               = public_path($this->urlBanner);


        $this->_data['MenuActive']                      = 'Cari Paket';
        $this->_data['form_name']                       = 'search';
    }

    public function show(){
        $this->_data['state']                           = 'form';
        $this->_data['MenuDescription']                 = 'Temukan Paket Tour Sesuai keinginanmu';
        $this->_data['Block']                           = 'none';

        return Theme::view('modules.tour.search.show',$this->_data);
    }

    public function search(Request $request){
        $this->_data['state']                           = 'search';
        $this->_data['MenuDescription']                 = 'Temukan Paket Tour Sesuai keinginanmu';
        $Type                                           = $request->type;

        $this->_data['Type']                            = $request->type;
        $this->_data['Region']                          = $request->region;
        $this->_data['Country']                         = $request->country;
        $this->_data['Destination']                     = $request->destination;

        if($Type == 1){ // HOT OFFER //
            $HotOffer                                       = HotOfferModel::where('is_active','=',1)->get();
            $ArrTour                                        = array();
            foreach($HotOffer as $item){
                if($item->tour->count() > 0){
                    array_push($ArrTour,$item->tour_id);
                }
            }

            $Tours                                          = TourModel::whereIn('id',$ArrTour)->get();
            $this->_data['Block']                           = 'none';

        }else if($Type == 2){ // PRVATE TRIP
            if($request->region == 0 && $request->country == 0 && $request->destination == 0){
                $Where                                      = array(
                    'is_active'                             => 1
                );
            }else{
                $Where                                      = array(
                    'is_active'                             => 1
                );

                if($request->region > 0 || $request->region != "0"){
                    $Where['region_id']                     = $request->region;
                }
                if($request->country > 0 || $request->country != "0"){
                    $Where['country_id']                    = $request->country;
                }
                if($request->destination > 0 || $request->destination != "0"){
                    $Where['destination_id']                = $request->destination;
                }
            }

            $Tours                                      = TourModel::where($Where)->get();
            $this->_data['Block']                           = 'block';
        }else if($Type == 3){ // OPEN TRIP

            if($request->region == 0 && $request->country == 0 && $request->destination == 0){
                $Where                                      = array(
                    'is_active'                             => 1
                );
            }else{
                $Where                                      = array(
                    'is_active'                             => 1
                );

                if($request->region > 0 || $request->region != "0"){
                    $Where['region_id']                     = $request->region;
                }
                if($request->country > 0 || $request->country != "0"){
                    $Where['country_id']                    = $request->country;
                }
                if($request->destination > 0 || $request->destination != "0"){
                    $Where['destination_id']                = $request->destination;
                }
            }

            $ToursTemp                                      = TourModel::where($Where)->get();
            $ArrTour                                        = array();
            foreach($ToursTemp as $Temp){
                if($Temp->open_trip->count() > 0){
                    array_push($ArrTour,$Temp->id);
                }
            }
            $Tours                                          = TourModel::whereIn('id',$ArrTour)->get();
            $this->_data['Block']                           = 'block';

        }else if($Type == 4){ // CUSTOME TRIP
            return redirect()->route('tour_search_custom')->with('InfoMsg','Mohon isi form di bawah ini');
        }else{
            return redirect()->route('tour_search_custom')->with('InfoMsg','Mohon isi form di bawah ini');
        }

        $this->_data['Tours']                           = $Tours;

        return Theme::view('modules.tour.search.show',$this->_data);
    }

    public function custom(){
        dd("Custom");
        return Theme::view('modules.tour.search.custom',$this->_data);
    }

    public function view($Param){
        $Param                                          = base64_decode($Param);
        $Param                                          = explode("|",$Param);
        $TourID                                         = $Param[0];
        $Type                                           = $Param[1];

        $TourInfo                                       = TourModel::find($TourID);

        $this->_data['state']                           = 'search';
        $this->_data['MenuDescription']                 = "Paket ".$TourInfo->name;
        $this->_data['TourInfo']                        = $TourInfo;
        $this->_data['Type']                            = $Type;
        if($Type == 1){ // HOT OFFER //
            $this->_data['HotOpenTrip']                  = $TourInfo->open_trip->count();
        }

        return Theme::view('modules.tour.search.view',$this->_data);
    }

    public function checkquotas(Request $request){
        $validator = Validator::make($request->all(), [
            'open_trip'                 => 'required|max:1',
            'quota'                     => 'required'
        ],[
            'open_trip.required'        => 'Jadwal wajib diisi.',
            'open_trip.min'             => 'Jadwal wajib diisi.',
            'open_trip.quota'           => 'Jumlah Orang wajib diisi.'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }


        $OpenTripList                                   = OpenTripModel::find($request->open_trip);
        $RequestQuota                                   = set_clearFormatRupiah($request->quota);

        $this->_data['state']                           = 'check_quota';

        $this->_data['MenuTitle']                       = $OpenTripList->tour->name." - ". DateFormat($OpenTripList->departure_date,"d F Y");
        $this->_data['MenuDescription']                 = "Pilih Class pada tour yang kamu pilih";
        $this->_data['TourInfo']                        = $OpenTripList->tour;
        $this->_data['OpenTripList']                    = $OpenTripList;
        $this->_data['Quotas']                          = $RequestQuota;

        if($OpenTripList->open_trip_quota->count() > 0){
            $ArrKeep                                    = array();
            foreach($OpenTripList->open_trip_quota as $QuotaReady){
                $SisaQuota                              = $QuotaReady->quota - $QuotaReady->volume;
                if($SisaQuota >= $RequestQuota){
                    array_push($ArrKeep,1);
                    break;
                }
            }
            if(array_sum($ArrKeep) > 0){
                return Theme::view('modules.tour.search.check_quota',$this->_data);
            }else{
                return redirect()->back()->with('WrngMsg','<h2 class="text-white"><i class="ti ti-na"></i> Perhatian</h2><i>Maksimal pax yang tersedia dalam open trip ini</i>' )->withInput($request->input());
            }
        }else{
            return redirect()->back()->with('WrngMsg','Open Trip tidak tersedia' )->withInput($request->input());
        }
    }


}
