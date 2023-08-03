



class Api{

   static const bearerToken = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJiZjZhNTdmNC1iN2JmLTQzYmItODgzNy0yY2NiZDE4NDM5ODIiLCJ2YWxpZCI6IjEiLCJ1c2VyaWQiOiJET0MwMDAxIiwiZXhwIjoxNzIxMjc3NDc0LCJpc3MiOiJsb2NhbGhvc3QiLCJhdWQiOiJXZWxjb21lIn0.o7_teFlpwxmG7EOBO9eL46bfOwLySS6Qyc1Yj8ZgcyI';

   static const baseUrl = 'http://192.168.101.110:404';

   ///register type accounts ...
   static const registerOrganization = '$baseUrl/api/Organization/Register';
   static const registerDoctor = '$baseUrl/api/DoctorRegistration/DoctorRegister';

   /// User...
   static const userRegister = '$baseUrl/api/Users/UserRegister';
   static const getUsers = '$baseUrl/api/Users/GetUser';
   static const getUserById = '$baseUrl/api/Users/GetUserById/';
   static const userUpdate = '$baseUrl/api/Users/UpdateUser/profileImageUrl/signaturImageUrl';



   ///scheme - subscription plan...
   static const schemePlan = '$baseUrl/api/SchemePlans/GetList';
   static const subscriptionPlan = '$baseUrl/api/SchemeSubscription/Insert';

   ///user Login...
   static const userLogin = '$baseUrl/api/Users/UserLogin';


   /// Patient registration...
   static const postPatientRegistration = '$baseUrl/api/patient/Insert/aa';
   static const getRegisteredPatients = '$baseUrl/api/Patient/Getlist';
   static const getCostCategory = '$baseUrl/api/CostCategory/Getlist';


   /// Country details...
   static const getCountry = '$baseUrl/api/Country/GetList';
   static const getProvince = '$baseUrl/api/Province/GetListProvinceByCountryId/';
   static const getDistrict = '$baseUrl/api/District/GetListDistrictByProvinceId/';
   static const getMunicipality = '$baseUrl/api/Municipality/GetListMunicipalityByDistrictId/';

   /// Department & doctors...
   static const getDoctorDepartment = '$baseUrl/api/DoctorDepartment/GetDepartment';
   static const getDoctorList = '$baseUrl/api/DoctorRegistration/Getlist';

}