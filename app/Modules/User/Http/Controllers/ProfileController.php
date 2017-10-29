<?php

namespace App\Modules\User\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;

use App\User as UserModel;


use File;
use App\User;
use Theme;
use Auth;
use Activity;


class ProfileController extends Controller
{
    protected $_data                                = array();
    protected $destinationLogoStore                 = array();

    public function __construct()
    {
        $this->_data['MenuActive']                  = 'Profile Usaha';
        $this->_data['form_name']                   = 'profile_usaha';
        $this->urlLogoStore                         = 'media/logo';
        $this->destinationLogoStore                 = public_path($this->urlLogoStore);

    }

    public function showInfoForm(){
        $this->_data['MenuDescription']             = 'Informasi Usaha Anda';
        $this->_data['User']                        = Auth::user();

        return Theme::view('modules.user.profile.info',$this->_data);
    }

    public function actionInfoForm(Request $request){
        $validator = Validator::make($request->all(), [
            'store_name'                    => 'required|max:150',
            'store_address'                 => 'required',
            'phone'                         => 'required',
            'bank'                          => 'required|min:1',
            'account_number'                => 'required|max:100'
        ],[
            'store_name.required'           => 'Nama usaha wajib diisi',
            'store_name.max'                => 'Nama usaha maksimal 150 karakter',
            'phone.required'                => 'No. Telp/Handphone wajib diisi',
            'bank.required'                 => 'Bank wajib diisi',
            'bank.min'                      => 'Pilih salah satu Bank',
            'account_number.required'       => 'No. Rekening wajib diisi',
            'account_number.max'            => 'No. Rekening maksimal 100 karakter',
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput($request->input());
        }

        $User                                       = UserModel::find(Auth::id());
        $User->store_name                           = $request->store_name;
        $User->store_address                        = $request->store_address;
        $User->phone                                = $request->phone;
        $User->bank_id                              = $request->bank;
        $User->account_number                       = $request->account_number;

        try {

            ### Upload Logo ###
            if($request->file('logo')){
                $File                                       = $request->file('logo');
                try{
                    $LogoFiles                              = $this->logoUpload($File);
                    $User->logo                             = $LogoFiles;
                }
                catch (\Exception $e) {
                    Activity::log([
                        'contentId'     => Auth::id(),
                        'contentType'   => 'Edit Profile',
                        'action'        => 'actionInfoForm',
                        'description'   => "Kesalahan saat mengupload Logo Usaha",
                        'details'       => $e->getMessage(),
                        'data'          => json_encode($File),
                        'updated'       => Auth::id(),
                    ]);
                }
            }
            ### Upload Logo ###

            $User->save();
            return redirect()
                ->route('profile_info')
                ->with('ScsMsg',"<i class='fa fa-save'></i> Perubahan Profil anda berhasil..");
        }
        catch (\Exception $e) {
            $Detail                                 = array(
                'store_name'                        => $request->store_name,
                'store_address'                     => $request->store_address,
                'phone'                             => $request->phone,
                'bank_id'                           => $request->bank,
                'account_number'                    => $request->account_number,
                'user_id'                           => Auth::id()
            );
            Activity::log([
            		'contentId'     => Auth::id(),
            		'contentType'   => 'Edit Profile',
            		'action'        => 'actionInfoForm',
            		'description'   => "ada kesalahan pada saat perubahan data profil",
            		'details'       => $e->getMessage(),
            		'data'          => json_encode($Detail),
            		'updated'       => Auth::id(),
            	]);
            return redirect()
                ->route('profile_info')
                ->with('ErrMsg',"Ada Kesalahan teknis. Mohon hubungi barindra1988@gmail.com");
        }
    }

    public function showChangedInForm(){
        $this->_data['form']                        = 'changed_password';
        $this->_data['form_name']                   = 'Changed Password';

        return Theme::view('modules.user.profile.changed_password',$this->_data);
    }

    public function actionChangedInForm(Request $request){
        $validator = Validator::make($request->all(), [
            'password'                          => 'required|confirmed',
            'password_confirmation'             => 'required'
        ],[
            'password.required'                 => 'Password wajib diisi',
            'password.confirmed'                => 'Password dan ketik ulang tidak sama',
            'password_confirmation.required'    => 'Ketik Ulang Password wajib diisi'
        ]);

        if ($validator->fails()) {
             return redirect()
                        ->route('profile_info')
                        ->withErrors($validator)
                        ->withInput();
        }

        $new_password                               = $request->password;

        $obj_user                                   = User::find(Auth::id());
        $obj_user->password                         = Hash::make($new_password);
        try{
            $obj_user->save();
            return redirect()
                ->route('profile_info')
                ->with('ScsMsg',"<i class='fa fa-save'></i> Password berhasil diubah.");
        }catch (\ Exception $e){
            $Detail                                 = array(
                'user_id'                           => Auth::id()
            );
            Activity::log([
                'contentId'     => Auth::id(),
                'contentType'   => 'Edit Profile',
                'action'        => 'actionChangedInForm',
                'description'   => "ada kesalahan pada saat perubahan data password",
                'details'       => $e->getMessage(),
                'data'          => json_encode($Detail),
                'updated'       => Auth::id(),
            ]);
            return redirect()
                ->route('profile_info')
                ->with('ErrMsg',"Ada Kesalahan teknis. Mohon hubungi barindra1988@gmail.com");
        }


    }



    /**
     * Processing Save Image File.
     * @param \Illuminate\Http\UploadedFile Get Uploaded file for save it on server folder
     * @return String saved FileName
     */
    public function logoUpload($file_image){
        if ($file_image->isValid()) {
            $str_fileName = time().'-'.$file_image->getClientOriginalName();
            $file_image->move($this->destinationLogoStore, $str_fileName);

            return $str_fileName;
        }
    }

}
