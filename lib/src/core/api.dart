



class Api{

   static const baseUrl = 'http://192.168.101.110:404';

   ///register type accounts ...
   static const registerOrganization = '$baseUrl/api/Organization/Register';

   ///register User account...
   static const userRegister = '$baseUrl/api/Users/UserRegister';



   ///scheme - subscription plan...
   static const schemePlan = '$baseUrl/api/SchemePlan/GetList';
   static const subscriptionPlan = '$baseUrl/api/SchemeSubscription/Insert';

}