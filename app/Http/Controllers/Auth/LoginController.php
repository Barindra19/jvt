<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
// use App\Extensions\Auth\AuthenticatesUsers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Foundation\Auth\RedirectsUsers;
use Illuminate\Foundation\Auth\ThrottlesLogins;

use App\Modules\Auditlog\Models\AuditLog as AuditLogModel;
use Theme;
use \Torann\GeoIP\Facades\GeoIP;


use Illuminate\Http\Request;


class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    // use AuthenticatesUsers;
    use RedirectsUsers, ThrottlesLogins;


    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = '/home';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    /**
     * Show the application's login form.
     *
     * @return \Illuminate\Http\Response
     */
    public function showLoginForm()
    {
        // return view('auth.login');
        return Theme::view('login');
    }

    /**
     * Handle a login request to the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Http\Response
     */
    public function login(Request $request)
    {
//        $param                              = 'g-recaptcha-response';
//        $recaptcha                          = $request->$param;
//        $google                             = "https://www.google.com/recaptcha/api/siteverify?secret=6LcIujQUAAAAAMuxzN7CCy1-l5z_35JageuStmmj&response=".$recaptcha;
//        $result                             = file_get_contents($google);
//        $result                             = json_decode($result);
//
//        if($result->success != 1 or $result->success != "1"){
//            $data = array(
//                "g-recaptcha"  => 'Mohon klik capctha'
//            );
//
//            return redirect()->back()
//                ->withInput($request->only($this->username(), 'remember'))
//                ->withErrors($data);
//        }

        $this->validateLogin($request);

        // If the class is using the ThrottlesLogins trait, we can automatically throttle
        // the login attempts for this application. We'll key this by the username and
        // the IP address of the client making these requests into this application.
        if ($this->hasTooManyLoginAttempts($request)) {
            $this->fireLockoutEvent($request);

            return $this->sendLockoutResponse($request);
        }

        if ($this->attemptLogin($request)) {
            return $this->sendLoginResponse($request);
        }

        // If the login attempt was unsuccessful we will increment the number of attempts
        // to login and redirect the user back to the login form. Of course, when this
        // user surpasses their maximum number of attempts they will get locked out.
        $this->incrementLoginAttempts($request);

        return $this->sendFailedLoginResponse($request);
    }

    /**
     * Validate the user login request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return void
     */
    protected function validateLogin(Request $request)
    {
        $this->validate($request, [
            $this->username() => 'required|string',
            'password' => 'required|string',
        ]);
    }

    /**
     * Attempt to log the user into the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return bool
     */
    protected function attemptLogin(Request $request)
    {
        return $this->guard()->attempt(
            $this->credentials($request), $request->has('remember')
        );
    }

    /**
     * Get the needed authorization credentials from the request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    protected function credentials(Request $request)
    {
        return $request->only($this->username(), 'password');
    }

    /**
     * Send the response after the user was authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    protected function sendLoginResponse(Request $request)
    {
        $request->session()->regenerate();

        $ipaddress                  = get_client_ip();
        $Location                   = geoip()->getLocation($ipaddress);
        $Address                    = $Location->city." ".$Location->postal_code." ".$Location->country;
        $Lat                        = $Location->lat;
        $Long                       = $Location->lon;

        $AuditLog                   = new AuditLogModel();
        $AuditLog->user_id          = Auth::id();
        $AuditLog->last_login       = date('Y-m-d H:i:s');
        $AuditLog->ip_address       = $ipaddress;
        $AuditLog->address          = $Address;
        $AuditLog->lat              = $Lat;
        $AuditLog->long             = $Long;
        if(bool_get_useragent_info('isPhone')){
            $AuditLog->device       = 'Mobile ['.bool_get_useragent_info('device').'|'.bool_get_useragent_info('browser').']';
        }else if(bool_get_useragent_info('isDesktop')){
            $AuditLog->device       = 'Desktop ['.bool_get_useragent_info('browser').']';
        }
        $AuditLog->save();


        $this->clearLoginAttempts($request);

        return $this->authenticated($request, $this->guard()->user())
                ?: redirect()->intended($this->redirectPath());
    }

    /**
     * The user has been authenticated.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  mixed  $user
     * @return mixed
     */
    protected function authenticated(Request $request, $user)
    {
        //
    }

    /**
     * Get the failed login response instance.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    protected function sendFailedLoginResponse(Request $request)
    {
        $errors = [$this->username() => trans('auth.failed')];

        if ($request->expectsJson()) {
            return response()->json($errors, 422);
        }

        return redirect()->back()
            ->withInput($request->only($this->username(), 'remember'))
            ->withErrors($errors);
    }

    /**
     * Get the login username to be used by the controller.
     *
     * @return string
     */
    public function username()
    {
        return 'email';
    }

    /**
     * Log the user out of the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function logout(Request $request)
    {

        $ipaddress                  = get_client_ip();
        $Location                   = geoip()->getLocation($ipaddress);
        $Address                    = $Location->city." ".$Location->postal_code." ".$Location->country;
        $Lat                        = $Location->lat;
        $Long                       = $Location->lon;


        $AuditLog                   = new AuditLogModel;
        $AuditLog->user_id          = Auth::id();
        $AuditLog->last_logout      = date('Y-m-d H:i:s');
        $AuditLog->ip_address       = $ipaddress;
        $AuditLog->address          = $Address;
        $AuditLog->lat              = $Lat;
        $AuditLog->long             = $Long;
        if(bool_get_useragent_info('isPhone')){
            $AuditLog->device       = 'Mobile ['.bool_get_useragent_info('isMobile').'|'.bool_get_useragent_info('browser').']';
        }else if(bool_get_useragent_info('isDesktop')){
            $AuditLog->device       = 'Desktop ['.bool_get_useragent_info('browser').']';
        }
        $AuditLog->save();



        $this->guard()->logout();

        $request->session()->flush();

        $request->session()->regenerate();

        return redirect('/');
    }

    /**
     * Get the guard to be used during authentication.
     *
     * @return \Illuminate\Contracts\Auth\StatefulGuard
     */
    protected function guard()
    {
        return Auth::guard();
    }
}
