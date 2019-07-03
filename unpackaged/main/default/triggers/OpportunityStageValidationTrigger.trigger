trigger OpportunityStageValidationTrigger on Opportunity (before update,after update) {
    if(trigger.isafter && trigger.isupdate)
    {
        map<Id,Id> mpaccount=new map<Id,Id>();
        for (Opportunity opp: Trigger.new)
        {
            
            if(trigger.oldmap.get(opp.Id).StageName !=trigger.newmap.get(opp.Id).StageName && 
            (trigger.newmap.get(opp.Id).StageName =='Quote Closed'|| trigger.newmap.get(opp.Id).StageName =='Cancelled'))
            mpaccount.put(trigger.newmap.get(opp.Id).accountid,opp.Id);
            
        }
        BRPValidation brpval=new BRPValidation();
        if(mpaccount.size()>0)
        {
            for(Id oppId : mpaccount.values())
            {
                //(sobject) s=trigger.newmap.get(oppId).account__r.sales_office_mapping__c;
                string nameval=BRPValidation.getsalesofficename(trigger.newmap.get(oppId).account.sales_office_mapping__c);
                sobject saccount=database.query('select id, Interested_Communtiy_' + nameval +'__c, Interested_Community_history_' + nameval +'__c from account where id=:trigger.newmap.get(oppId).accountid');
            //}
            /*string nameval=BRPValidation.getsalesofficename((sobject) s);
            set<id> setaccountid=mpaccount.getkeyset();
            list<sobject> lstaccount=database.query('select ' + Interested_Communtiy_WSH__pc,Interested_Community_history_WSH__pc,id from account where id=:setaccountid);*/
           // new BRPValidation().CommunityInterestcreation(null,lstaccount,'Delete');
          
           
           //for(sobject s:lstaccount)
           //{
               
               brpval.genericInterestcreation(saccount,'Delete',trigger.newmap.get(oppId).marketing_community__r.name , 'Interested_Communtiy_' + nameval +'__c', 'Interested_Community_history_' + nameval +'__c');
           }
        }
    }
    else
    { 
        if(!OpportunityStageValidationTriggerHandler.isFirstExecution)
        {
            return;
        }
   

        for (Opportunity opp: Trigger.new) {

            //acquire prev. version of the opp record
            Opportunity prevOpp = Trigger.oldMap.get(opp.Id);

            //configure stage transition object
            NewstarSalesPipelineStageTransition stageTransition=new NewstarSalesPipelineStageTransition();
            stageTransition.SourceStageName=prevOpp.StageName;
            stageTransition.TargetStageName=opp.StageName;
            stageTransition.IsAutomated=opp.IsAutomatedStageUpdate__c;
       
            //ask the pipeline service to validate the stage transition
            try{
                NewstarSalesPipelineService.ValidateStageTransition(stageTransition);
            }
            catch(NewstarSalesPipelineException e) {
                opp.addError('Error encountered validating stage transition: '+e.getMessage());
            }
      

            //check if the stage transition is valid
            if(!stageTransition.IsValid) {
                //if not, throw an error via the trigger
                opp.addError(stageTransition.ValidationMessage);
            }
            else{
               opp.IsAutomatedStageUpdate__c=false;
            }
        }

        OpportunityStageValidationTriggerHandler.isFirstExecution=false;
    }
}