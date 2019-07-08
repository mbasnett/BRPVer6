public with sharing class NewstarContractController {
    
    public NewstarContractController() {

    }

    /*
        Attempts Direct Offer for the specified opportunity.
    */
    @AuraEnabled
    public static ContractResult initiateContract(Id opportunityId, Date targetClosingDate) {

      
        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.DirectOffer, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();


        try {
            ContractResult result = NewstarContractOperationsService.performDirectOffer(opportunityId, targetClosingDate);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Direct Offer failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }


        return null;

    }



    /*
        Attempts Undo Direct Offer for the specified opportunity.
    */
    @AuraEnabled
    public static ContractResult cancelContractInitiation(Id opportunityId) {

        NewstarLoggingService.configureLoggingContext(
            NewstarLoggingService.CommonEventType.LWC, 
            NewstarLoggingService.CommonEventContext.DirectOffer, 
            String.valueOf(opportunityId));

        NewstarLoggingService.pushActionStart();

        try {

            ContractResult result = NewstarContractOperationsService.performDirectOfferUndo(opportunityId);

            NewstarLoggingService.pushActionSuccess();

            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Undo Direct Offer failed', ex);
        }
        finally {
            NewstarLoggingService.flushLogEventQueue();
        }


        return null;
    }


    /*
        Returns the opportunity object based on the specified ID
        for use with the Direct Offer initiation UX.
    */
    @AuraEnabled
    public static Opportunity getOpportunity(Id opportunityId){

      return NewstarContractInformationService.getOpportunity(opportunityId);
    
    }



}