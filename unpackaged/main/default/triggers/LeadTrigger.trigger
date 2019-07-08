trigger LeadTrigger on Lead (before Delete,before insert, after insert) {
    if(trigger.isbefore && trigger.isDelete)
    {
        list<Id> lstLeadIds=new list<Id>();
        for( lead l:trigger.new)
        {
            lstLeadIds.add(l.Id);
        }
        list<Interest_List__c> lstIntList =[select Id from interest_list__c where lead__c in :lstLeadIds];
        if (lstIntList.size()>0)
            delete lstIntList;
    }
       if(trigger.isbefore && trigger.isinsert)
       {
       
           BRPValidation brpval=new BRPValidation();
           for(sobject s:trigger.new)
           {
               string nameval=BRPValidation.getsalesofficename(s);
               brpval.genericInterestcreation(s,'Insert',(string) s.get('Community_Picklist_'+ nameval +'__c'), 'Community_List_' + nameval +'__c', 'Community_History_' + nameval +'__c');
               lead ld=(lead) s;
               //ld.company='brookfield';
           }
           //new BRPValidation().CommunityInterestcreation(trigger.new,null,'Insert');
       }
        if(trigger.isafter && trigger.isinsert )
           new LeadandAccountTriggerHandler().leadconvert(trigger.new);
}