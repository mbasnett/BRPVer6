public with sharing class BRPvalidation
{
    public static list<Lead> LeadExists(Lead leadobj)
    {
       List<Lead> dupleadobj;
       string query= 'select Id, Name,Phone,MobilePhone,Email,Street,City,State,Community_Text__c from Lead where isconverted = false ';
       if(leadobj.email!= '')
           query=query + ' and email=\'' + leadobj.email +'\'';
       else
       {
       
           query = query + ' and lastname =\'' + leadobj.lastName + '\' and ( phone =\'' + leadobj.Phone + '\' or  MobilePhone =\'' + leadobj.mobilephone + '\' )';
       }
       system.debug(query);
       dupleadobj=Database.Query(query);
       return dupleadobj;
    }
    public static list<Interest_List__c> InterestListExists(Id LeadId,Id MarketingcommunityId)
    {
       List<Interest_List__c> Intlistleadobj=[select id, name,Interest_Status__c from Interest_list__c where lead__c=: LeadId 
       and marketing_community__c=:MarketingcommunityId order by visit_date__c desc]; 
       return Intlistleadobj;
    }
    public static list<Account> AccountExists(Lead leadobj)
    {
       // system.debug('lastname =' + leadobj.lastName + ' and marketing_division__c =' + leadobj.marketing_division__c + 'and (  phone =' + leadobj.Phone + ' or Personemail =' + leadobj.email +' or PersonMobilePhone = ' + leadobj.mobilephone +')'); 
       List<Account> accountobj=[select Id, Name,PersonEmail,PersonMobilePhone,Phone,PersonMailingAddress from Account where lastname =: leadobj.lastName 
       and (  phone =: leadobj.Phone or Personemail =: leadobj.email
       or PersonMobilePhone =: leadobj.mobilephone  )];
       return accountobj;
       
    }
    public static list<Opportunity> OpportunityExists(Id AccountId,Id MktcommId)
    {
       List<Opportunity> oppobj=[select id, name,StageName from Opportunity where accountId=: AccountId and Marketing_Community__c=: MktcommId ];
       return oppobj;
    }
    public static interest_list__c createInterestList(Interest_list__c intlstobj, Lead leadobj, Id LeadId, cobuyer__c cobuyerobj)
   {
        if (leadId==null)
            leadId=leadobj.Id;
        //for(Interest_list__c  intlst :intlstobj)
        //{
            system.debug('inside Interest list create ' + intlstobj);
            system.debug('leadId');
            intlstobj.Lead__c=leadId;
            string mrktcommunityname=Cachedcollections.myCommunityIdMap.get(intlstobj.Marketing_community__c);
            string mrktdivisionname=Cachedcollections.mySalesOfficeIdMap.get(intlstobj.Sales_office__c).split(' ')[0] + ' Interest List';
            system.debug(mrktcommunityname);
            system.debug(mrktdivisionname);
            intlstobj.Name= leadobj.FirstName + ' ' + leadobj.LastName + ' - ' + mrktcommunityname;
           
            intlstobj.recordTypeId=Schema.SObjectType.Interest_list__c.getRecordTypeInfosByName().get(mrktdivisionname).getRecordTypeId();
            intlstobj.stage__c='New';
            if(leadobj.Is_Hubspot_lead__c==true)
            {
                //system.debug('mktg comm name4: ' + intlstobj.Marketing_Community__r.Name);
                //system.debug('mktg comm name5: ' + mrktcommunityname);
                string commtname=Cachedcollections.myCommunityMap.get(mrktcommunityname).Assigned_Queue__c.replace('_', ' ');
//                string commtname=Cachedcollections.myCommunityMap.get(intlstobj.marketing_community__r.Name).Assigned_Queue__c.replace('_', ' ');
                //system.debug(commtname);
                intlstobj.ownerId= getInterestListOwnerId(commtname);
            }
            
            
       // }
        insert intLstobj;
        if(cobuyerobj!=null)
        {
                cobuyerobj.recordtypeId=Schema.SObjectType.Cobuyer__c.getRecordTypeInfosByName().get('Interest List').getRecordTypeId();
                cobuyerobj.Interest_List__c= intLstobj.Id;
                insert  cobuyerobj; 
        }
        return intlstObj;
   }
   public static Opportunity createOpportunity(interest_list__c intlstobj, lead leadobj, Id AcctId, cobuyer__c cobuyerobj)
   {
            Opportunity oppobj=new opportunity();
            oppobj.Name= leadObj.FirstName + ' ' + leadObj.LastName + ' - ' + Cachedcollections.mysubdivisionIdMap.get(intLstobj.subdivision__c);
            oppobj.accountid=AcctId;
            oppobj.Marketing_Community__c  = intLstobj.Marketing_Community__c;
            oppobj.Sales_office__c=intLstobj.Sales_office__c;
            oppobj.Subdivision__c   =intLstobj.Subdivision__c ;
            oppobj.Visit_Date__c = intLstobj.Visit_Date__c;
            if(intlstobj.stage__c=='New')
                oppobj.StageName='Prospecting';
            else if(intlstobj.stage__c=='Lead Lost')
                oppobj.StageName='Closed Lost';
            else if(intlstobj.stage__c=='Working')
                oppobj.StageName='Engagement';
            oppobj.closeDate=date.today().addDays(60); 
            oppobj.Scenario_Name__c='Default Scenario';
            insert oppobj;
            if(cobuyerobj!=null)
            {
                cobuyerobj.recordtypeId=Schema.SObjectType.Cobuyer__c.getRecordTypeInfosByName().get('Opportunity').getRecordTypeId();
                cobuyerobj.Interest_List__c= oppObj.Id;
                insert  cobuyerobj; 
            }
            return oppobj;
   }
   private static Id getInterestListOwnerId(string communityname)
   {
       QueueSObject QueueID = [Select Queue.Id, Queue.Name, Queue.Type from QueueSObject WHERE Queue.Type ='Queue' AND Queue.Name =: communityname Limit 1];
       return QueueID.Queue.Id; 

   }
   public void genericInterestcreation( sobject s,string actiontype,string val, string activelistfieldname, string historylistfieldname  )
   {
      list<string> lstcommunity=new list<string>();
      list<string> lstcommunityHist=new list<string>();
      string activevalue=(string)s.get(activelistfieldname);
      string historyvalue=(string)s.get(historylistfieldname);
      system.debug(activevalue);
      system.debug(historyvalue);
      if(activevalue!=null)
          lstcommunity = activevalue.split('\n');
      if(historyvalue!=null)
          lstcommunityHist = historyvalue.split('\n');
      if(lstcommunity.size()>0)
          {
              if(actiontype=='Insert')
                   {
                       if(lstCommunity.contains(val)==false)
                          s.put(activelistfieldname, activevalue + '\n' + val);
                   }
              else if(actiontype=='Delete')
                   {
                       lstcommunity.remove(lstCommunity.indexOf(val));
                       string newlist='';
                       for(integer i=0;i<lstcommunity.size();i++)
                       newlist = newlist + '\n' + lstcommunity[i];
                       s.put(activelistfieldname,newlist);                                 
                   }

           }
       else
           {
               if(actiontype=='Insert')
                   s.put(activelistfieldname, val);

           }
                          
       if(lstcommunityHist.size()>0)
           {
               if(actiontype=='Insert')
                   {
                        if(lstcommunityHist.contains(val)==false)
                             s.put(historylistfieldname  , historyvalue + '\n' + val);
                   }
           }
        else
           {
               if(actiontype=='Insert')
                         s.put(historylistfieldname, val);

           }
      
   }
   public static string getsalesofficename(sobject s)
    {
        string sname=(string) s.get('sales_office_mapping__c');
        BRPSalesSettings__c soffname= BRPSalesSettings__c.getInstance(sname.split(' ')[0]);
        return soffname.Sales_Office_Name__c ;
    }
    public static string getsalesofficename(string sname)
    {
        //string sname=(string) s.get('sales_office_mapping__c');
        BRPSalesSettings__c soffname= BRPSalesSettings__c.getInstance(sname.split(' ')[0]);
        return soffname.Sales_Office_Name__c ;
    }
}