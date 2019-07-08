public with sharing class NewstarSubdivisionExplorerController {
   
    public NewstarSubdivisionExplorerController() {

    }


    @AuraEnabled(cacheable=true)
    public static NewstarSubdivisionExplorerData getExplorerData(Id opportunityId) {

        return NewstarSubdivisionExplorerService.getExplorerDataForOpportunity(opportunityId);        

    }


    @AuraEnabled
    public static SubdivisionExplorerActionResult setOpportunityLot(Id opportunityId, Id lotId) {
        
        
        try {
            SubdivisionExplorerActionResult result=NewstarSubdivisionExplorerService.setOpportunityLot(opportunityId, lotId);
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Assigning lot to the opportunity failed.', ex);
        }
        finally {
            
        }

        return null;
    }



    @AuraEnabled
    public static SubdivisionExplorerActionResult setOpportunityModel(Id opportunityId, Id modelId) {
        
        
        try {
            SubdivisionExplorerActionResult result=NewstarSubdivisionExplorerService.setOpportunityModel(opportunityId, modelId);
            return result;
        }
        catch(Exception ex){
            NewstarExceptionService.throwAuraException('Assigning model to the opportunity failed.', ex);
        }
        finally {
            
        }

        return null;
    }


}