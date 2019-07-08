({
	loadrelatedList : function(component, event, helper) {
		var recordId = event.getParam("recordId"); 
        var objectName = event.getParam("objectName"); 
        var Name = event.getParam("Name"); 
        component.set("v.recordId", recordId); 
        component.set("v.Name", Name); 
        if(objectName =="Account")
        {
            component.set("v.sObjectName", "Opportunities"); 
            var action = component.get("c.getOpportunities"); 
            action.setParams({
        	AcctId: recordId
        	});
            component.set('v.fieldsList', [
            {label: 'Marketing community', fieldName: 'MarketingCommunity', type: 'text'},
            {label: 'Sales Office', fieldName: 'SalesOffice', type: 'text'},
            {label: 'Subdivision', fieldName: 'Subdivision', type: 'text'},
            {label: 'Visit Date', fieldName: 'Visit_Date__c', type: 'date'},
            {label: 'Stage', fieldName: 'StageName', type: 'text'}]);
            action.setCallback(this, function(response) { 
            var state = response.getState(); 
            if (state === "SUCCESS") 
            { 
           		var ListItems = response.getReturnValue(); 
                alert(ListItems);
                for (var i = 0; i < ListItems.length; i++) 
                {
                	var row = ListItems[i];
                	if (row.Marketing_Community__c) row.MarketingCommunity = row.Marketing_Community__r.Name;
                    if (row.Sales_Office__c) row.SalesOffice = row.Sales_Office__r.Name;
                    if (row.Subdivision__c) row.Subdivision = row.Subdivision__r.Name;
            	}
           		component.set("v.data", ListItems); 
         	} 
        	});
 			$A.enqueueAction(action); 
        }
        else if(objectName =="Lead")
        {
            component.set("v.sObjectName", "Interest Lists"); 
       	    var action = component.get("c.getInterestLists"); 
        	action.setParams({
        	leadId: recordId
        	});
            component.set('v.fieldsList', [
            {label: 'Marketing community', fieldName: 'MarketingCommunity', type: 'text'},
            {label: 'Sales Office', fieldName: 'SalesOffice', type: 'text'},
            {label: 'Subdivision', fieldName: 'Subdivision', type: 'text'},
            {label: 'Visit Date', fieldName: 'Visit_Date__c', type: 'date'},
            {label: 'Status', fieldName: 'Interest_Status__c', type: 'text'}]);
	    
        	action.setCallback(this, function(response) { 
        	var state = response.getState(); 
        	if (state === "SUCCESS") 
        	{ 
           		var ListItems = response.getReturnValue();
                for (var i = 0; i < ListItems.length; i++) 
                {
                	var row = ListItems[i];
                	if (row.Marketing_Community__c) row.MarketingCommunity = row.Marketing_Community__r.Name;
                    if (row.Sales_Office__c) row.SalesOffice = row.Sales_Office__r.Name;
                    if (row.Subdivision__c) row.Subdivision = row.Subdivision__r.Name;
            	}
           		component.set("v.data", ListItems); 
         	} 
        	});
 			$A.enqueueAction(action); 
        }
    },
    closedialog:  function(component, event, helper){
       
		var compEvent = component.getEvent("closemodaldialog");   
    	compEvent.fire(); 

	}
})