Public with sharing class BrookfieldMetaDataAccessor
{
    public BrookfieldMetaDataAccessor()
    {
      
    }
    public string GetFieldId(string ObjName,string fieldName)
    {
        string ObjId=GetObjectId(ObjName); 
        //string querystring='select+id+from+CustomField+where+TableEnumOrId=\''+ObjId+'\'' + '+and+DeveloperName=\''+fieldName+'\'';
        string querystring='SELECT+DurableId+from+FieldDefinition+WHERE+EntityDefinitionId=\''+ObjId+'\'' + '+and+DeveloperName=\''+fieldName+'\'';
        string fieldId='';
        JSONParser parser = JSON.createParser(PostAndGetRequest(querystring, '/services/data/v38.0/tooling/query/?q=')); 
        while (parser.nextToken() != null) 
        { 
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&  (parser.getText() == 'DurableId'))
                 { 
                    parser.nextToken(); 
                    fieldId= parser.getText().replace(ObjId+'.',''); 
                 } 
       
        }


        return fieldId;

    }
  public string GetObjectId(string ObjectName)
    {
        //string querystring='select+id+from+CustomObject+where+DeveloperName=\''+ObjectName+'\'';
        string querystring='SELECT+DurableId+from+EntityDefinition+WHERE+developerName=\''+ObjectName+'\'';
        string ObjId='';
        JSONParser parser = JSON.createParser(PostAndGetRequest(querystring,'/services/data/v38.0/tooling/query/?q=')); 
        while (parser.nextToken() != null) 
        { 
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&  (parser.getText() == 'DurableId'))
                 { 
                    parser.nextToken(); 
                    If (parser.getText()!=ObjectName)
                        ObjId= parser.getText(); 
                 } 
       
        }

        return ObjId; 
        
    }
  public string PostAndGetRequest(string Querystring, string APIPath )
  {
  
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+ APIPath  + Querystring );
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        system.Debug(res.getBody());
        return res.getBody();


  }
  }