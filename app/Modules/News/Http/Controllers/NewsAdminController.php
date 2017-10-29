<?php

namespace App\Modules\News\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Yajra\Datatables\Facades\Datatables;
use Illuminate\Support\Facades\Validator;

use App\Modules\News\Models\News as NewsModel;

use Auth;
use Theme;
use Entrust;
use Activity;
use File;


class NewsAdminController extends Controller
{
    protected $_data = array();
    protected $bannerFile = array();

    public function __construct()
    {
        $this->middleware('permission:news-admin-view')->only('show');
        $this->middleware('permission:news-admin-add')->only('add');
        $this->middleware('permission:news-admin-edit')->only('edit');
        $this->middleware('permission:news-admin-delete')->only('delete');
        $this->middleware('permission:news-admin-inactive')->only('inactive');
        $this->middleware('permission:news-admin-activate')->only('activate');

        $this->urlNews                                  = '/media/news/';
        $this->bannerPath                               = public_path($this->urlNews);


        $this->_data['MenuActive']                      = 'News';
        $this->_data['form_name']                       = 'news';
    }

    public function show(){
        $this->_data['MenuDescription']                 = 'Daftar News';
        $this->_data['datatables']                      = 'news';

        return Theme::view('modules.news.admin.show',$this->_data);
    }

    public function datatables(){
        $News = NewsModel::select(['id', 'title','is_active','date_active']);

        return Datatables::of($News)
            ->addColumn('href', function ($News) {
                if($News->is_active == 0){
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-success btn-rounded" onclick="activateList('.$News->id.')"><i class="fa fa-check-circle"></i></a>';
                }else{
                    $BtnActive  = '<a href="javascript:void(0);" class="btn btn-outline-warning btn-rounded" onclick="inactiveList('.$News->id.')"><i class="fa fa-ban"></i></a>';
                }
                return '
                        <a href="'.route('news_admin_edit',$News->id).'" class="btn btn-outline-primary btn-rounded"><i class="glyphicon glyphicon-pencil"></i></a>&nbsp;
                        <a href="javascript:void(0);" class="btn btn-outline-danger btn-rounded" onclick="deleteList('.$News->id.')"><i class="glyphicon glyphicon-trash"></i></a>&nbsp;'. $BtnActive;
            })

            ->editColumn('is_active', function ($News) {
                if($News->is_active == 1){
                    return '<span class="label label-sm label-success">'.get_active($News->is_active).'</span>';
                }else{
                    return '<span class="label label-sm label-danger">'.get_active($News->is_active).'</span>';
                }
            })

            ->editColumn('date_active', function ($News) {
                    return '<span class="label label-sm label-info">'.DateFormat($News->date_active,"d F Y").'</span>';
            })


            ->rawColumns(['href','is_active','date_active'])
            ->withTrashed()
            ->make(true);
    }

    public function add(){
        $this->_data['state']                           = 'add';
        $this->_data['MenuDescription']                 = 'Form Tambah Berita';

        return Theme::view('modules.news.admin.form',$this->_data);
    }

    public function post(Request $request){
        $validator = Validator::make($request->all(), [
            'title'                 => 'required|max:255',
            'body'                  => 'required',
            'date_active'           => 'required|date|date_format:d-m-Y|after:today'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $News                                           = new NewsModel();
        $News->title                                    = $request->title;
        $News->body                                     = $request->body;
        $News->date_active                              = DateFormat($request->date_active,"Y-m-d");
        $News->is_active                                = 1;
        $News->created_by                               = Auth::id();
        $News->updated_by                               = Auth::id();

        try{
            $News->save();
            return redirect()
                ->route('news_admin_show')
                ->with('InfoMsg','<i class="fa fa-save"></i> Data Sudah berhasil disimpan.');
        }catch (\Exception $e){
            $data                                    = array(
                "status"                                => false,
                "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
            );
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "title"                             => $request->title,
                "body"                              => $request->body,
                "date_active"                       => $request->date_active
            );

            Activity::log([
                'contentId'     => 0,
                'contentType'   => 'News',
                'action'        => 'post',
                'description'   => "Ada kesalahan saat menyimpan data Berita",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('news_admin_add')
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }
    }

    public function edit($NewsID){
        $this->_data['state']                           = 'edit';
        $News                                           = NewsModel::find($NewsID);

        $this->_data['MenuDescription']                 = 'Form Ubah Berita';
        $this->_data['News']                            = $News;
        $this->_data['id']                              = $NewsID;

        return Theme::view('modules.news.admin.form',$this->_data);
    }

    public function update(Request $request){
        $validator = Validator::make($request->all(), [
            'title'                 => 'required|max:255',
            'body'                  => 'required',
            'date_active'           => 'required|date|date_format:d-m-Y|after:today'
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }
        $id                                             = $request->id;
        $News                                           = NewsModel::find($id);
        $News->title                                    = $request->title;
        $News->body                                     = $request->body;
        $News->date_active                              = DateFormat($request->date_active,"Y-m-d");
        $News->is_active                                = 1;
        $News->updated_by                               = Auth::id();

        try{
            $News->save();
            return redirect()
                ->route('news_admin_show')
                ->with('ScsMsg','<i class="fa fa-save"></i> Perubahan data berhasil.');
        }catch (\Exception $e){
            $data                                    = array(
                "status"                                => false,
                "message"                               => 'Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)'
            );
            $Details                                = array(
                "user_id"                           => Auth::id(),
                'news_id'                           => $id,
                "title"                             => $request->title,
                "body"                              => $request->body,
                "date_active"                       => $request->date_active
            );

            Activity::log([
                'contentId'     => $id,
                'contentType'   => 'News',
                'action'        => 'update',
                'description'   => "Ada kesalahan saat mengubah data Berita",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('news_admin_edit',$id)
                ->withInput($request->input())
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }
    }

    public function inactive($NewsID){
        if($NewsID){
            $NewsInfo                                   = NewsModel::find($NewsID);
            $NewsInfo->is_active                        = 0;
            $NewsInfo->updated_by                       = Auth::id();
            try{
                $NewsInfo->save();
                return redirect()
                    ->route('news_admin_show')
                    ->with('ScsMsg', $NewsInfo->name.' berhasil di inactive.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "news_id"                           => $NewsID,
                );

                Activity::log([
                    'contentId'     => $NewsID,
                    'contentType'   => 'News',
                    'action'        => 'inactive',
                    'description'   => "Ada kesalahan saat meninactivekan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('news_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "news_id"                           => $NewsID,
            );

            Activity::log([
                'contentId'     => $NewsID,
                'contentType'   => 'News',
                'action'        => 'inactive',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('news_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function activate($NewsID){
        if($NewsID){
            $NewsInfo                                   = NewsModel::find($NewsID);
            $NewsInfo->is_active                        = 1;
            $NewsInfo->updated_by                       = Auth::id();
            try{
                $NewsInfo->save();
                return redirect()
                    ->route('news_admin_show')
                    ->with('ScsMsg', $NewsInfo->name.' berhasil di aktifkan.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                           => Auth::id(),
                    "news_id"                           => $NewsID,
                );

                Activity::log([
                    'contentId'     => $NewsID,
                    'contentType'   => 'News',
                    'action'        => 'activate',
                    'description'   => "Ada kesalahan saat mengaktifkan data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('news_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "news_id"                           => $NewsID,
            );

            Activity::log([
                'contentId'     => $NewsID,
                'contentType'   => 'News',
                'action'        => 'activate',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('news_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }

    }

    public function delete($NewsID){
        if($NewsID){
            $NewsInfo                                       = NewsModel::find($NewsID);
            try{
                $NewsInfo->delete();
                return redirect()
                    ->route('news_admin_show')
                    ->with('ScsMsg', '<i class="fa fa-trash"></i>'. $NewsInfo->title.' berhasil di hapus.');
            }catch(\Exception $e){
                $Details                                = array(
                    "user_id"                               => Auth::id(),
                    "news_id"                               => $NewsID,
                );

                Activity::log([
                    'contentId'     => $NewsID,
                    'contentType'   => 'News',
                    'action'        => 'delete',
                    'description'   => "Ada kesalahan saat menghapus data",
                    'details'       => $e->getMessage(),
                    'data'          => json_encode($Details),
                    'updated'       => Auth::id(),
                ]);
                return redirect()
                    ->route('news_admin_show')
                    ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
            }
        }else{
            $Details                                = array(
                "user_id"                           => Auth::id(),
                "news_id"                           => $NewsID,
            );

            Activity::log([
                'contentId'     => $NewsID,
                'contentType'   => 'News',
                'action'        => 'delete',
                'description'   => "Param Not Found",
                'details'       => "Parameter tidak ditemukan",
                'data'          => json_encode($Details),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('news_admin_show')
                ->with('ErrMsg',"Maaf, ada Kesalah teknis. Mohon hubungi web developer. (email: barindra1988@gmail.com)");
        }
    }


}
