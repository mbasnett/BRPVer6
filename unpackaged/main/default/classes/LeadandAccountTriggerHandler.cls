public with sharing class LeadandAccountTriggerHandler
{
    public  void leadconvert(list<Lead> lstlead)
    {   
        for(Lead ld:lstLead)
        {
            if(ld.isconverted==false)
            {
                Database.LeadConvertResult lcr=convertLead(ld.Id);
                if(lcr.isSuccess())
                {
                    Id AccountId=lcr.getAccountId();
                    Account acc=[select Id, recordtypeId,FirstName,LastName,sales_office_mapping__c from  Account where Id=: AccountId];
                    acc.recordtypeId=account.SObjectType.getDescribe().getRecordTypeInfosByName().get('Customer').getRecordTypeId();
                    update acc;
                    sobject s=ld;
                    string nameval=BRPValidation.getsalesofficename(acc);
                    ValidateExistingopportunities(acc);
                    HS_Create_Lead__e event=new HS_Create_Lead__e(recordid__c=AccountId);
                    Eventbus.publish(event);
                    //return AccountId;
                }
            }
        }
        
    }
    private Database.LeadConvertResult convertLead(Id leadId)
    {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(leadId);
            lc.setDoNotCreateOpportunity(true);
            lc.setConvertedStatus(convertStatus.MasterLabel);
            system.debug('Before lead convert');
            try{
                system.debug('Inside Lead convert');
                return Database.convertLead(lc);
            }
            catch (Exception ex) {
                System.debug('@@@@ - convert error: ' + ex.getMessage());
           // ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,string.valueof(ex));
            //ApexPages.addMessage(myMsg);
               // throw new AuraHandledException('Error Exception happend'+ex.getMessage());           
            return null;
            }
    }
    
    private void createOpportunities(account acct,string mktcomm)
    {
        List<Opportunity> lstOpp=new list<Opportunity>();
        Set<Id> setIntlst= new Set<Id>();

        integer index=0;
        list<contact> lstContact= [select Id from Contact where accountid=: acct.Id];
        try
        {
               Opportunity opp=new Opportunity();
               opp.accountId=acct.Id;
               opp.name=acct.Firstname + ' ' + acct.LastName + ' - ' + mktcomm;
               Marketing_community__c mktcommobj=Cachedcollections.myCommunityMap.get(mktcomm);
               opp.marketing_community__c=mktcommobj.Id;
               //opp.LeadSource=ld.leadsource;
               opp.StageName='Prospecting';//intlst.stage__c;
               //if (intLst.lead_source__c!= '')
               //    opp.LeadSource=intLst.lead_source__c;
               opp.closeDate=date.today().addDays(60); /* Look into target close date in newstar*/
               opp.Converted_From_Lead__c=true;
               //if (intLst.Realtor__c!= '')
               //    opp.Real_Estate_Agent__c=intLst.Realtor__c;
               opp.Sales_Office__c=mktcommobj.sales_office__c;
               opp.Scenario_Name__c='Default Scenario';
               lstopp.add(opp);
               insert lstOpp;
       list<OpportunityContactRole> lstoppconrole=new list<OpportunityContactRole>();
        for(Opportunity o : lstOpp)
        {
            OpportunityContactRole ocr = new OpportunityContactRole();
            ocr.OpportunityId = o.Id;
            ocr.ContactId = lstcontact[0].Id;
            ocr.Role = 'Primary Buyer';
            lstoppconrole.add(ocr);
        }
        insert lstoppconrole;
        }
        catch(exception ex)
        {

        }
        
    }
  
  public void ValidateExistingopportunities(account acc)
  {
       
       boolean OppinProgress=true;
       Id OppId;
       sobject s=acc;
       string nameval=BRPValidation.getsalesofficename(s);
       Id mktcommId= cachedcollections.myCommunityMap.get((string) s.get('Community_Picklist_'+ nameval +'__pc')).Id;
       List<Opportunity> opplistexist=BRPvalidation.OpportunityExists(acc.Id,mktcommId);
       if(opplistexist.size()>0)
       {
            for(Opportunity opplst : opplistexist)
            {
               if(opplst.StageName =='Closed Home' || opplst.StageName =='Cancelled')
                 {
                    OppinProgress=false;
                 }
                 else
                 {
                    OppId=opplst.Id;
                 }
            }
            if(!OppinProgress)
              {
                  createOpportunities(acc,(string) s.get('Community_Picklist_'+ nameval +'__pc'));
              }
              else
              {
                        /*beback__c bebacknote=new beback__c();
                        bebacknote.Is_Be_Back__c=true;
                        bebacknote.Opportunity__c=OppId;
                        bebacknote.visit_date__c=date.today();
                        bebacknote.notes__c='customer returned for more information';
                        //bebacknote.name='Note for ' + Cachedcollections.mysubdivisionIdMap.get(intLstobj.subdivision__c);
                        insert bebacknote;*/
              }
        }
        else
        {
            createOpportunities(acc,(string) s.get('Community_Picklist_'+ nameval +'__pc'));
 
        }
  }
}