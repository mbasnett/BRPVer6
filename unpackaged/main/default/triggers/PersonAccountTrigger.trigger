trigger PersonAccountTrigger on Account (before update) {
 if(trigger.isbefore && trigger.isupdate)
    {
           system.debug('before update');
           
           BRPValidation brpval=new BRPValidation();
           for(sobject s:trigger.new)
           {
               string nameval=BRPValidation.getsalesofficename(s);
               brpval.genericInterestcreation(s,'Insert',(string) s.get('Community_Picklist_'+ nameval +'__pc'), 'Interested_Communtiy_' + nameval +'__pc', 'Interested_Community_history_' + nameval +'__pc');
               new LeadandAccountTriggerhandler().ValidateExistingopportunities((account)s);
           }
     }

}