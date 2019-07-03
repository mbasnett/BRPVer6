trigger InterestListTrigger on Interest_List__c(after insert, after delete)
{
   /* public map<Id,string> mapInterestList=new map<Id, string>();
    List<lead> lstld=new list<lead>();
        if(trigger.isAfter && trigger.isInsert )
        {
            for(Interest_List__c Intl: trigger.new) 
            {

                if (Intl.Marketing_Community__c !=null )
                    mapInterestList.put(Intl.Lead__c,Cachedcollections.myCommunityIdMap.get(Intl.Marketing_Community__c));
            }
        }
         if(trigger.isAfter && trigger.isDelete )
        {
            for(Interest_List__c Intl: trigger.old) 
            {
                if (Intl.Marketing_Community__c !=null )
                    mapInterestList.put(Intl.Lead__c,Cachedcollections.myCommunityIdMap.get(Intl.Marketing_Community__c));
            }
        }

        if(mapInterestList.size()>0)
            {
                lstld=[select Id,Interested_Communtiy__c,Interested_Community_history__c from Lead where id in :mapInterestList.keyset()];
                for(Lead ld : lstld)
                {
                     list<string> lstcommunity=new list<string>();
                     list<string> lstcommunityHist=new list<string>();
                    if(ld.Interested_Communtiy__c!=null)
                      lstcommunity = ld.Interested_Communtiy__c.split('\n');
                    if(ld.Interested_Community_history__c!=null)
                        lstcommunityHist= ld.Interested_Community_history__c.split('\n');
                    string s=mapInterestList.get(ld.Id);
                    if(lstcommunity.size()>0)
                          {
                              if(trigger.isInsert)
                              {
                                if(lstCommunity.contains(s)==false)
                                    ld.Interested_Communtiy__c= ld.Interested_Communtiy__c + '\n' + s;
                              }
                              else if(trigger.isDelete)
                              {
                                  lstcommunity.remove(lstCommunity.indexOf(s));
                                  string newlist='';
                                  for(integer i=0;i<lstcommunity.size();i++)
                                    newlist = newlist + '\n' + lstcommunity[i];

                                  ld.Interested_Communtiy__c= newlist;                                 
                              }

                          }
                          else
                          {
                              if(trigger.isInsert)
                                ld.Interested_Communtiy__c= s;

                          }
                          
                    if(lstcommunityHist.size()>0)
                          {
                               if(trigger.isInsert)
                                  {
                                     if(lstcommunityHist.contains(s)==false)
                                         ld.Interested_Community_history__c= ld.Interested_Community_history__c + '\n' + s;
                                  }
                          }
                          else
                          {
                              if(trigger.isInsert)
                                   ld.Interested_Community_history__c= s;

                          }
                    
                }
                update  lstld;  
            }
*/
}