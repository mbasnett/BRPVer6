public with sharing class NewstarOpporunityInfoService {

    public static void setOpportunityNameAtMarketingCommunityLevel(Opportunity opp, NewstarDealContext dealContext)
    {
        
        if(dealContext==null) {
            dealContext=getDealContext(opp);
        }

        if(dealContext.MarketingCommunity!=null) {
            opp.Name=dealContext.CustomerAccount.Name + ' -  ' + dealContext.MarketingCommunity.Name+' - '+opp.Scenario_Name__c;
  
        } 
    }


    public static void setOpportunitySalesProcess(Opportunity opp, NewstarDealContext dealContext) {
        //assign the correct opportunity record type based on the sales process type picklist value configured on the marketing community
        String oppRecordTypeId=Schema.SObjectType.Opportunity.getRecordTypeInfosByName()
                .get(dealContext.MarketingCommunity.Sales_Process_Type__c)
                .getRecordTypeId();

        opp.RecordTypeId=oppRecordTypeId;
    }


    public static void setOpportunityNameAtSubdivisionLevel(Opportunity opp, NewstarDealContext dealContext)
    {
        
        if(dealContext==null) {
            dealContext=getDealContext(opp);
        }

        //set subdivision and lot in the opportunity name, if available
        if(dealContext.Subdivision!=null && dealContext.Lot!=null) {
             opp.Name= dealContext.CustomerAccount.Name + ' -  ' + dealContext.Subdivision.Name +' - Lot '+ dealContext.Lot.Name + ' - '+opp.Scenario_Name__c;
        } 
    }


    public static void setOpportunityAmountsFromDealContext(Opportunity opp, NewstarDealContext dealContext) {

       NewstarDealFinancialInfo financialInfo=new NewstarDealFinancialInfo();
      
       if(dealContext==null) {
            dealContext=getDealContext(opp);
        }

        if(dealContext.Model!=null) {
            financialInfo.BaseModelPrice=dealContext.Model.Price__c;
        }

        if(dealContext.Lot!=null) {
            financialInfo.LotPrice=dealContext.Lot.Price__c;
            financialInfo.LotPremium=dealContext.Lot.Premium__c;
            financialInfo.TotalOptionsAmount=dealContext.Lot.Preconfigured_Options_Amount__c;  

            if(dealContext.Lot.Base_Model_Price_Override__c!=null)
            {
                financialInfo.BaseModelPrice=dealContext.Lot.Base_Model_Price_Override__c;                
            }
        }


        setOpportunityAmounts(opp, financialInfo);
    }


     public static void setOpportunityAmounts(Opportunity opp, NewstarDealFinancialInfo financialInfo) {
        
        if(financialInfo.BaseModelPrice!=null)
            opp.Base_Model_Price__c=financialInfo.BaseModelPrice;
        
        if(financialInfo.LotPrice!=null)
            opp.Lot_Price__c=financialInfo.LotPrice;

        if(financialInfo.LotPremium!=null)
            opp.Lot_Premium__c=financialInfo.LotPremium;

        if(financialInfo.TotalOptionsAmount!=null)
            opp.Total_Options_Amount__c=financialInfo.TotalOptionsAmount;

        if(financialInfo.TotalDiscountAmount!=null)
            opp.Total_Discount_Amount__c=financialInfo.TotalDiscountAmount;

        if(financialInfo.TotalTaxAmount!=null)
            opp.Total_Tax_Amount__c=financialInfo.TotalTaxAmount;

        if(financialInfo.TotalTaxRebateAmount!=null)
            opp.Total_Tax_Rebate_Amount__c=financialInfo.TotalTaxRebateAmount;      

        if(financialInfo.TotalActualSaleAmount!=null)
            opp.Total_Actual_Sale_Amount__c=financialInfo.TotalActualSaleAmount;
      
     } 


    public static NewstarDealContext getDealContext(Opportunity opp) {
      
        NewstarDealContext dealContext=new NewstarDealContext();

        if(opp.Marketing_Community__c!=null) {
          dealContext.MarketingCommunity=[SELECT Id, Name, Sales_Process_Type__c FROM Marketing_Community__c WHERE Id=: opp.Marketing_Community__c LIMIT 1];

        }
      
        if(opp.Subdivision__c!=null){
            dealContext.Subdivision=[SELECT Name FROM Subdivision__c WHERE Id=: opp.Subdivision__c LIMIT 1];
        }
       
        
        if(opp.Lot__c!=null) {
            dealContext.Lot=[SELECT Name, Price__c, Premium__c, Base_Model_Price_Override__c, Preconfigured_Options_Amount__c FROM Lot__c WHERE Id=: opp.Lot__c LIMIT 1];
        } 

        
        if(opp.Model__c!=null) {
            dealContext.Model=[SELECT Name, Price__c FROM Model__c WHERE Id=: opp.Model__c LIMIT 1];
        } 

        dealContext.CustomerAccount=[SELECT Name FROM Account WHERE Id=: opp.AccountId LIMIT 1];

        return dealContext;
    }

}