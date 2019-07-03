@isTest
private class LeadandinterestListQuickCreateTest
{
    static testmethod void testLeadandInterestListCreate()
    {
        test.startTest();
       
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        Marketing_community__c mktcomm=new Marketing_community__c(Name='Avendale', Sales_office__c=soffice.Id,Sales_Process_Type__c='Lot Reservation');
        insert mktcomm;
        Subdivision__c sdiv=new subdivision__c(Name='Avendale 70s', Marketing_Community__c=mktcomm.Id,sales_office__c=soffice.Id);
        insert sdiv;
        Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com');
        Interest_List__c intlst=new Interest_List__c(sales_office__c=soffice.Id,marketing_community__c=mktcomm.Id,subdivision__c=sdiv.Id,Lead_source__c='Facebook');
        string objid=quickLeadcreate.Save(ld,intlst,null,null,null);
        test.stopTest();
        list<Interest_list__c> lstintlst=[select id from Interest_list__c where lead__c =:objid];
        system.assertEquals(1,lstintlst.size());
        
    }
    static testmethod void testDuplicateLead()
    {
        testLeadandInterestListCreate();
        //test.startTest();
        Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com');
        AccountandLead aclead=new AccountandLead();
        aclead=quickLeadcreate.AccountAndLeadRecords(ld);
       // test.stopTest();
        system.assertEquals(0,aclead.a.size());
        system.assertEquals(1,aclead.c.size());
        
    }
    static testmethod void testDuplicateAccount()
    {
        testAccountcreate();
        //test.startTest();
        Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com');
        AccountandLead aclead=new AccountandLead();
        aclead=quickLeadcreate.AccountAndLeadRecords(ld);
       // test.stopTest();
        system.assertEquals(1,aclead.a.size());
        system.assertEquals(0,aclead.c.size());
        
    }
    static testmethod void testAccountcreate()
    {
        test.startTest();
        String RecTypeId= [select Id from RecordType where (Name='Person Account') and (SobjectType='Account')].Id;
        Account acc=new Account( RecordTypeID=RecTypeId,FirstName='Test1',LastName='Lead Tester', PersonEmail='test1@rediff.com');
        insert acc;
        test.stopTest();
    }
    static testmethod void testDuplicateInterestList()
    {
        test.startTest();
        Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com');
        insert ld;
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        Marketing_community__c mktcomm=new Marketing_community__c(Name='Avendale', Sales_office__c=soffice.Id,Sales_Process_Type__c='Lot Reservation');
        insert mktcomm;
        Subdivision__c sdiv=new subdivision__c(Name='Avendale 70s', Marketing_Community__c=mktcomm.Id,sales_office__c=soffice.Id);
        insert sdiv;
        Interest_List__c intlst1=new Interest_List__c(lead__c=ld.Id,sales_office__c=soffice.Id,marketing_community__c=mktcomm.Id,subdivision__c=sdiv.Id,Lead_source__c='Facebook',Stage__c='Working',Interest_status__c='Responded Nurture');
        insert intlst1;
        Interest_List__c intlst2=new Interest_List__c(lead__c=ld.Id,sales_office__c=soffice.Id,marketing_community__c=mktcomm.Id,subdivision__c=sdiv.Id,Lead_source__c='Facebook',Stage__c='Working',Interest_status__c='Responded Nurture');
        quickLeadcreate.Save(ld,intlst2,null,ld.Id,null);
        test.stopTest();
        list<Interest_list__c> lstintlst=[select id from Interest_list__c where lead__c =:ld.Id];
        system.assertEquals(1,lstintlst.size());
        list<beback__c> beback=[select id from beback__c where Community_of_Interest__c =:intlst1.Id];
        system.assertEquals(1,beback.size());
        
    }
    static testmethod void testNotDuplicateInterestList()
    {
        test.startTest();
        Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com');
        insert ld;
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        Marketing_community__c mktcomm=new Marketing_community__c(Name='Avendale', Sales_office__c=soffice.Id,Sales_Process_Type__c='Lot Reservation');
        insert mktcomm;
        Subdivision__c sdiv=new subdivision__c(Name='Avendale 70s', Marketing_Community__c=mktcomm.Id,sales_office__c=soffice.Id);
        insert sdiv;
        Interest_List__c intlst1=new Interest_List__c(lead__c=ld.Id,sales_office__c=soffice.Id,marketing_community__c=mktcomm.Id,subdivision__c=sdiv.Id,Lead_source__c='Facebook',Stage__c='Lead Lost');
        insert intlst1;
        Interest_List__c intlst2=new Interest_List__c(lead__c=ld.Id,sales_office__c=soffice.Id,marketing_community__c=mktcomm.Id,subdivision__c=sdiv.Id,Lead_source__c='Facebook',Stage__c='Working',Interest_status__c='Responded Nurture');
        quickLeadcreate.Save(ld,intlst2,null,ld.Id,null);
        test.stopTest();
        list<Interest_list__c> lstintlst=[select id from Interest_list__c where lead__c =:ld.Id];
        system.assertEquals(2,lstintlst.size());
        list<beback__c> beback=[select id from beback__c where Community_of_Interest__c =:intlst1.Id];
        system.assertEquals(0,beback.size());
        
    }
    static testmethod void testDuplicateAccountWithNewOpportunity()
    {
        test.startTest();
        String RecTypeId= [select Id from RecordType where (Name='Person Account') and (SobjectType='Account')].Id;
        Account acc=new Account( RecordTypeID=RecTypeId,FirstName='Test1',LastName='Lead Tester', PersonEmail='test1@rediff.com');
        insert acc;
        Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com');
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        Marketing_community__c mktcomm=new Marketing_community__c(Name='Avendale', Sales_office__c=soffice.Id,Sales_Process_Type__c='Lot Reservation');
        insert mktcomm;
        Subdivision__c sdiv=new subdivision__c(Name='Avendale 70s', Marketing_Community__c=mktcomm.Id,sales_office__c=soffice.Id);
        insert sdiv;
        Interest_List__c intlst1=new Interest_List__c(lead__c=ld.Id,sales_office__c=soffice.Id,marketing_community__c=mktcomm.Id,subdivision__c=sdiv.Id,Lead_source__c='Facebook',Stage__c='Working',Interest_status__c='Responded Nurture');
        quickLeadcreate.Save(ld,intlst1,null,null,acc.Id);
        test.stopTest();
        list<Opportunity> lstopp=[select id from opportunity where accountid =:acc.Id];
        system.assertEquals(1,lstopp.size());
    }
    static testmethod void Subdivisions()
    {
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        Marketing_community__c mktcomm=new Marketing_community__c(Name='Avendale', Sales_office__c=soffice.Id,Sales_Process_Type__c='Lot Reservation');
        insert mktcomm;
        Subdivision__c sdiv=new subdivision__c(Name='Avendale 70s', Marketing_Community__c=mktcomm.Id,sales_office__c=soffice.Id);
        insert sdiv;
        list<subdivision__c> lstsubdiv=quickLeadcreate.getSubdivisions(mktcomm.Id,soffice.Id);
        system.assertEquals(1,lstsubdiv.size());
    }
    static testmethod void Marketingcommunity()
    {
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        Marketing_community__c mktcomm=new Marketing_community__c(Name='Avendale', Sales_office__c=soffice.Id,Sales_Process_Type__c='Lot Reservation');
        insert mktcomm;
        list<Marketing_community__c> lstmktcomm=quickLeadcreate.getMktcommunity(soffice.Id);
        system.assertEquals(1,lstmktcomm.size());
    }
    static testmethod void SalesOffice()
    {
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        sales_agent__c sagent=new Sales_agent__c(first_name__c='Test',last_name__c='User1', related_to_user__c=userinfo.getUserId());
        insert sagent;
        SalesAgentSalesOfficeLink__c  sofficelink=new SalesAgentSalesOfficeLink__c (sales_agent__c=sagent.Id,sales_office__c=soffice.Id);
        insert sofficelink;
        list<SalesAgentSalesOfficeLink__c> lstsaleslink=quickLeadcreate.getSalesOffices();
        system.assertEquals(1,lstsaleslink.size());

    }
    static testmethod void testLeadconversion()
    {
        test.startTest();
        Lead ld=new Lead(FirstName='Test1',LastName='Lead Tester', Email='test1@rediff.com');
        insert ld;
        Sales_Office__c soffice=new Sales_Office__c(Name='Washington Dc');
        insert soffice;
        Marketing_community__c mktcomm1=new Marketing_community__c(Name='Avendale', Sales_office__c=soffice.Id,Sales_Process_Type__c='Lot Reservation');
        insert mktcomm1;
        Subdivision__c sdiv=new subdivision__c(Name='Avendale 70s', Marketing_Community__c=mktcomm1.Id,sales_office__c=soffice.Id);
        insert sdiv;
        Marketing_community__c mktcomm2=new Marketing_community__c(Name='Oakdale Projects', Sales_office__c=soffice.Id,Sales_Process_Type__c='Direct Offer');
        insert mktcomm2;
        Interest_List__c intlst1=new Interest_List__c(lead__c=ld.Id,sales_office__c=soffice.Id,marketing_community__c=mktcomm1.Id,subdivision__c=sdiv.Id,Lead_source__c='Walk-in',Stage__c='Working',Interest_status__c='Responded Nurture');
        insert intlst1;
        Interest_List__c intlst2=new Interest_List__c(lead__c=ld.Id,sales_office__c=soffice.Id,marketing_community__c=mktcomm2.Id,subdivision__c=sdiv.Id,Lead_source__c='Facebook',Stage__c='Working',Interest_status__c='Responded Nurture');
        insert intlst2;
        test.stopTest();
        list<Interest_list__c> lstintlst=quickLeadcreate.getInterestLists(ld.Id);
        system.assertEquals(2,lstintlst.size());
        Id accId=LeadConvertController.leadconvert(ld.Id);
        list<Opportunity> lstopp=quickLeadcreate.getOpportunities(accId);
        system.assertEquals(2,lstopp.size());
        list<lead> lstlead=[select id from lead where id=:ld.Id and isconverted=true];
        system.assertEquals(1,lstlead.size());
        
    }
    
}