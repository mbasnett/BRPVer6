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

public class NewstarHomeInfoApi {
    NewstarClient client;

    public NewstarHomeInfoApi(NewstarClient client) {
        this.client = client;
    }

    public NewstarHomeInfoApi() {
        this.client = new NewstarClient();
    }

    public NewstarClient getClient() {
        return this.client;
    }

    /**
     * Returns a list of home info objects for a specific subdivision.
     * 
     * @param subdivisionId ID of the subdivision to obtain the home info object list for. (optional)
     * @return NewstarPagedResultHomeInfo
     * @throws OAS.ApiException if fails to make API call
     */
    public NewstarPagedResultHomeInfo get(Map<String, Object> params) {
        List<OAS.Param> query = new List<OAS.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('subdivisionId', (Integer) params.get('subdivisionId')));

        List<OAS.Param> form = new List<OAS.Param>();

        return (NewstarPagedResultHomeInfo) client.invoke(
            'GET', '/api/HomeInfo', '',
            query, form,
            new Map<String, Object>(),
            new Map<String, Object>(),
            new List<String>{ 'text/plain', 'application/json', 'text/json' },
            new List<String>(),
            new List<String>(),
            NewstarPagedResultHomeInfo.class
        );
    }
}