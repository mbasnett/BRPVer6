({
  // Called when the component is initialized.
  // Subscribes to the channel and displays a toast message.
  // Specifies an error handler function for empApi   
   submitLead: function (component, event, helper) {
    component.set('v.subscription', null);
    component.set('v.notifications', []);
    // Get empApi component.
    const empApi = component.find('empApi');
    // Register empApi error listener and pass in the error handler function.
    //empApi.onError($A.getCallback(errorHandler));
    helper.subscribe(component, event, helper);
    //helper.displayToast(component, 'success', 'Ready to receive notifications.');
    var newlead = component.get("v.newLead");
    newlead.MaritalStatus__c=component.find("chkMaritalstatus").get("v.checked");
    newlead.Realtor__c=component.find("chkRealtor").get("v.checked");
    newlead.Community_Picklist_Wsh__c=component.find("CommIntSelect").get("v.value");
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
    var action = component.get("c.SaveHSrecord");
      action.setParams({
        	leadObj: newlead
        });
       action.setCallback(this, function(response) { 
       var state = response.getState(); 
       if (state === "SUCCESS") 
        { 
           component.set('v.Spinner', !component.get('v.Spinner'));
        } 
        else if (state === "ERROR")
        {
           var resultsToast = $A.get("e.force:showToast"); 
             	resultsToast.setParams({ 
                "title": "Error", 
                "message": response.getError() 
                 }); 
            	resultsToast.fire();
        }
        }); 
  		$A.enqueueAction(action);    
  },
  // Clear notifications in console app.
  onClear: function (component, event, helper) {
    component.set('v.notifications', []);
  },
  // Mute toast messages and unsubscribe/resubscribe to channel.
  onToggleMute: function (component, event, helper) {
    const isMuted = !(component.get('v.isMuted'));
    component.set('v.isMuted', isMuted);
    if (isMuted) {
      helper.unsubscribe(component, event, helper);
    } else {
      helper.subscribe(component, event, helper);
    }
    helper.displayToast(component, 'success', 'Notifications ' +
      ((isMuted) ? 'muted' : 'unmuted') + '.');
  },
     fetchPicklist : function(component, event, helper){
        var action = component.get("c.getPicklistvalues");

        action.setParams({
            'objectName': 'Lead',
            'field_apinames': 'LeadSource,Age_Group__c,Do_you_currently_own_or_rent__c,' +
            'Are_you_transferring_to_the_area__c,How_long_have_you_been_house_hunting__c,' +
            'TX_Timeframe_to_purchase__c,What_is_your_price_range__c,Bedrooms__c,' +
            'Bathrooms__c,Number_of_Children_in_Home__c,Visit_Brookfield_website_during_search__c,'+
            'Household_Income__c,Area_of_Interest__c,Community_Picklist_Wsh__c',
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
                component.set("v.CommunityOfInterestpicklist",records[13]);
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
        
    },
    loadjscripts : function(component, event, helper) 
    {
        var fname=component.find("Firstname").get("v.value");
        var lname=component.find("LastName").get("v.value");
        if(fname !== '' && lname !== '')
        {
            var text = "";
            var temp = "temp";
            var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var x = document.forms[0];
            for (var i = 0; i < 4; i++)
               text += possible.charAt(Math.floor(Math.random() * possible.length));
           var emailadd=fname + '.' + lname + '.' + text + '@brookfielddc.com';
           component.find("Email").set("v.value",emailadd);
        } 
    
    },
})