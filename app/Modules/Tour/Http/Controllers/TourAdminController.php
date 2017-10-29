<?php

namespace App\Modules\Tour\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\Tour\Models\Tour as TourModel;
use App\Modules\Tour\Models\TourBanner as TourBannerModel;
use App\Modules\Tour\Models\TourType as TourTypeModel;


use Auth;
use Theme;
use Entrust;
use Activity;
use File;

class TourAdminController extends Controller
{

    protected $_data = array();
    protected $bannerPath = array();

    public function __construct()
    {
        $this->middleware('permission:tour-admin-view')->only('show');
        $this->middleware('permission:tour-admin-add')->only('add');
        $this->middleware('permission:tour-admin-edit')->only('edit');
        $this->middleware('permission:tour-admin-delete')->only('delete');

        $this->urlBanner                                = '/media/banner/';
        $this->bannerPath                               = public_path($this->urlBanner);


        $this->_data['MenuActive']                      = 'Tour';
        $this->_data['form_name']                       = 'tour';
    }

    public function index(){
        $this->_data['MenuDescription']                 = 'Daftar Tour';
        $this->_data['datatables']                      = 'tour_admin';

        return Theme::view('modules.tour.admin.show',$this->_data);
    }


    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar Tour';
        $this->_data['datatables']                      = 'tour_admin';

        return Theme::view('modules.tour.admin.show',$this->_data);
    }

    public function datatables(){
        $Tour = TourModel::join('regions','tours.region_id','=','regions.id')
                    ->join('countrys','tours.country_id','=','countrys.id')
                    ->join('destinations','tours.destination_id','=','destinations.id')
                    ->select(['tours.id', 'tours.name as tour', 'regions.name as region', 'countrys.name as country', 'destinations.name as destination']);

        return Datatables::of($Tour)
            ->addColumn('href', function ($Tour) {
                return '
                        <a href="'.route('tour_admin_edit',$Tour->id).'" class="btn btn-outline-primary btn-rounded"><i class="glyphicon glyphicon-pencil"></i></a>&nbsp;&nbsp;
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$Tour->id.')"><i class="glyphicon glyphicon-trash"></i></a>';
            })

            ->rawColumns(['href'])
            ->withTrashed()
            ->make(true);
    }


    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Tour';

        return Theme::view('modules.tour.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150',
            'region'            => 'required',
            'country'           => 'required',
            'destination'       => 'required',
            'cost_of_good'      => 'required',
            'price'             => 'required'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Include                               = "";
        if($request->include){
            foreach ($request->include as $include){
                $Include                       .= $include.",";
            }
            $Include                           .= "|";

            $Include                           = str_replace(",|","",$Include);
        }

        $Exclude                               = "";
        if($request->exclude){
            foreach ($request->exclude as $exclude){
                $Exclude                       .= $exclude.",";
            }
            $Exclude                           .= "|";

            $Exclude                           = str_replace(",|","",$Exclude);
        }


        $Tour                                           = new TourModel();
        $Tour->region_id                                = $request->region;
        $Tour->country_id                               = $request->country;
        $Tour->destination_id                           = $request->destination;
        $Tour->name                                     = $request->name;
        $Tour->duration                                 = $request->duration;
        $Tour->youtube                                  = $request->youtube;
        $Tour->itinerary                                = $request->itinerary;
        $Tour->term_condition                           = $request->term_condition;
        $Tour->include                                  = $Include;
        $Tour->exclude                                  = $Exclude;
        $Tour->cost_of_good                             = set_clearFormatRupiah($request->cost_of_good);
        $Tour->price                                    = set_clearFormatRupiah($request->price);
        $Tour->created_by                               = Auth::id();
        $Tour->updated_by                               = Auth::id();

        try{
            $Tour->save();
            return redirect()
                ->route('tour_admin_edit',$Tour->id)
                ->with('InfoMsg','Data Sudah berhasil disimpan. Silakan lengkapi Tour <strong>"'.$Tour->name.'"</strong>.');
        }catch (\Exception $e){
            $data                                    = array(
                "status"                                => false,
                "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
            );
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region_id"                         => $request->region_id,
                "country_id"                        => $request->country_id,
                "destination_id"                    => $request->destination_id,
                "name"                              => $request->name,
                "youtube"                           => $request->youtube,
                "itinerary"                         => $request->itinerary,
                "term_condition"                    => $request->term_condition,
                "include"                           => $Include,
                "exclude"                           => $Exclude,
                "cost_of_good"                      => set_clearFormatRupiah($request->cost_of_good),
                "price"                             => set_clearFormatRupiah($request->price)
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'Tour',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data tour",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('tour_admin_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");

        }
    }

    public function edit($TourID){

        $this->_data['state']                           = 'edit';
        $this->_data['MenuDescription']                 = 'Form Perubahan Tour';

        $this->_data['id']                              = $TourID;
        $Tour                                           = TourModel::find($TourID);
        $this->_data['Tour']                            = $Tour;

        $this->_data['Banners']                         = TourBannerModel::where('tour_id','=',$TourID)->get();

        $Includes                                       = array();
        $Arr                                            = explode(",",$Tour->include);
        foreach($Arr as $d){
            $Includes[]                                 = $d;
        }
        $this->_data['Includes']                        = $Includes;



        return Theme::view('modules.tour.admin.form',$this->_data);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'name'              => 'required|max:150',
            'region'            => 'required',
            'country'           => 'required',
            'destination'       => 'required',
            'cost_of_good'      => 'required',
            'price'             => 'required'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $Include                               = "";
        if($request->include){
            foreach ($request->include as $include){
                $Include                       .= $include.",";
            }
            $Include                           .= "|";

            $Include                           = str_replace(",|","",$Include);
        }

        $Exclude                               = "";
        if($request->exclude){
            foreach ($request->exclude as $exclude){
                $Exclude                       .= $exclude.",";
            }
            $Exclude                           .= "|";

            $Exclude                           = str_replace(",|","",$Exclude);
        }

        $TourID                                         = $request->id;
        $Tour                                           = TourModel::find($TourID);
        $Tour->region_id                                = $request->region;
        $Tour->country_id                               = $request->country;
        $Tour->destination_id                           = $request->destination;
        $Tour->name                                     = $request->name;
        $Tour->duration                                 = $request->duration;
        $Tour->youtube                                  = $request->youtube;
        $Tour->itinerary                                = $request->itinerary;
        $Tour->term_condition                           = $request->term_condition;
        $Tour->include                                  = $Include;
        $Tour->exclude                                  = $Exclude;
        $Tour->cost_of_good                             = set_clearFormatRupiah($request->cost_of_good);
        $Tour->price                                    = set_clearFormatRupiah($request->price);
        $Tour->updated_by                               = Auth::id();

        try{
            $Tour->save();
            return redirect()
                ->route('tour_admin_show')
                ->with('ScsMsg','Data Sudah berhasil disimpan.');
        }catch (\Exception $e){
            $data                                    = array(
                "status"                                => false,
                "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
            );
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "region_id"                         => $request->region_id,
                "country_id"                        => $request->country_id,
                "destination_id"                    => $request->destination_id,
                "name"                              => $request->name,
                "youtube"                           => $request->youtube,
                "itinerary"                         => $request->itinerary,
                "term_condition"                    => $request->term_condition,
                "include"                           => $Include,
                "exclude"                           => $Exclude,
                "cost_of_good"                      => set_clearFormatRupiah($request->cost_of_good),
                "price"                             => set_clearFormatRupiah($request->price)
            );

            Activity::log([
                'contentId'     => $TourID,
                'contentType'   => 'Tour',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat memperbaharui data tour",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);

            return redirect()
                ->route('tour_admin_edit',$TourID)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }
    }

    public function upload(Request $request){
        $File                                       = $request->file('banner');
        $TourID                                     = $request->tour_id;
        $Count                                      = count($File);
        $TourBannerCount                            = TourBannerModel::where('tour_id','=',$TourID)->count();
        if($TourBannerCount == 4){
            $data                                    = array(
                "status"                                => false,
                "tour_id"                               => $TourID,
                "info"                                  => 'banner',
                "message"                               => 'Paket Tour memiliki Maksimal 4 Banner.'
            );
        }else{
            $Banner                                 = "";
            $BannerFiles                            = $this->bannerUpload($File);
            if($BannerFiles){
                $OrderImage                         = new TourBannerModel();
                $OrderImage->file                   = $BannerFiles;
                $OrderImage->tour_id                = $TourID;
                $OrderImage->created_by             = Auth::id();
                try{
                    $OrderImage->save();
                    $Banner                            .= '<img src="'.url("/").$this->urlBanner.$BannerFiles.'" style="width:50px;height:50px;">';
                    $data                                    = array(
                        "status"                                => true,
                        "tour_id"                               => $TourID,
                        "banner"                                => $Banner,
                        "message"                               => 'Upload banner berhasil'
                    );
                }catch (\Exception $e){
                    $data                                    = array(
                        "status"                                => false,
                        "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
                    );
                    $Details                                = array(
                        "user_id"                           => Auth::id(),
                        "tour_id"                           => $TourID,
                        "banner"                            => $BannerFiles
                    );

                    Activity::log([
                        'contentId'     => $TourID,
                        'contentType'   => 'Tour',
                        'action'        => 'upload',
                        'description'   => "Ada kesalahan saat menyimpan menguplad banner",
                        'details'       => $e->getMessage(),
                        'data'          => json_encode($Details),
                        'updated'       => Auth::id(),
                    ]);
                }
            }else{
                $data                                    = array(
                    "status"                                => false,
                    "message"                               => 'Sorry, technical error. Please contact your web developer(4)'
                );
                return response($data, 200)
                    ->header('Content-Type', 'text/plain');
            }
        }

        return response($data, 200)
            ->header('Content-Type', 'text/plain');

    }

    public function load($TourID){
        $Banners                                        = TourBannerModel::where('tour_id','=',$TourID)->get();

        $this->_data['Banners']                         = $Banners;

        return Theme::view('modules.tour.admin.load', $this->_data);
    }


    /**
     * Processing Save Image File.
     * @param \Illuminate\Http\UploadedFile Get Uploaded file for save it on server folder
     * @return String saved FileName
     */
    public function bannerUpload($file_image){
        if ($file_image->isValid()) {
            $str_fileName = time().'-'.$file_image->getClientOriginalName();
            $file_image->move($this->bannerPath, $str_fileName);

            return $str_fileName;
        }
    }

    public function get(Request $request){
        $RegionID                       = $request->region;
        $CountryID                      = $request->country;
        $DestinationID                  = $request->destination;
        $Key                            = $request->term['term'];


        $Tour                           = TourModel::where('region_id','=',$RegionID)->where('country_id','=',$CountryID)->where('destination_id','=',$DestinationID)->where('name','LIKE', "%{$Key}%")->get();
        if($Tour){
            $x                          = 0;
            $Arr                        = array();
            foreach ($Tour as $item){
                $Arr[$x]['id']          = $item->id;
                $Arr[$x]['name']        = $item->name;
                $Arr[$x]['duration']    = $item->duration;
                $x++;
            }

            return json_encode($Arr);
        }else{

        }

    }


}
