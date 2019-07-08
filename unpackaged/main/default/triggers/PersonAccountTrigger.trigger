trigger PersonAccountTrigger on Account (before update) {
 if(trigger.isbefore && trigger.isupdate)
    {
           system.debug('before update');
           BRPValidation brpval=new BRPValidation();
           for(sobject s:trigger.new)
           {
               system.debug(s);
               string nameval=BRPValidation.getsalesofficename(s);
               system.debug(s.get('Community_Picklist_'+ nameval +'__pc'));
               brpval.genericInterestcreation(s,'Insert',(string) s.get('Community_Picklist_'+ nameval +'__pc'), 'Community_List_' + nameval +'__pc', 'Community_History_' + nameval +'__pc');
               new LeadandAccountTriggerhandler().ValidateExistingopportunities((account)s);
           }
     }
 
}