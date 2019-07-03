public class NewstarSyncJobInfo {
    
    public string id {get; set;}
    public String name {get; set;}
    public JobType type {get; set;}
    public JobStatus status {get; set;}
    public InternalJobType internalType {get; set;}

    public Boolean isRunning {get {
        return runningJobStatuses.contains(this.status);
    }}


    public enum JobType {
        GEOGRAPHY_LAYOUT,
        SALES_AGENT,
        SALES_OFFICE,
        SUBDIVSION,
        MODEL,
        LOT,
        OPPORTUNITY_UPDATE
    }


    public enum InternalJobType {
        FUTURE,
        SHARING,
        RECALCULATION,
        SCHEDULEDAPEX,
        BATCHAPEX,
        BATCHAPEXWORKER,
        TESTREQUEST,
        TESTWORKER,
        APEXTOKEN,
        QUEUEABLE
    }


    public enum JobStatus {

        HOLDING,
        QUEUED,
        PREPARING,
        PROCESSING,
        COMPLETED,
        ABORTED,
        FAILED

    }


    static List<JobStatus> runningJobStatuses;


    static {
        runningJobStatuses=new List<JobStatus>();
        runningJobStatuses.add(JobStatus.HOLDING);
        runningJobStatuses.add(JobStatus.QUEUED);
        runningJobStatuses.add(JobStatus.PREPARING);
        runningJobStatuses.add(JobStatus.PROCESSING);
    }
}