/*
 * Constellation SFDC Integration API
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * OpenAPI spec version: v1
 * 
 *
 * NOTE: This class is auto generated by the OAS code generator program.
 * https://github.com/OAS-api/OAS-codegen.git
 * Do not edit the class manually.
 */

public class NewstarQuoteApi {
    NewstarClient client;

    public NewstarQuoteApi(NewstarClient client) {
        this.client = client;
    }

    public NewstarQuoteApi() {
        this.client = new NewstarClient();
    }

    public NewstarClient getClient() {
        return this.client;
    }

    /**
     * Resets a previously created NEWSTAR Sales quote-type selection.
     * 
     * @param quoteId Unique ID of the quote in NEWSTAR Sales. (optional)
     * @return NewstarOperationResult
     * @throws OAS.ApiException if fails to make API call
     */
    public NewstarOperationResult callDelete(Map<String, Object> params) {
        List<OAS.Param> query = new List<OAS.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('quoteId', (Integer) params.get('quoteId')));

        List<OAS.Param> form = new List<OAS.Param>();

        return (NewstarOperationResult) client.invoke(
            'DELETE', '/api/Quote', '',
            query, form,
            new Map<String, Object>(),
            new Map<String, Object>(),
            new List<String>{ 'text/plain', 'application/json', 'text/json' },
            new List<String>(),
            new List<String>(),
            NewstarOperationResult.class
        );
    }
    /**
     * Creates a NEWSTAR Sales quote-type selection for the specified customer, subdivision, lot and model combination.
     * 
     * @param newstarQuote Quote object. (optional)
     * @return NewstarQuote
     * @throws OAS.ApiException if fails to make API call
     */
    public NewstarQuote post(Map<String, Object> params) {
        List<OAS.Param> query = new List<OAS.Param>();
        List<OAS.Param> form = new List<OAS.Param>();

        return (NewstarQuote) client.invoke(
            'POST', '/api/Quote',
            (NewstarQuote) params.get('newstarQuote'),
            query, form,
            new Map<String, Object>(),
            new Map<String, Object>(),
            new List<String>{ 'text/plain', 'application/json', 'text/json' },
            new List<String>{ 'application/json-patch+json', 'application/json', 'text/json', 'application/_*+json' },
            new List<String>(),
            NewstarQuote.class
        );
    }
}