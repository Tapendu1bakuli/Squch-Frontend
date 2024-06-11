const int TIMEOUT_DURATION = 5;

const String BASE_URL = 'api.squch.com';

//Intro Screen
const String INTRO_SCREEN = '/api/v1/common/cms-content/get';
//Auth Section
const String LOGIN = '/api/v1/auth/user/login';
const String REGISTRATION_MASTER = '/api/v1/auth/user/register/master';
const String REGISTRATION_SUBMIT = '/api/v1/auth/user/register';
const String REGISTRATION_VERIFY_EMAIL = '/api/v1/auth/otp/verify/user-register/email';
const String REGISTRATION_VERIFY_MOBILE = '/api/v1/auth/otp/verify/user-register/mobile';
const String RESEND_EMAIL_OTP = '/api/v1/auth/otp/resend/user-register/email';
const String RESEND_MOBILE_OTP = '/api/v1/auth/otp/resend/user-register/mobile';
const String FORGOT_PASSWORD = '/api/v1/auth/user/reset-password';
const String FORGOT_PASSWORD_RESEND_OTP = '/api/v1/auth/otp/resend/user-resetpassword/mobile';
const String FORGOT_PASSWORD_VERIFY_OTP = '/api/v1/auth/otp/verify/user-resetpassword/mobile';
const String SET_NEW_PASSWORD = '/api/v1/auth/user/reset-password/change';

//Ride Section
const String INIT_RIDE = '/api/v1/user/ride/init';
const String GET_CANCEL_RIDE_REASON = '/api/v1/user/ride/cancel/master';


const String FIND_A_DRIVER = '/api/v1/user/ride/start';
const String GET_ACTIVE_RIDE = '/api/v1/user/ride/active';

//Socket Config
const String SOCKET_URL = "http://api.squch.com:80";
const String SOCKET_PATH = '/socket.io';
const String SOCKET_TRANSPORTERS = 'websocket';



//Scoket Ports
const String customerRideBidFetch = "customerRideBidFetch";
const String customerRideBidAccept = "customerRideBidAccept";
const String rideStatusUpdate = "rideStatusUpdate";
const String customerRideNewBid = "customerRideNewBid";
const String customerRideBidReject = "customerRideBidReject";
const String customerRideBidOut = "customerRideBidOut";
const String customerCancelRide = "customerRideStatusUpdate";
const String rideSendMessage = "rideSendMessage";
const String rideNewMessage = "rideNewMessage";
const String rideFetchMessage = "rideFetchMessage";

