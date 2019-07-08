public class NewstarNotificationService {
    

    /*
        Processes an incoming event notification from NEWSTAR

        notification - Inbound notification event
    */
    public static NewstarNotificationResult processNotification(NewstarNotification notification) {

        //construct the result
        NewstarNotificationResult result=new NewstarNotificationResult();
        result.IsSuccess=true;
        
        if(notification.EventType == NewstarNotificationEvent.PendingOfferEvent.Name) {
               return processPendingOffer(notification, result);
        }
        else if (notification.EventType == NewstarNotificationEvent.UnderContractEvent.Name) {
               return processUnderContract(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.ClosedHomeEvent.Name) {
               return processClosedHome(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.CancelledEvent.Name) {
               return processCancelled(notification, result);
        }
        else if (notification.EventType == NewstarNotificationEvent.ContingencyCreatedEvent.Name) {
               return processContingencyCreated(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.ContingencyUpdatedEvent.Name) {
               return processContingencyUpdated(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.ContingencyDeletedEvent.Name) {
               return processContingencyDeleted(notification, result);
        }
        else if (notification.EventType == NewstarNotificationEvent.ReservationExpiredEvent.Name) {
               return processReservationExpired(notification, result);
        }   
        else if (notification.EventType == NewstarNotificationEvent.FinancialInfoUpdatedEvent.Name) {
               return processFinancialInfoUpdated(notification, result);
        }   
        else {
               result.IsSuccess=false;
               result.Message='Unsupported event type: '+notification.EventType;
           }
       

        return result;
    }


    private static NewstarNotificationResult processPendingOffer(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportinity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.PendingOfferStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;


        //return the result       
        return result;
    }


    private static NewstarNotificationResult processUnderContract(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportinity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.UnderContractStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;


        //return the result       
        return result;
    }


    private static NewstarNotificationResult processClosedHome(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportinity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.ClosedHomeStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;


        //return the result       
        return result;
    }    


     private static NewstarNotificationResult processCancelled(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportinity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.CancelledStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;


        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processFinancialInfoUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportinity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //update opportunity
        update opp;


        //return the result       
        return result;
    }


    private static NewstarNotificationResult processContingencyCreated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }


        //get the contingency based on the notification
        Contigency__c con = new Contigency__c(Opportunity__c = opp.Id);

        //set deal Contingency returned from NEWSTAR
        setContingencyFromNewstar(notification, con);

        //insert contingency
        insert con;

        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processContingencyUpdated(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }


        //get the contingency based on the notification
        Contigency__c con=getContingencyFromNotification(notification);
       
       //if the con cannot be found, terminate further processing
       if(con==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate contingency with the specified external ID.';
           return result;
       }

        //set deal Contingency returned from NEWSTAR
        setContingencyFromNewstar(notification, con);

        //update contingency
        update con;


        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processContingencyDeleted(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportunity with the specified external ID.';
           return result;
       }

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }


        //get the contingency based on the notification
        Contigency__c con=getContingencyFromNotification(notification);
       
       //if the con cannot be found, terminate further processing
       if(con==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate contingency with the specified external ID.';
           return result;
       }

        //delete contingency
        delete con;

        //return the result       
        return result;
    }      


    private static NewstarNotificationResult processReservationExpired(NewstarNotification notification, NewstarNotificationResult result) {
     
        //get the opportunity based on the notification
        Opportunity opp=getOpportunityFromNotification(notification);
       
       //if the opp cannot be found, terminate further processing
       if(opp==null) {
           result.IsSuccess=false;
           result.Message='Unable to locate opportinity with the specified external ID.';
           return result;
       }

        //attempt to set the requested opportunity stage
        setOpportunityStage(notification, opp, result, NewstarSalesPipelineStage.EngagementStage.Name);

        //the attempt mail fail due to constraints validation
        if(!result.IsSuccess){

            //terminate furher processing if cannot set the stage
            return result;
        }
       
        //set deal financials returned from NEWSTAR
        setOpportunityFinancialInfoFromNewstar(notification, opp);

        //reset the Lot_Hold_Expiry_Date__c to NULL
        setOpportunityLotHoldExpiryDateToNull(notification, opp);

        //update opportunity
        update opp;


        //return the result       
        return result;
    }      


    /*
        Attempts to set the opportunity stage based on a NEWSTAR notification.
    */
    private static void setOpportunityStage(NewstarNotification notification, Opportunity opp, NewstarNotificationResult result, String transactionStageName) {
        
        //setup the pipeline transition to validate if setting the requested stage is possible
        NewstarSalesPipelineStageTransition stageTransition=new NewstarSalesPipelineStageTransition();
        stageTransition.SourceStageName=opp.StageName;

        //target stage name is specified in the notification object
        stageTransition.TargetStageName=transactionStageName;       


        //mark the transition is automatic to prevent manual transition blocks in validation rules/triggers
        stageTransition.IsAutomated=true;

        //validate the transition
        NewstarSalesPipelineService.ValidateStageTransition(stageTransition);

        //if it is not valid, terminate further processing and return an error
        if(!stageTransition.IsValid)
        {
            result.IsSuccess=false;
            result.Message='Unable to set the requested opportunity to stage: '+stageTransition.TargetStageName+': '+stageTransition.ValidationMessage;
            return;
        }

        //set target stage and flag indicating automatic stage update
        opp.StageName=stageTransition.TargetStageName;
        opp.IsAutomatedStageUpdate__c=true;

    }


    /*
        Sets Lot Hold Expiry Date in the opportunity to Null.
    */
    private static void setOpportunityLotHoldExpiryDateToNull(NewstarNotification notification, Opportunity opp) {
        opp.Lot_Hold_Expiry_Date__c = null;
    }


    /*
        Sets key financial amounts on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setOpportunityFinancialInfoFromNewstar(NewstarNotification notification, Opportunity opp) {
        

        NewstarDealFinancialInfo financialInfo=new NewstarDealFinancialInfo();
        
        NewstarNotificationParameter baseModelPriceParam=notification.getParameter('BaseModelPrice');
        NewstarNotificationParameter lotPriceParam=notification.getParameter('LotPrice');
        NewstarNotificationParameter lotPremiumParam=notification.getParameter('LotPremium');
        NewstarNotificationParameter totalOptionsAmountParam=notification.getParameter('TotalOptionsAmount');
        NewstarNotificationParameter totalDiscountAmountParam=notification.getParameter('TotalDiscountAmount');
        NewstarNotificationParameter totalTaxAmountParam=notification.getParameter('TotalTaxAmount');
        NewstarNotificationParameter totalTaxRebateAmountParam=notification.getParameter('TotalTaxRebateAmount');
        NewstarNotificationParameter totalActualSaleAmountParam=notification.getParameter('TotalSaleAmount');
        
        
        if(baseModelPriceParam!=null){
            financialInfo.BaseModelPrice=NewstarDataConversionHelper.decimalFromString(baseModelPriceParam.Value);
        }

         if(lotPriceParam!=null){
            financialInfo.LotPrice=NewstarDataConversionHelper.decimalFromString(lotPriceParam.Value);
        }

         if(lotPremiumParam!=null){
            financialInfo.LotPremium=NewstarDataConversionHelper.decimalFromString(lotPremiumParam.Value);
        }

        if(totalOptionsAmountParam!=null){
            financialInfo.TotalOptionsAmount=NewstarDataConversionHelper.decimalFromString(totalOptionsAmountParam.Value);
        }

        if(totalDiscountAmountParam!=null){
            financialInfo.TotalDiscountAmount=NewstarDataConversionHelper.decimalFromString(totalDiscountAmountParam.Value);
        }

        
        if(totalTaxAmountParam!=null){
            financialInfo.TotalTaxAmount=NewstarDataConversionHelper.decimalFromString(totalTaxAmountParam.Value);
        }
        
        if(totalTaxRebateAmountParam!=null){
            financialInfo.TotalTaxRebateAmount=NewstarDataConversionHelper.decimalFromString(totalTaxRebateAmountParam.Value);
        }

        if(totalActualSaleAmountParam!=null){
            financialInfo.TotalActualSaleAmount=NewstarDataConversionHelper.decimalFromString(totalActualSaleAmountParam.Value);
        }

        //delegate actual update of the opportunity amounts to a separate service
        NewstarOpporunityInfoService.setOpportunityAmounts(opp, financialInfo);
    }


    /*
        Looks up the opportunity object based on the information supplied in a NEWSTAR notification.
    */
    private static Opportunity getOpportunityFromNotification(NewstarNotification notification) {
    
        //obtain the external ID parameter value
        NewstarNotificationParameter opportunityExternalId=notification.getParameter('opportunityExternalId');

        //if not available, return immediately
        if(opportunityExternalId==null){
            return null;
        }


        //lookup the opportunity
        List<Opportunity> oppList=[SELECT Id, StageName, Base_Model_Price__c, Lot_Price__c, Lot_Premium__c, Total_Options_Amount__c, Total_Discount_Amount__c, Total_Tax_Amount__c, Total_Tax_Rebate_Amount__c, Total_Actual_Sale_Amount__c, Lot_Hold_Expiry_Date__c FROM Opportunity WHERE Newstar_ID__c=: opportunityExternalId.Value LIMIT 1];
        if(oppList.size()==0) {
                return null;
        }

        //return it
        return oppList.get(0);
    }


    /*
        Looks up the contingency object based on the information supplied in a NEWSTAR notification.
    */
    private static Contigency__c getContingencyFromNotification(NewstarNotification notification) {
    
        //obtain the external ID parameter value
        NewstarNotificationParameter contingencyExternalId=notification.getParameter('contingencyExternalId');

        //if not available, return immediately
        if(contingencyExternalId==null){
            return null;
        }


        //lookup the contingency
        List<Contigency__c> conList=[SELECT Id,Type__c,Expiry_date__c,Met_date__c,Notes__c,Newstar_ID__c,Opportunity__c FROM Contigency__c WHERE Newstar_ID__c=: contingencyExternalId.Value LIMIT 1];
        if(conList.size()==0) {
                return null;
        }

        //return it
        return conList.get(0);
    }

    /*
        Sets contingency info on the opportunity based on the updated information from a NEWSTAR notification.
    */
    private static void setContingencyFromNewstar(NewstarNotification notification, Contigency__c con) {
        

        NewstarContingencyInfo contingencyInfo=new NewstarContingencyInfo();

        NewstarNotificationParameter contingencyExternalIdParam=notification.getParameter('ContingencyExternalId');
        NewstarNotificationParameter typeParam=notification.getParameter('Type');
        NewstarNotificationParameter expiryDateParam=notification.getParameter('ExpiryDate');
        NewstarNotificationParameter metDateParam=notification.getParameter('MetDate');
        NewstarNotificationParameter notesParam=notification.getParameter('Notes');

        
        if(contingencyExternalIdParam!=null){
            contingencyInfo.ContingencyExternalId=contingencyExternalIdParam.Value;
        }
        
        if(typeParam!=null){
            contingencyInfo.Type=typeParam.Value;
        }

        if(expiryDateParam!=null){
            contingencyInfo.ExpiryDate=NewstarDataConversionHelper.dateFromString(expiryDateParam.Value);
        }

        if(metDateParam!=null){
            if (metDateParam.Value.startsWith('1900'))
            {
                contingencyInfo.MetDate = null;
            }
            else {
                contingencyInfo.MetDate=NewstarDataConversionHelper.dateFromString(metDateParam.Value);
            }
        }

        if(notesParam!=null){
            contingencyInfo.Notes=notesParam.Value;
        }

        //delegate actual update of the contingency to a separate service
        NewstarContingencyService.setContingency(con, contingencyInfo);

    }

}