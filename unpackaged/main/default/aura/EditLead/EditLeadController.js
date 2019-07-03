({ 
    handleSaveRecord: function(component, event, helper) { 
      var newlead = component.get("v.simpleRecord");   
      var action = component.get("c.AccountAndLeadRecords");
      newlead.MaritalStatus__c=component.find("chkMaritalstatus").get("v.checked");
      newlead.Realtor__c=component.find("chkRealtor").get("v.checked");
        
      var a1 =component.find("LeadsourceSelect").get("v.value");
      if(a1!='--None--')
            newlead.LeadSource=a1;
      var a2=component.find("AgeGroupSelect").get("v.value");
      if(a2!='--None--')
            newlead.Age_Group__c=a2;
      var a3=component.find("OwnorRentSelect").get("v.value");
      if(a3!='--None--')
          newlead.Do_you_currently_own_or_rent__c=a3;
      var a4=component.find("TransfertoAreaSelect").get("v.value");
      if(a4!='--None--')
          newlead.Are_you_transferring_to_the_area__c=a4;
      var a5=component.find("TimehousehuntSelect").get("v.value");
      if(a5!='--None--')
          newlead.How_long_have_you_been_house_hunting__c=a5;
      var a6=component.find("PurchaseTimeSelect").get("v.value");
      if(a6!='--None--')
          newlead.TX_Timeframe_to_purchase__c=a6;
      var a7=component.find("PriceRangeSelect").get("v.value");
      if(a7!='--None--')
          newlead.What_is_your_price_range__c=a7;
      var a8=component.find("BedroomSelect").get("v.value");
      if(a8!='--None--')
          newlead.Bedrooms__c=a8;
      var a9=component.find("BathroomSelect").get("v.value");
      if(a9!='--None--')
          newlead.Bathrooms__c=a9;
      var a10=component.find("NoofcildrenSelect").get("v.value");
      if(a10!='--None--')
          newlead.Number_of_Children_in_Home__c=a10
      var a11=component.find("VisitBrookfielddcSelect").get("v.value");
      if(a11!='--None--')
          newlead.Visit_Brookfield_website_during_search__c=a11;
      var a12=component.find("HouseholdincomeSelect").get("v.value");
      if(a12!='--None--')
          newlead.Household_Income__c=a12;
      var a13=component.get("v.Selectedareaofinterestpicklist")
      var results='';
      for(var i=0;i<a13.length; i++)
      {
        if(i== 0)
            results=a13[i];
        else
        results=results+ ';' + a13[i];  
      }
      newlead.Area_of_Interest__c=results;
  
      action.setParams({
        	leadobj: newlead
        });
       action.setCallback(this, function(response) 
       { 
       var state = response.getState(); 
       if (state === "SUCCESS") 
        { 
           var records = response.getReturnValue();
           if(records.a.length != 0 || records.c.length != 0)
           {   
                var msg="";
                if (records.a.length != 0)
                    msg="Duplicate Account exists " ;
                else if(records.c.length!=0)
                	msg="Duplicate Lead exists ";
               
            	var resultsToast = $A.get("e.force:showToast"); 
            	resultsToast.setParams({ 
                "title": "Error", 
                "message": msg 
                 }); 
            	resultsToast.fire(); 
            }
            else
            {
                component.find("recordHandler").saveRecord($A.getCallback(function(saveResult) { 
            	if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") 
                { 
                    var resultsToast = $A.get("e.force:showToast"); 
             		resultsToast.setParams({ 
                	"title": "Success", 
                	"message": 'Record Saved' 
                 	}); 
            		resultsToast.fire();
                 } 
                else if (saveResult.state === "INCOMPLETE") 
                { 
	            } 
                else if (saveResult.state === "ERROR") 
                { 
                 	var resultsToast = $A.get("e.force:showToast"); 
             		resultsToast.setParams({ 
                	"title": "Error", 
                	"message": 'Problem saving record, error: ' + saveResult.error 
                 	}); 
            		resultsToast.fire();

                } 
               else 
               { 
                
                } 
                     })); 
            } 
        }
       });
       $A.enqueueAction(action);
    }, 
    handleRecordUpdated: function(component, event, helper) { 

        var eventParams = event.getParams(); 
        if(eventParams.changeType === "CHANGED") { 
            var resultsToast = $A.get("e.force:showToast"); 
            resultsToast.setParams({ 
                "title": "Saved", 
                "message": "The record was updated." 
            }); 
            resultsToast.fire(); 
        } else if(eventParams.changeType === "LOADED") { 

        } else if(eventParams.changeType === "REMOVED") { 

        } else if(eventParams.changeType === "ERROR") { 

        } 
    },
    fetchPicklist : function(component, event, helper){
        var action = component.get("c.getPicklistvalues");
        action.setParams({
            'objectName': 'Lead',
            'field_apinames': 'LeadSource,Age_Group__c,Do_you_currently_own_or_rent__c,' +
            'Are_you_transferring_to_the_area__c,How_long_have_you_been_house_hunting__c,' +
            'TX_Timeframe_to_purchase__c,What_is_your_price_range__c,Bedrooms__c,' +
            'Bathrooms__c,Number_of_Children_in_Home__c,Visit_Brookfield_website_during_search__c,'+
            'Household_Income__c,Area_of_Interest__c',
            'nullRequired': true// includes --None--
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var records = response.getReturnValue();
                component.set("v.LeadsourcePicklist", records[0]);
                component.set("v.AgegroupPicklist", records[1]);
                component.set("v.OwnorRentPicklist",records[2]);
                component.set("v.TransfertoareaPicklist",records[3]);
                component.set("v.TimehousehuntPicklist",records[4]);
                component.set("v.PurchasetimePicklist",records[5]);
                component.set("v.PriceRangePicklist",records[6]);
                component.set("v.BedroomPicklist",records[7]);
                component.set("v.BathroomPicklist",records[8]);
                component.set("v.NoofchildrenPicklist",records[9]);
                component.set("v.VisitBrookfielddcPicklist",records[10]);
                component.set("v.HouseholdIncomePicklist",records[11]);
                var results=records[12]
                var plvalues=[];
                for(var i=0; i<results.length; i++)
                {
                    plvalues.push({
                        label:results[i],
                        value:results[i]
                    });
                }
                component.set("v.AreaofInterestpicklist",plvalues);
                
                var val1=component.get("v.simpleRecord.LeadSource");
                var val2=component.get("v.simpleRecord.Age_Group__c");
                var val3=component.get("v.simpleRecord.Do_you_currently_own_or_rent__c");
                var val4=component.get("v.simpleRecord.Are_you_transferring_to_the_area__c");
                var val5=component.get("v.simpleRecord.How_long_have_you_been_house_hunting__c");
                var val6=component.get("v.simpleRecord.TX_Timeframe_to_purchase__c");
                var val7=component.get("v.simpleRecord.What_is_your_price_range__c");
                var val8=component.get("v.simpleRecord.Bedrooms__c");
                var val9=component.get("v.simpleRecord.Bathrooms__c");
                var val10=component.get("v.simpleRecord.Number_of_Children_in_Home__c");
                var val11=component.get("v.simpleRecord.Visit_Brookfield_website_during_search__c");
                var val12=component.get("v.simpleRecord.Household_Income__c");
                
                window.setTimeout(
                    $A.getCallback(function ()
                                   {
                                     component.find("LeadsourceSelect").set("v.value",val1);
                                     component.find("AgeGroupSelect").set("v.value",val2);
                                     component.find("OwnorRentSelect").set("v.value",val3);
                                     component.find("TransfertoAreaSelect").set("v.value",val4);
                                     component.find("TimehousehuntSelect").set("v.value",val5);
                                     component.find("PurchaseTimeSelect").set("v.value",val6);
                                     component.find("PriceRangeSelect").set("v.value",val7);
                                     component.find("BedroomSelect").set("v.value",val8);
                                     component.find("BathroomSelect").set("v.value",val9);
                                     component.find("NoofcildrenSelect").set("v.value",val10);
                                     component.find("VisitBrookfielddcSelect").set("v.value",val11);
                                     component.find("HouseholdincomeSelect").set("v.value",val12);
                                     component.find("chkMaritalstatus").set("v.checked",component.get("v.simpleRecord.MaritalStatus__c"));
                                     component.find("chkRealtor").set("v.checked",component.get("v.simpleRecord.Realtor__c"));
                                       
                                     var results=component.get("v.simpleRecord.Area_of_Interest__c").split(';');
                          			 component.set("v.Selectedareaofinterestpicklist",results);
                					 alert(component.get("v.simpleRecord.Name")) ;
                                     })
                );
            }
            else if(state === "ERROR")
            {
              var resultsToast = $A.get("e.force:showToast"); 
             	resultsToast.setParams({ 
                "title": "Error", 
                "message": response.getError()[0].message 
                 }); 
            	resultsToast.fire();
             
           }
        });
        $A.enqueueAction(action);
        
    },
    handleSelectionchange : function(component, event, helper)
    {
        var selectedvalues= event.getParam("value");
        component.set("v.Selectedareaofinterestpicklist", selectedvalues);
        
    }
})