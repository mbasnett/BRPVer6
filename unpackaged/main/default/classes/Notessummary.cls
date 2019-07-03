public inherited sharing class Notessummary
{
    public lead leadObj{get; set;} 
    public account acctobj{get;set;}
    public Interest_List__c intLstobj{get; set;}
    public string notes{get; set;}
    public Notessummary(ApexPages.StandardController controller) 
    {
      this.notes='';
      String type = controller.getRecord().getSObjectType().getDescribe().getName();
      if (type=='Lead')
          this.leadobj = (Lead)Controller.getRecord();
      else
          this.acctobj = (Account)Controller.getRecord();
      Getnotes(type);
    }
    private void Getnotes(string type)
    {
        list<beBack__c> prospectnotes;
        if(type=='Lead')
            prospectnotes=[select notes__c,visit_date__c,name, is_be_back__c, Community_of_Interest__c,Community_of_Interest__r.marketing_community__r.Name,Owner.Name   from beback__c where  Community_of_Interest__c in
            (select id from interest_list__c where lead__c =: leadobj.Id) order by visit_date__c desc];
        else
            prospectnotes=[select notes__c,visit_date__c,name, is_be_back__c, opportunity__c,opportunity__r.marketing_community__r.Name,Owner.Name  from beback__c where  opportunity__c in
            (select id from opportunity where accountid =: acctobj.Id) order by visit_date__c desc];
        for(beback__c n: prospectnotes)
        {
            //system.debug(n.Community_of_Interest__r.marketing_community__r.Name);
            Date dt=n.Visit_date__c;
            string beback=': Is Be back';
            if(n.is_be_back__c==true)
                 
                 if(type=='Lead')
                    this.notes=this.notes+ dt.day() + '-'+ dt.Month() + '-' + dt.year() + beback +'</br>'  + 'Project: ' 
                    + n.Community_of_Interest__r.marketing_community__r.Name +'</br>'
                    + n.Owner.Name + ': ' + n.notes__c + '</p>';
                 else
                      this.notes=this.notes+ dt.day() + '-'+ dt.Month() + '-' + dt.year() + beback +'</br>' + 'Project: '
                    + n.opportunity__r.marketing_community__r.Name +'</br>'
                    + n.Owner.Name + ': ' + n.notes__c + '</p>';
                 
            else
                 
                 if(type=='Lead')
                    this.notes=this.notes+ dt.day() + '-'+ dt.Month() + '-' +dt.year() +'</br>' 
                    + 'Project: ' + n.Community_of_Interest__r.marketing_community__r.Name +'</br>'
                    + n.Owner.Name + ': ' + n.notes__c + '</p>';
                 else
                     this.notes=this.notes+ dt.day() + '-'+ dt.Month() + '-' +dt.year() +'</br>' 
                     + 'Project: ' + n.opportunity__r.marketing_community__r.Name +'</br>'
                     + n.Owner.Name + ': ' + n.notes__c + '</p>';
                 
           
        }

    }
}