public class Hubspotcreationcalls
{
   public void createcontactonHS(lead leadobj)
   {
        string pc=createHsJson(leadobj);
        //string prospectJSON = JSON.serialize(pc);
        string apikey='8b365b09-a3b2-423d-b401-c468c9f89e2c';
        string url='https://api.hubapi.com/contacts/v1/contact/?hapikey=' + apikey;
        //string url='https://forms.hubspot.com/uploads/form/v2/6035427/76cb4fcc-1514-444a-b627-5714574482b0';
        system.debug(pc);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        //req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        req.setBody(pc); 
        Http http = new Http(); 
          try
            {
                HTTPResponse res = http.send(req);
                Integer retCode = res.getStatusCode();
                String retMsg = res.getStatus();
                if(retcode==500)
                {
                }
            }
            catch(exception ex)
            {
            }
    }
   public static string createHsJson(lead leadobj) 
   {
       JSONGenerator pc= JSON.createGenerator(true);
       pc.writeStartObject();
       pc.writeFieldName('properties');
       pc.writeStartArray();
        // First name
             pc.writestartObject();
             pc.writeObjectField('property','firstname');
             pc.writeObjectField('value',leadobj.firstname);
             pc.writeEndObject();
              // Last name
             pc.writestartObject();
             pc.writeObjectField('property','lastname');
             pc.writeObjectField('value',leadobj.lastname);
             pc.writeEndObject();
              // email
             pc.writestartObject();
             pc.writeObjectField('property','email');
             pc.writeObjectField('value',leadobj.email);
             pc.writeEndObject();
             
              // community interested
             pc.writestartObject();
             pc.writeObjectField('property','community_picklist_wash');
             pc.writeObjectField('value',leadobj.Community_Picklist_Wsh__c);
             pc.writeEndObject();
             
             if(leadobj.LeadSource!='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','leadsource');
              pc.writeObjectField('value',leadobj.leadsource);
              pc.writeEndObject();
             }
             if(leadobj.Lead_Source_Detail__c!='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','lead_source_detail__c');
              pc.writeObjectField('value',leadobj.Lead_Source_Detail__c);
              pc.writeEndObject();
             }
             if(leadobj.area_of_interest__c!='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','area_of_interest__c');
              pc.writeObjectField('value',leadobj.area_of_interest__c);
              pc.writeEndObject();
             }
             //if(leadobj.realtor__c!='')
            // {
              pc.writestartObject();
              pc.writeObjectField('property','realtor__c');
              pc.writeObjectField('value',leadobj.realtor__c);
              pc.writeEndObject();
            // }
             if(leadobj.age_group__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','age_group__c');
              pc.writeObjectField('value',leadobj.age_group__c );
              pc.writeEndObject();
             }
            // if(leadobj.maritalstatus__c !='')
            // {
              pc.writestartObject();
              pc.writeObjectField('property','maritalstatus__c');
              pc.writeObjectField('value',leadobj.maritalstatus__c );
              pc.writeEndObject();
            // }
             if(leadobj.do_you_currently_own_or_rent__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','do_you_currently_own_or_rent__c');
              pc.writeObjectField('value',leadobj.do_you_currently_own_or_rent__c );
              pc.writeEndObject();
             }
             if(leadobj.are_you_transferring_to_the_area__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','are_you_transferring_to_the_area__c');
              pc.writeObjectField('value',leadobj.are_you_transferring_to_the_area__c );
              pc.writeEndObject();
             }
             if(leadobj.transferring_to_area_date__c !=null)
             {
              pc.writestartObject();
              pc.writeObjectField('property','transferring_to_area_date__c');
              pc.writeObjectField('value',leadobj.transferring_to_area_date__c);
              pc.writeEndObject();
             }
             if(leadobj.how_long_have_you_been_house_hunting__c  !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','how_long_have_you_been_house_hunting__c');
              pc.writeObjectField('value',leadobj.how_long_have_you_been_house_hunting__c);
              pc.writeEndObject();
             }
             if(leadobj.visit_brookfield_website_during_search__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','visit_brookfield_website_during_search__c');
              pc.writeObjectField('value',leadobj.visit_brookfield_website_during_search__c);
              pc.writeEndObject();
             }
             if(leadobj.household_income__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','household_income__c');
              pc.writeObjectField('value',leadobj.household_income__c);
              pc.writeEndObject();
             }
             if(leadobj.tx_timeframe_to_purchase__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','tx_timeframe_to_purchase__c');
              pc.writeObjectField('value',leadobj.tx_timeframe_to_purchase__c);
              pc.writeEndObject();
             }
             if(leadobj.number_of_children_in_home__c!='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','number_of_children_in_home__c');
              pc.writeObjectField('value',leadobj.number_of_children_in_home__c);
              pc.writeEndObject();
             }
             if(leadobj.what_is_your_price_range__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','what_is_your_price_range__c');
              pc.writeObjectField('value',leadobj.what_is_your_price_range__c );
              pc.writeEndObject();
             }
             if(leadobj.bedrooms__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','bedrooms__c');
              pc.writeObjectField('value',leadobj.bedrooms__c );
              pc.writeEndObject();
             }
             if(leadobj.bathrooms__c !='')
             {
              pc.writestartObject();
              pc.writeObjectField('property','bathrooms__c');
              pc.writeObjectField('value',leadobj.bathrooms__c);
              pc.writeEndObject();
             }
              
              string salesoffice= quickLeadCreate.getSalesOffices()[0].Sales_Office__r.Name;
              pc.writestartObject();
              pc.writeObjectField('property','sales_office_mapping__c');
              pc.writeObjectField('value',salesoffice);
              pc.writeEndObject();
     
            
         //}
       pc.writeEndarray();
       pc.writeEndObject();
       string body= pc.getAsString();
       system.debug('Json for hs' + body);
       return body;
   }      
   public static void createHsformdata(lead leadobj) 
   {
       string formdata='';
       
       formdata=formdata +'firstname=' + EncodingUtil.urlEncode(leadobj.firstname,'utf-8');
       formdata=formdata +'&lastname=' + EncodingUtil.urlEncode(leadobj.lastname,'utf-8');
       formdata=formdata +'&email=' + EncodingUtil.urlEncode(leadobj.email,'utf-8');
       formdata=formdata +'&community_picklist_wash=' + EncodingUtil.urlEncode(leadobj.Community_Picklist_Wsh__c,'utf-8');
       formdata=formdata +'&realtor__c=' + leadobj.realtor__c;
       formdata=formdata +'&maritalstatus__c=' + leadobj.maritalstatus__c;
       string salesoffice= quickLeadCreate.getSalesOffices()[0].Sales_Office__r.Name;
       formdata=formdata +'&sales_office_mapping__c=' + EncodingUtil.urlEncode(salesoffice,'utf-8');
       
       if(leadobj.LeadSource!='')
           formdata=formdata +'&leadsource=' + EncodingUtil.urlEncode(leadobj.leadsource,'utf-8');
       if(leadobj.lead_source_detail__c!='')
           formdata=formdata +'&lead_source_detail__c=' + EncodingUtil.urlEncode(leadobj.lead_source_detail__c,'utf-8');
       if(leadobj.area_of_interest__c!='')
           formdata=formdata +'&area_of_interest__c=' + EncodingUtil.urlEncode(leadobj.area_of_interest__c,'utf-8');
       
       if(leadobj.age_group__c!='')
           formdata=formdata +'&age_group__c=' + EncodingUtil.urlEncode(leadobj.age_group__c,'utf-8');

       if(leadobj.do_you_currently_own_or_rent__c!='')
           formdata=formdata +'&do_you_currently_own_or_rent__c=' + EncodingUtil.urlEncode(leadobj.do_you_currently_own_or_rent__c,'utf-8');
       if(leadobj.are_you_transferring_to_the_area__c!='')
           formdata=formdata +'&are_you_transferring_to_the_area__c=' + EncodingUtil.urlEncode(leadobj.are_you_transferring_to_the_area__c,'utf-8');
        formdata=formdata +'&transferring_to_area_date__c=' + leadobj.transferring_to_area_date__c;
       if(leadobj.how_long_have_you_been_house_hunting__c!='')
           formdata=formdata +'&how_long_have_you_been_house_hunting__c=' + EncodingUtil.urlEncode(leadobj.how_long_have_you_been_house_hunting__c,'utf-8');
       if(leadobj.visit_brookfield_website_during_search__c!='')
           formdata=formdata +'&visit_brookfield_website_during_search__c=' + EncodingUtil.urlEncode(leadobj.visit_brookfield_website_during_search__c,'utf-8');
       if(leadobj.household_income__c!='')
           formdata=formdata +'&household_income__c=' + EncodingUtil.urlEncode(leadobj.household_income__c,'utf-8');
       if(leadobj.what_is_your_price_range__c !='')
           formdata=formdata +'&what_is_your_price_range__c =' + EncodingUtil.urlEncode(leadobj.what_is_your_price_range__c ,'utf-8');
       if(leadobj.bedrooms__c!='')
           formdata=formdata +'&bedrooms__c=' + EncodingUtil.urlEncode(leadobj.bedrooms__c,'utf-8');
       if(leadobj.bathrooms__c!='')
           formdata=formdata +'&bathrooms__c=' + EncodingUtil.urlEncode(leadobj.bathrooms__c,'utf-8');
       
       
       
       JSONGenerator pc= JSON.createGenerator(true);
       pc.writeStartObject();
       pc.writeStringField('hutk','76cb4fcc-1514-444a-b627-5714574482b0');
       pc.writeEndObject();
       string body= pc.getAsString();
       formdata=formdata + '&hs_context=' + body;
       system.debug(formdata);
       string url='https://forms.hubspot.com/uploads/form/v2/6035427/76cb4fcc-1514-444a-b627-5714574482b0';
        system.debug(pc);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        //req.setHeader('Content-Type', 'application/json');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        req.setBody(formdata); 
        Http http = new Http(); 
          try
            {

            HTTPResponse res = http.send(req);
            Integer retCode = res.getStatusCode();
            String retMsg = res.getStatus();
            }
            catch(exception ex)
            {
            }
   }      
}