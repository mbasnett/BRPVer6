public inherited sharing class quickLeadCreate
{
    
    @auraenabled
    public static string Save(Lead leadObj,Interest_list__c intLstobj, Cobuyer__c cobuyerobj, Id LeadId,Id AcctId)
    {   
          Id objid;
          try
          {
           
            if(AcctId!=null)
            {
                objid=AcctId;
                sobject s=leadobj;
                string nameval=BRPValidation.getsalesofficename(s);
                Id mktcommId= cachedcollections.myCommunityMap.get((string) s.get('Community_Picklist_'+ nameval +'__c')).Id;
                List<Opportunity> opplistexist=BRPvalidation.OpportunityExists(AcctId,mktcommId);
                boolean OppinProgress=true;
                Id OppId;
                if(opplistexist.size()>0)
                 {
                    for(Opportunity opplst : opplistexist)
                    {
                        if(opplst.StageName =='Closed Home' || opplst.StageName =='Cancelled')
                        {
                            OppinProgress=false;
                            //OppId=opplst.Id;
                        }
                        else
                        {
                            OppId=opplst.Id;
                        }
                    }
                    if(!OppinProgress)
                    {
                        BRPvalidation.createOpportunity(intLstObj,leadObj,AcctId,cobuyerObj);
                    }
                    else
                    {
                       /* beback__c bebacknote=new beback__c();
                        bebacknote.Is_Be_Back__c=true;
                        bebacknote.Opportunity__c=OppId;
                        bebacknote.visit_date__c=date.today();
                        bebacknote.notes__c='customer returned for more information';
                        bebacknote.name='Note for ' + Cachedcollections.mysubdivisionIdMap.get(intLstobj.subdivision__c);
                        insert bebacknote;*/
                    }
                 }
                 else
                 {
                     BRPvalidation.createOpportunity(intLstObj,leadObj,AcctId,cobuyerObj);
                 }
            }
            else if(LeadId ==null )
            {
                insert leadobj;
                system.debug('lead record inserted ' + leadobj );
                BRPvalidation.createInterestList(intLstObj,leadobj,leadobj.Id,cobuyerobj);
                system.debug('Interest list inserted ' + intLstObj);
                objid=leadobj.Id;
            }
            else if(LeadId !=null )
            {
                system.debug('check for duplicate InterestList');
                List<Interest_List__c> intlistexist=BRPvalidation.InterestListExists(leadId,intLstobj.marketing_community__c);
                objid=LeadId;
                boolean interestinProgress=false;
                Id intlistid;
                if(intlistexist.size()>0)
                {
                    for(Interest_list__c intlst:intlistexist)
                    {
                        if(intlst.Interest_Status__c =='Responded Nurture')
                        {
                            interestinProgress=true;
                            intlistid=intlst.Id;
                        }
                    }
                    if(!interestinProgress)
                    {
                        BRPvalidation.createInterestList(intLstObj,leadObj,leadId,cobuyerobj);
                    }
                    else
                    {
                        /*beback__c bebacknote=new beback__c();
                        bebacknote.Is_Be_Back__c=true;
                        bebacknote.Community_of_Interest__c=intlistid;
                        bebacknote.visit_date__c=date.today();
                        bebacknote.notes__c='customer returned for more information';
                        bebacknote.name='Note for ' + Cachedcollections.mysubdivisionIdMap.get(intLstobj.marketing_community__c);
                        insert bebacknote;*/
                    }
                }
                else
                {
                    BRPvalidation.createInterestList(intLstObj,leadobj,leadId,cobuyerObj);
                }
            }    
       
        }
        catch(exception ex)
        {
            system.debug(ex.getmessage());
        }
        return objId;
    }

   @auraenabled
    public static list<subdivision__c> getSubdivisions(id mktcommId, id salesOffId)
    {
       List<subdivision__c> lstsubdivisions= [select id, name from subdivision__c where Marketing_Community__c =:mktcommId and Sales_Office__c =:salesOffId ];
       return lstsubdivisions;
    }
    @auraenabled
    public static list<Marketing_community__c> getMktcommunity(id SalesOfficeId)
    {
       List<Marketing_community__c> lstMktCommunity= [select id, name from Marketing_community__c where Sales_office__c =:SalesOfficeId];
       return lstMktCommunity;
    }
    /*@auraenabled
    public static list<Marketing_Division__c> getMktDivisions()
    {
       List<Marketing_Division__c> lstmktdivisions= [select id, name from Marketing_Division__c ];
       return lstmktdivisions;
    }*/
    @auraenabled
    public static list<SalesAgentSalesOfficeLink__c> getSalesOffices()
    {
       //list<Id> lstSalesOffId=new list<id>();
       //for( SalesAgentSalesOfficeLink__c  sofficelink : 
       system.debug(UserInfo.getUserId());
       list<SalesAgentSalesOfficeLink__c> lstSalesOffice=[select Sales_Office__r.Id,Sales_Office__r.Name from SalesAgentSalesOfficeLink__c where Sales_Agent__r.Related_to_User__c=:UserInfo.getUserId() order by Is_primary__c desc ];
       //{
          /// lstSalesOffId.add(sofficelink.Id);
      // }
       //List<Sales_Office__c> lstSalesOffice= [select id, name from Sales_Office__c where Id=: lstSalesOffId];
       return lstSalesOffice;
    }
    @AuraEnabled
    public static AccountAndLead AccountAndLeadRecords(Lead leadobj)
    {
        AccountAndLead al = new AccountAndLead();
        al.a = BRPvalidation.AccountExists(leadobj) ;
        al.c = BRPvalidation.LeadExists(leadobj);
        return al;
   }
   @AuraEnabled
   public static list<Interest_List__c> getInterestLists(id leadId)
   {
       
       List<Interest_List__c> lstIntLstobj=[select Id,Marketing_Community__r.Name,Sales_Office__r.Name,Subdivision__r.name,Visit_Date__c,Interest_Status__c
       from Interest_List__c where lead__c=: leadId];
       system.debug('Interest lists:' + lstIntLstobj);
       return lstIntLstobj;
   }
   @AuraEnabled
   public static list<Opportunity> getOpportunities(id AcctId)
   {

       List<Opportunity> lstOppobj=[select Id,Marketing_Community__r.Name,Sales_Office__r.Name,Subdivision__r.name,Visit_Date__c,StageName
       from Opportunity where AccountId=: AcctId];
       system.debug('Opportunities:' + lstOppobj);
       return lstOppobj;
   }
  @Auraenabled
  public static Lead getLead(Id leadId)
  {
      return [select FirstName,LastName, Marketing_Division__c from Lead where Id=: leadId];
  }
  @AuraEnabled
    public static List<List<String>> getPicklistvalues(String objectName, String field_apinames,Boolean nullRequired){
         List<List<string>> picklists= new List<List<string>>();
        list<string> fieldnames=field_apinames.split(',');
        for (integer i =0; i<fieldnames.size(); i++)
        {
        List<String> optionlist = new List<String>();
        
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Map<String, Schema.SObjectField> field_map = gd.get(objectName.toLowerCase()).getDescribe().fields.getMap(); 
        system.debug(fieldnames[i]);
        List<Schema.PicklistEntry> picklistValues = field_map.get(fieldnames[i]).getDescribe().getPickListValues();
        
        if(nullRequired == true){
            optionlist.add('--None--');
        }
        
        for (Schema.PicklistEntry pv : picklistValues) {
            optionlist.add(pv.getValue());
        }
        picklists.add(optionlist);
        }
        return picklists;
    }
  @Auraenabled
  public static void SaveHSrecord(lead leadObj)
  {
     system.debug('hello');
     Hubspotcreationcalls.createHsformdata(leadobj);
  }
}