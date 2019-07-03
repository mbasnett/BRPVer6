({
	doInit : function(component, event, helper) {
        var action = component.get("c.getLead"); 
        action.setParams({
        	leadId: component.get("v.recordId")
        });
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue(); 
           component.set("v.lead", ListItems); 
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
        
        var action = component.get("c.getSalesOffices");
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        {  
           var ListItems = response.getReturnValue(); 
           component.set("v.SalesOffices", ListItems); 
  		   component.find("MktSalesOffSelect").set('v.value',ListItems[0].Sales_Office__r.Id + '~' + ListItems[0].Sales_Office__r.Name);
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
        component.find('Owner').set("v.value",$A.get("$SObjectType.CurrentUser.Id"));  
        var a=component.get("c.fetchLeadSourcePicklist");
        $A.enqueueAction(a);
	},
    getSubdivisons : function(component, event, helper) 
    {
		var action = component.get("c.getSubdivisions"); 
        var selectCommopt = component.find('MktcommSelect').get('v.value');
        var selectSalesOffopt = component.find('MktSalesOffSelect').get('v.value');
        action.setParams({
        	mktcommId: selectCommopt.split('~')[0],
            salesOffId:selectSalesOffopt.split('~')[0]
        });
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue(); 
           component.set("v.Subdiv", ListItems);
           component.find("SubdivSelect").set('v.value',ListItems[0].Id );
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
    loadcommunity : function(component, event, helper)
    {
    	var a=component.get("c.getMKtcomm");
        $A.enqueueAction(a); 
    },
    loadProject : function(component, event, helper)
    {
    	var a=component.get("c.getSubdivisons");
        $A.enqueueAction(a); 
    },
    getMKtcomm : function(component, event, helper) 
    {
        
		var action = component.get("c.getMktcommunity"); 
        var selectopt = component.find('MktSalesOffSelect').get('v.value');
        action.setParams({
        	SalesOfficeId: selectopt.split('~')[0]
        });
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue(); 
           component.set("v.Mktcommunity", ListItems); 
           component.find("MktcommSelect").set('v.value',ListItems[0].Id + '~' + ListItems[0].Name);
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
        var a=component.get("c.fetchLeadSourcePicklist");
        $A.enqueueAction(a); 
	},
    
 	handleCancel: function(component, event, helper) { 
        $A.get("e.force:closeQuickAction").fire(); 
    },
    quickSave : function(component, event, helper) {
	  var newInterestList = component.get("v.newInterestList"); 
      var salesoffice=component.find("MktSalesOffSelect").get('v.value').split('~');
      var mktcomm=component.find("MktcommSelect").get('v.value').split('~');
      var subdiv=component.find("SubdivSelect").get('v.value');
      newInterestList.Sales_Office__c=salesoffice[0];
      newInterestList.Marketing_Community__c=mktcomm[0];
      newInterestList.Subdivision__c=subdiv;
      var action = component.get("c.Save");
      action.setParams({
        	leadObj: component.get("v.lead"),
            intLstobj:newInterestList,
            cobuyerobj: null,
            LeadId:component.get("v.recordId"),
            AcctId:null
        });
       action.setCallback(this, function(response) { 
       var state = response.getState(); 
       if (state === "SUCCESS") 
        { 
           var recordid = response.getReturnValue(); 
           var navEvt = $A.get("e.force:navigateToSObject");
           navEvt.setParams({
            "recordId": recordid ,
           });
           navEvt.fire();
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
    fetchLeadSourcePicklist : function(component, event, helper){
        var action = component.get("c.getPicklistvalues");
        action.setParams({
            'objectName': 'Interest_List__C',
            'field_apinames': 'Lead_source__c',
            'nullRequired': true // includes --None--
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var records = response.getReturnValue();
                component.set("v.LeadsourcePicklist", records[0]);
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

})