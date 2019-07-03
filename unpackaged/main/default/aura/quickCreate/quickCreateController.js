({
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
    getMKtcomm : function(component, event, helper) 
    {
		var action = component.get("c.getMktcommunity"); 
        var selectopt = component.find('MktSalesOffSelect').get("v.value");
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
	},
    Validate : function(component, event, helper) {
      var newlead = component.get("v.newLead");   
      var action = component.get("c.AccountAndLeadRecords");
      if($A.util.isEmpty(newlead.LastName))
      {
          var resultsToast = $A.get("e.force:showToast"); 
             	resultsToast.setParams({ 
                "title": "Error", 
                "message": "LastName is required" 
                 }); 
            	resultsToast.fire();
      }
      else
      {
      action.setParams({
        	leadobj: newlead
        });
       action.setCallback(this, function(response) { 
       var state = response.getState(); 
       if (state === "SUCCESS") 
        { 
           var records = response.getReturnValue();
           if(records.a.length != 0 || records.c.length != 0)
           {   
           		component.set("v.ExstAcct",records.a);
           		component.set("v.ExstLead",records.c);
                var searchResults= component.find("searchResults");
                $A.util.removeClass(searchResults,"slds-hide");
                var quickForm= component.find("quickForm");
                $A.util.addClass(quickForm,"slds-hide");
           }
            else
            {
               var a=component.get("c.quickSave");
               $A.enqueueAction(a); 
            }
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
      }
	},
	quickSave : function(component, event, helper) {
      var newlead = component.get("v.newLead");   
	  var newInterestList = component.get("v.newInterestList"); 
      var newCobuyer = component.get("v.newCobuyer");
      if($A.util.isEmpty(newCobuyer.Last_Name__c))
          newCobuyer=null;
      var salesoffice=component.find("MktSalesOffSelect").get('v.value').split('~');
      var mktcomm=component.find("MktcommSelect").get('v.value').split('~');
      var subdiv=component.find("SubdivSelect").get('v.value');
      newlead.Sales_office_mapping__c=salesoffice[1];
      newlead.Community_Text__c=mktcomm[1];
      newInterestList.Sales_Office__c=salesoffice[0];
      newInterestList.Marketing_Community__c=mktcomm[0];
      newInterestList.Subdivision__c=subdiv;
      var action = component.get("c.Save");
      action.setParams({
        	leadObj: newlead,
            intLstobj:newInterestList,
            cobuyerobj: newCobuyer,
            LeadId:null,
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
   loadoptions : function(component, event, helper) {
        
        var action = component.get("c.getSalesOffices"); 
    	action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var ListItems = response.getReturnValue(); 
           component.set("v.SalesOffices", ListItems);
		   component.find("MktSalesOffSelect").set('v.value',ListItems[0].Sales_Office__r.Id + '~' + ListItems[0].Sales_Office__r.Name);
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
    loadproject : function(component, event, helper)
    {
        var b=component.get("c.getSubdivisons");
        $A.enqueueAction(b); 
    },
    decisionPath : function(component, event, helper)
    {
       var target = event.getSource();
       var newlead = component.get("v.newLead");   
	   var newInterestList = component.get("v.newInterestList"); 
       var newCobuyer = component.get("v.newCobuyer");
       var LeadId= component.get("v.LeadId");
       var AcctId=component.get("v.AcctId");
       var action = component.get("c.Save");
       if($A.util.isEmpty(newCobuyer.Last_Name__c))
          newCobuyer=null;
       var salesoffice=component.find("MktSalesOffSelect").get('v.value').split('~');
       var mktcomm=component.find("MktcommSelect").get('v.value').split('~');
       newlead.Sales_office_mapping__c=salesoffice[1];
       newlead.Community_Text__c=mktcomm[1];
       newInterestList.Sales_Office__c=salesoffice[0];
       newInterestList.Marketing_Community__c=mktcomm[0];
       if(target.get("v.label")=="Not Me!")
       {
            action.setParams({
        	leadObj: newlead,
            intLstobj:newInterestList,
            cobuyerobj: newCobuyer,
            LeadId:null,
            AcctId:null
        });
       }
       if(target.get("v.label")=="Update")
       {
            /*var a=component.get("c.validateradioselection");
            $A.enqueueAction(a); */
 			action.setParams({
        	leadObj: newlead,
            intLstobj:newInterestList,
            cobuyerobj: newCobuyer,
            LeadId:LeadId,
            AcctId:AcctId
        });
               
       }
      
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
    onLeadRadio: function(component, event) {
		 var selected = event.getSource().get("v.name");
		 component.set("v.LeadId", selected);
         component.set("v.AcctId", null);
         var accradio=component.find('accradio');
         if(!($A.util.isUndefinedOrNull(accradio)))
         {
         	if($A.util.isUndefinedOrNull(accradio.length)) 
         	{
            	accradio.set("v.value",'false');
         	}
        	else
        	{
        		for(var i=0;i<accradio.length;i++)
		 			accradio[i].set("v.value",'false');
            
        	}
         }
        var ldradio=component.find('ldradio');
            for(var i=0;i<ldradio.length;i++)
            {
		 		if(ldradio[i].get("v.name")!=selected)
                    ldradio[i].set("v.value",'false');
            }
         component.find("Update").set("v.disabled", 'false');
        
    },
    onAcctRadio: function(component, event) {
		 var selected = event.getSource().get("v.name");
		 component.set("v.AcctId", selected);
         component.set("v.LeadId", null);
         var ldradio=component.find('ldradio');
         if(!($A.util.isUndefinedOrNull(ldradio)))
         {
         	if($A.util.isUndefinedOrNull(ldradio.length)) 
         	{
            	ldradio.set("v.value",'false');
         	}
        	else
        	{
            	for(var i=0;i<ldradio.length;i++)
         			ldradio[i].set("v.value",'false');
        	}
         }
        var accradio=component.find('accradio');
            for(var i=0;i<accradio.length;i++)
            {
		 		if(accradio[i].get("v.name")!=selected)
                    accradio[i].set("v.value",'false');
            }
         component.find("Update").set("v.disabled", 'false');
    },
    getDetails :  function(component, event, helper){
        var evt = $A.get("e.c:navigate");
        var recordId= event.currentTarget.getAttribute("data-recId").split('~');
        //component.set("v.Name",recordId[1]);
        if(recordId[0].startsWith('001'))
        {
         	evt.setParams({
        	recordId: recordId[0],
            Name:recordId[1],
            objectName:'Account'
         });
        }
        else if(recordId[0].startsWith('00Q'))
        {
         	evt.setParams({
        	recordId: recordId[0],
            Name:recordId[1],
            objectName:'Lead'
       
        });
        }
    	evt.fire();
        helper.showPopupHelper(component, 'modaldialog', 'slds-fade-in-');
		helper.showPopupHelper(component,'backdrop','slds-backdrop--');
	},
    closedialog:  function(component, event, helper){
		 helper.hidePopupHelper(component, 'modaldialog', 'slds-fade-in-');
		 helper.hidePopupHelper(component, 'backdrop', 'slds-backdrop--');
	}
})