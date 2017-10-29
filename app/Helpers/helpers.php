<?php

### IMAGES ###
if (! function_exists('getPathLogo')) {
    /**
     * @return path
     */
    function getPathLogo()
    {
        return "images/logo/";
    }
}

if (! function_exists('getPathIcon')) {
    /**
     * @return path
     */
    function getPathIcon()
    {
        return "images/icon/";
    }
}

if (! function_exists('getPathBanner')) {
    /**
     * @return path
     */
    function getPathBanner()
    {
        return "media/banner/";
    }
}

if (! function_exists('getPathStoreLogo')) {
    /**
     * @return path
     */
    function getPathStoreLogo()
    {
        return "media/logo/";
    }
}




### =================== GENERATE LINK ==================== ###
if (! function_exists('get_GenerateLinkImage')) {
    /**
     * @param path, image file
     * @return string
     */
    function get_GenerateLinkImage($Path, $File)
    {
        return $Path.$File;
    }
}

if (! function_exists('get_GenerateLinkImageUrl')) {
    /**
     * @param path, image file
     * @return string
     */
    function get_GenerateLinkImageUrl($Path, $File)
    {
        return url('/')."/".$Path.$File;
    }
}

if (! function_exists('get_AvatarDefault')) {
    /**
     * @param
     * @return url
     */
    function get_AvatarDefault()
    {
        return url('/')."/images/avatar/avatar.png";
    }
}

### IMAGES ###

if (! function_exists('get_default_password')) {
    /**
     * @return string
     */
    function get_default_password()
    {
        return "JavaTravel";
    }
}

if (! function_exists('get_UsersInformation')) {
    /**
     * @param string
     * @return string
     */
    function get_UsersInformation($field)
    {
        $arr_Users = Auth::user();
        if($arr_Users){
            return $arr_Users->$field;
        }
        return;
    }
}

if (! function_exists('bool_CheckUserRole')) {
    /**
     * @param role
     * @return boolean
     */
    function bool_CheckUserRole($Role)
    {
        return Auth::user()->hasRole($Role);
    }
}

if (! function_exists('bool_CheckAccessUser')) {
    /**
     * @param 'permission'
     * @return boolean
     */
    function bool_CheckAccessUser($Permission)
    {
        return Auth::user()->can($Permission);
    }
}


if (! function_exists('get_active_user')) {
    /**
     * @param integer
     * @return string
     */
    function get_active_user($integer)
    {
        if($integer == 1){
            return 'active';
        }else{
            return 'inactive';
        }
    }
}

if (! function_exists('getSettingInfo')) {
    /**
     * @param id,field
     * @return field
     */
    function getSettingInfo($id,$Field)
    {
        $Setting                = \App\Modules\Setting\Models\Setting::find($id);
        if($Setting){
            return $Setting->$Field;
        }
        return;
    }
}

if (! function_exists('createMenu')) {
    /**
     * @param integer
     * @return string
     */
    function createMenu()
    {
        $arr_Menu                   = App\Modules\Menu\Models\Menu::orderBy('order')->get();
        $arr_Send                   = array();
        if($arr_Menu){
            $i = 0;
            foreach($arr_Menu as $Menu){
                if(Illuminate\Support\Facades\Auth::user()->can($Menu->permission)){
                    $arr_Send[$i]['id']                 = $Menu->id;
                    $arr_Send[$i]['name']               = $Menu->name;
                    $arr_Send[$i]['url']                = $Menu->url;
                    $arr_Send[$i]['permission']         = $Menu->permission;
                    $arr_Send[$i]['icon']               = $Menu->icon;
                    $arr_Send[$i]['id_menu']            = str_replace(' ', '', $Menu->name );
                    if(App\Modules\Submenu\Models\Submenu::where('parent_id', $Menu->id)->count() > 0){
                        $activeMenu                     = $Menu->url."/*";
                    }else{
                        $activeMenu                     = $Menu->url;
                    }
                    $arr_Send[$i]['active_menu']        = $activeMenu;
                    $arr_Submenu                        = App\Modules\Submenu\Models\Submenu::where('parent_id', $Menu->id)->orderBy('name')->get();
                    if($arr_Submenu){
                        $y = 0;
                        foreach($arr_Submenu as $SubMenu){
                            if(Illuminate\Support\Facades\Auth::user()->can($SubMenu->permission)){
                                $arr_Send[$i]['arrSubMenu'][$y]['id_submenu']   = str_replace(' ', '', $SubMenu->name );
                                $arr_Send[$i]['arrSubMenu'][$y]['name']         = $SubMenu->name;
                                $arr_Send[$i]['arrSubMenu'][$y]['url']          = $SubMenu->url;
                                $arr_Send[$i]['arrSubMenu'][$y]['icon']         = $SubMenu->icon;
                                $arr_Send[$i]['arrSubMenu'][$y]['permission']   = $SubMenu->permission;
                                $arr_Send[$i]['arrSubMenu'][$y]['parent_id']    = $SubMenu->parent_id;
                                $arr_Thirdmenu                                  = App\Modules\Thirdmenu\Models\Thirdmenu::where('menu_id','=', $Menu->id)->where('submenu_id','=',$SubMenu->id)->orderBy('name')->get();
                                $count_Thirdmenu                                = App\Modules\Thirdmenu\Models\Thirdmenu::where('menu_id','=', $Menu->id)->where('submenu_id','=',$SubMenu->id)->count();
                                if($count_Thirdmenu > 0){
                                    $x = 0;
                                    foreach($arr_Thirdmenu as $ThirdMenu){
                                        if(Illuminate\Support\Facades\Auth::user()->can($ThirdMenu->permission)){
                                            $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu'][$x]['id_thirdmenu']     = str_replace(' ', '', $SubMenu->name );
                                            $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu'][$x]['name']             = $ThirdMenu->name;
                                            $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu'][$x]['url']              = $ThirdMenu->url;
                                            $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu'][$x]['icon']             = $ThirdMenu->icon;
                                            $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu'][$x]['permission']       = $ThirdMenu->permission;
                                            $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu'][$x]['menu_id']          = $ThirdMenu->menu_id;
                                            $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu'][$x]['submenu_id']       = $ThirdMenu->submenu_id;
                                            $x = $x+1;
                                        }
                                    }
                                }else{
                                    $arr_Send[$i]['arrSubMenu'][$y]['arrThirdMenu']                                = "";
                                }
                                $y = $y+1;
                            }
                        }
                    }
                    $i = $i+1;
                }
            }
        }
        session()->put('Menu',$arr_Send);
    }
}



if (! function_exists('get_UserInformationByID')) {
    /**
     * @param integer
     * @return object
     */
    function get_UserInformationByID($id)
    {
        $obj_User = App\Modules\Users\Models\Users::find($id);
        if($obj_User){
            return $obj_User;
        }
        return;
    }
}

if (! function_exists('get_UserInformation')) {
    /**
     * @return object
     */
    function get_UserInformation()
    {
        return Auth::user();
    }
}

if (! function_exists('get_NameUser')) {
    /**
     * @param integer
     * @return object
     */
    function get_NameUser($id)
    {
        $obj_User = App\User::find($id);
        if($obj_User){
            return $obj_User->name;
        }
        return;
    }
}


if (! function_exists('get_DateNow')) {
    /**
     * @param string
     * @return string
     */
    function get_DateNow($Format)
    {
        return date($Format);
    }
}

if (! function_exists('set_json_encode')) {
    /**
     * @param string
     * @return string
     */
    function set_json_encode($Array)
    {
        return json_encode($Array);
    }
}

if (! function_exists('DateFormat')) {
    /**
     * @param string
     * @return string
     */
    function DateFormat($Date,$Format)
    {
        return date($Format,  strtotime($Date));
    }
}


if (! function_exists('bool_get_useragent_info')) {
    /**
     * @param String
     * @return boolean
     */
    function bool_get_useragent_info($String)
    {

        $Agent          = new \Jenssegers\Agent\Agent();
        return $Agent->$String();
    }
}

if (! function_exists('bool_checkAccessMember')) {
    /**
     * @param String
     * @return boolean
     */
    function bool_checkAccessMember($String)
    {
        $Permission         = \App\Modules\Permission\Models\Permission::Where('name','=',$String)->first();
        $PermissionID       = $Permission->id;

        $Where              = array(
            'user_id'       => \Illuminate\Support\Facades\Auth::id(),
            'permission_id' => $PermissionID
        );
        $PermissionMember   = \App\Modules\Permission\Models\PermissionMember::Where($Where)->count();
        if($PermissionMember > 0){
            return true;
        }
        return;
    }
}

if (! function_exists('get_ListPermissionNormal')) {
    /**
     * @return string
     */
    function get_ListPermissionNormal()
    {
        $Permission                                 = App\Modules\Permission\Models\Permission::all();

        $output = array();
        $output [0] = 'Choose Permission';
        foreach ($Permission as $item){
            $output[$item->id] = $item->display_name;
        }
        return $output;

    }
}

if (! function_exists('get_ListPermission')) {
    /**
     * @return string
     */
    function get_ListPermission()
    {
        $Permission                                 = App\Modules\Permission\Models\Permission::all();

        $output = array();
        $output [0] = 'Choose Permission';
        foreach ($Permission as $item){
            $output[$item->name] = $item->name;
        }
        return $output;

    }
}

if (! function_exists('get_active')) {
    /**
     * @param integer
     * @return string
     */
    function get_active($integer)
    {
        if($integer == 1){
            return 'active';
        }else{
            return 'inactive';
        }
    }
}

if (! function_exists('set_clearFormatRupiah')) {
    /**
     * @param $string
     * @return string
     */
    function set_clearFormatRupiah($string)
    {
        $Result = str_replace('.',"",$string);
        $Result = str_replace('_',"",$Result);
        $Result = str_replace('Rp ',"",$Result);

        return $Result;
    }
}

if (! function_exists('get_ListRole')) {
    /**
     * @return string
     */
    function get_ListRole()
    {
        $Role                                 = App\Modules\Role\Models\Role::where('id','>',1)->get();

        $output = array();
        $output [0] = 'Choose Role';
        foreach ($Role as $item){
            if($item->name != 'super'){
                $output[$item->id] = $item->name;
            }
        }
        return $output;

    }
}

if (! function_exists('set_numberformat')) {
    /**
     * @return number
     */
    function set_numberformat($nominal)
    {
        return number_format($nominal,0,',',".");
    }
}


if (! function_exists('get_date_add')) {
    /**
     * @param integer
     * @return string
     */
    function get_date_add($Date,$interval)
    {
        $stop_date = new DateTime($Date);
        $stop_date->modify('+'.$interval.' day');
        return $stop_date->format('d F Y');
    }
}



if (! function_exists('get_ListMonth')) {
    /**
     * @return string
     */
    function get_ListMonth()
    {

        $output             = array();
        $output [0]         = 'Pilih Bulan';
        $output [1]         = 'Januari';
        $output [2]         = 'Februari';
        $output [3]         = 'Maret';
        $output [4]         = 'April';
        $output [5]         = 'Mei';
        $output [6]         = 'Juni';
        $output [7]         = 'Juli';
        $output [8]         = 'Agustus';
        $output [9]         = 'September';
        $output [10]        = 'Oktober';
        $output [11]        = 'November';
        $output [12]        = 'Desember';
        return $output;

    }
}

if (! function_exists('get_ListMenu')) {
    /**
     * @return string
     */
    function get_ListMenu()
    {
        $Menu                                       = App\Modules\Menu\Models\Menu::orderBy('name')->get();

        $output                                     = array();
        $output [0]                                 = 'Pilih Menu';
        foreach ($Menu as $item){
            $output[$item->id]                    = $item->name;
        }
        return $output;

    }
}

if (! function_exists('get_ListSubMenu')) {
    /**
     * @return string
     */
    function get_ListSubMenu($MenuID)
    {
        $Submenu                                    = App\Modules\Submenu\Models\Submenu::where('parent_id','=',$MenuID)->orderBy('name')->get();

        $output                                     = array();
        $output [0]                                 = 'Pilih Submenu';
        foreach ($Submenu as $item){
            $output[$item->id]                    = $item->name;
        }
        return $output;

    }
}

if (! function_exists('getnamePermission')) {
    /**
     * @Param ID
     * @return string
     */
    function getnamePermission($PermissionID)
    {
        $Permission                                 = App\Modules\Permission\Models\Permission::find($PermissionID);

        return $Permission->display_name;

    }
}

if (! function_exists('get_ListPermissionbyParentID')) {
    /**
     * @Param ID
     * @return string
     */
    function get_ListPermissionbyParentID($ParentID)
    {
        $Permission                                 = App\Modules\Permission\Models\Permission::where('parent_id','=',$ParentID)->get();
        return $Permission;

    }
}

if (! function_exists('get_ListType')) {
    /**
     * @return string
     */
    function get_ListType()
    {
        $Type                                       = \App\Modules\Type\Models\Type::where('is_active','=',1)->orderBy('order')->get();

        $output                                     = array();
        $output [0]                                = 'Pilih Jenis';
        foreach ($Type as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;

    }
}

if (! function_exists('get_ListRegion')) {
    /**
     * @return string
     */
    function get_ListRegion()
    {
        $Region                                     = \App\Modules\Region\Models\Region::where('is_active','=',1)->orderBy('name')->get();

        $output                                     = array();
        $output [0]                                 = 'Pilih Region';
        foreach ($Region as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;

    }
}

if (! function_exists('get_ListIncludes')) {
    /**
     * @return string
     */
    function get_ListIncludes()
    {
        $Includes                                   = \App\Modules\Includes\Models\Includes::where('is_active','=',1)->orderBy('name')->get();

        $output                                     = array();
        foreach ($Includes as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}

if (! function_exists('get_IconInclude')) {
    /**
     * @param int
     * @return string
     */
    function get_IconInclude($id)
    {
        $Includes                                   = \App\Modules\Includes\Models\Includes::find($id);
        if($Includes){
            return $Includes->icon;
        }
        return;
    }
}

if (! function_exists('get_ListCountry')) {
    /**
     * @param int
     * @return string
     */
    function get_ListCountry($RegionID)
    {
        $Country                                    = \App\Modules\Country\Models\Country::where('region_id','=',$RegionID)->where('is_active','=',1)->orderBy('name')->get();

        $output                                     = array();
        foreach ($Country as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;

    }
}

if (! function_exists('get_ListDestination')) {
    /**
     * @param $RegionID|$CountryID
     * @return string
     */
    function get_ListDestination($RegionID,$CountryID)
    {
        $Destination                                = \App\Modules\Destination\Models\Destination::where('region_id','=',$RegionID)->where('country_id','=',$CountryID)->where('is_active','=',1)->orderBy('name')->get();

        $output                                     = array();
        foreach ($Destination as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;

    }
}


if (! function_exists('get_ListLevel')) {
    /**
     * @return string
     */
    function get_ListLevel()
    {
        $Level                                      = \App\Modules\Level\Models\Level::orderBy('name')->get();
        $output                                     = array();
        $output[""]                                 = "-- Pilih Level --";
        foreach ($Level as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}



if (! function_exists('set_Base64Encode')) {
    /**
     * @return string
     */
    function set_Base64Encode($String)
    {
        return base64_encode($String);
    }
}

if (! function_exists('get_ListKomisiType')) {
    /**
     * @return string
     */
    function get_ListKomisiType()
    {
        $Type                                      = \App\Modules\Komisi\Models\KomisiType::orderBy('name')->get();
        $output                                     = array();
        foreach ($Type as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}


if (! function_exists('get_ListBank')) {
    /**
     * @return string
     */
    function get_ListBank()
    {
        $Bank                                       = \App\Modules\Bank\Models\Bank::where('is_active','=', 1)->orderBy('name')->get();
        $output                                     = array();
        foreach ($Bank as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}


if (! function_exists('get_ListLevel')) {
    /**
     * @return string
     */
    function get_ListLevel()
    {
        $Level                                      = \App\Modules\Level\Models\Level::orderBy('name')->get();
        $output                                     = array();
        foreach ($Level as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}

if (! function_exists('get_ListLevelbyUser')) {
    /**
     * @return string
     */
    function get_ListLevelbyUser()
    {
        $LevelID                                = Auth::user()->level_id;

        $Level                                      = \App\Modules\Level\Models\Level::where('id','>=',$LevelID)->orderBy('order')->get();
        $output                                     = array();
        foreach ($Level as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}

if (! function_exists('get_ListLevelbyUserParam')) {
    /**
     * LevelID
     * @return string
     */
    function get_ListLevelbyUserParam($LevelID)
    {
        $Level                                      = \App\Modules\Level\Models\Level::where('order','>',$LevelID)->orderBy('order')->get();
        $output                                     = array();
        foreach ($Level as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}

if (! function_exists('get_ListTourClass')) {
    /**
     * @return string
     */
    function get_ListTourClass()
    {
        $TourClass                                  = \App\Modules\Classtour\Models\ClassTour::where('is_active','=',1)->orderBy('name')->get();
        $output                                     = array();
        foreach ($TourClass as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}

if (! function_exists('get_ListScheduleOpentrip')) {
    /**
     * @param $TourID
     * @return string
     */
    function get_ListScheduleOpentrip($TourID)
    {
        $Quota                                      = \App\Modules\Opentrip\Models\OpenTrip::where('tour_id','=',$TourID)->where('is_active','=',1)->orderBy('departure_date')->get();
        $output                                     = array();
        foreach ($Quota as $item){
            $output[$item->id]                      = DateFormat($item->departure_date, "d F Y");
        }
        return $output;
    }
}




if (! function_exists('get_ListProvince')) {
    /**
     * @return string
     */
    function get_ListProvince()
    {
        $Province                                   = \App\Modules\Province\Models\Province::orderBy('name')->get();
        $output                                     = array();
        foreach ($Province as $item){
            $output[$item->id]                      = $item->name;
        }
        return $output;
    }
}



if (! function_exists('get_client_ip')) {
    /**
     * @return string
     */
    function get_client_ip() {
        $ipaddress = '';
        if (isset($_SERVER['HTTP_CLIENT_IP']))
            $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
        else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_X_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
        else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_FORWARDED'];
        else if(isset($_SERVER['REMOTE_ADDR']))
            $ipaddress = $_SERVER['REMOTE_ADDR'];
        else
            $ipaddress = 'UNKNOWN';
        return $ipaddress;
    }
}


if (! function_exists('get_LastLogin')) {
    /**
     * @return string
     */
    function get_LastLogin() {
        $UserID                             = Auth::id();
        $LastLogin                          = \App\Modules\Auditlog\Models\AuditLog::where('user_id','=',$UserID)->orderBy('last_login','desc')->first();
        return $LastLogin;
    }
}


?>
