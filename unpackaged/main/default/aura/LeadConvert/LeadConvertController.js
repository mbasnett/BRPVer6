({
    showSpinner: function(component, event, helper) {
		        component.set("v.Spinner", true); 

	},
    hideSpinner: function(component, event, helper) {
		        component.set("v.Spinner", false); 

	},
    doInit : function(component, event, helper) {
        var action = component.get("c.leadconvert"); 
        action.setParams({
        	LeadId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) { 
        var state = response.getState(); 
        if (state === "SUCCESS") 
        { 
           var resultsToast = $A.get("e.force:showToast"); 
             	resultsToast.setParams({ 
                "title": "Success", 
                "message": "Lead was converted successfully" 
                 }); 
            	resultsToast.fire(); 
            
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
     
    }
})