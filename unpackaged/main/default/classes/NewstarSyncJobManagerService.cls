public with sharing class NewstarSyncJobManagerService {
  
    
    /*

    */
    public static NewstarSyncJobInfo initiateSync(List<NewstarSyncTarget> syncTargets) {

        if(syncTargets==null || syncTargets.size()>1) {
            throw new NewstarJobSyncException('Currently only one NEWSTAR sync target is supported.');
        }

        NewstarSyncTarget initialSyncTarget=syncTargets[0];

        NewstarSyncJobInfo initialSyncJob=new NewstarSyncJobInfo();
        initialSyncJob.type=initialSyncTarget.JobType;

        startBatchableForSyncJob(initialSyncJob);
        return initialSyncJob;
    }


    private static void startBatchableForSyncJob(NewstarSyncJobInfo syncJob) {
        Database.Batchable<SObject> syncBatchable=getBatchable(syncJob);
        Database.executeBatch(syncBatchable);
    }


    private static Database.Batchable<SObject> getBatchable(NewstarSyncJobInfo syncJob){

        if(syncJob.type==NewstarSyncJobInfo.JobType.GEOGRAPHY_LAYOUT) {
            return (Database.Batchable<SObject>) new PullNewstarGeographyLayoutBatch(null);
        }
        else if(syncJob.type==NewstarSyncJobInfo.JobType.SALES_AGENT) {
            return (Database.Batchable<SObject>) new PullNewstarSalesAgentsBatch(null);
        }
        else if(syncJob.type==NewstarSyncJobInfo.JobType.SALES_OFFICE) {
            return (Database.Batchable<SObject>) new PullNewstarSalesOfficesBatch(null);
        }
        else if(syncJob.type==NewstarSyncJobInfo.JobType.SUBDIVSION) {
            return (Database.Batchable<SObject>)new PullNewstarSubdivisionsBatch(null);
        }
        else if(syncJob.type==NewstarSyncJobInfo.JobType.MODEL) {
            return (Database.Batchable<SObject>) new PullNewstarSubdivisionModelsBatch(null);
        }
        else if(syncJob.type==NewstarSyncJobInfo.JobType.LOT) {
            return new PullNewstarSubdivisionLotsBatch(null);
        }
         else if(syncJob.type==NewstarSyncJobInfo.JobType.OPPORTUNITY_UPDATE) {
            return(Database.Batchable<SObject>) new RefreshOpportunityPricesBatch();
        }

        throw new NewstarJobSyncException('Unsupported NEWSTAR sync job type encountered: '+syncJob.type.name());
    }
   


    


}