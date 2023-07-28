



class Api{

   static const baseUrl = 'http://192.168.101.110:404';

   ///register type accounts ...
   static const registerOrganization = '$baseUrl/api/Organization/Register';
   static const registerDoctor = '$baseUrl/api/DoctorRegistration/DoctorRegister';

   ///register User account...
   static const userRegister = '$baseUrl/api/Users/UserRegister';



   ///scheme - subscription plan...
   static const schemePlan = '$baseUrl/api/SchemePlan/GetList';
   static const subscriptionPlan = '$baseUrl/api/SchemeSubscription/Insert';

   ///user Login...
   static const userLogin = '$baseUrl/api/Users/UserLogin';


   /// Patient registration...
   static const getCostCategory = '$baseUrl/api/CostCategory/Getlist';


   /// Country details...
   static const getCountry = '$baseUrl/api/Country/GetList';
   static const getProvince = '$baseUrl/api/Province/GetListProvinceByCountryId/';
   static const getDistrict = '$baseUrl/api/District/GetListDistrictByProvinceId/';
   static const getMunicipality = '$baseUrl/api/Municipality/GetListMunicipalityByDistrictId/';

}