public with sharing class AwsUtils {
    public string awsKey;
    public string awsSecret;
    public string bucketName;
    public string methodName;
    public string hostName; //end-point

    public class AwsParameters {
        public string awsKey {get; set;}
        public string awsSecret {get; set;}
        public string bucketName {get; set;}
        public string methodName {get; set;}
        public string hostName {get; set;} //end-point
    }

    public class AuthHeader {
        public string contentType {get; set;}
        public string fileName {get; set;}
        public string formatedDateString {get; set;}
        public string fileExtension {get; set;}
    }
     
    // Initialize auth params in constructor
    public AwsUtils(AwsParameters awsParameters) {
        this.awsKey = awsParameters.awsKey;
        this.awsSecret = awsParameters.awsSecret;
        this.bucketName = awsParameters.bucketName;
        this.methodName = awsParameters.methodName;
        this.hostName = awsParameters.hostName;
    }

    public string contentType(string fileType) {
        switch on fileType.toLowerCase() {
            when 'csv' {
                return 'application/vnd.ms-excel';
            }
            when 'png' {
                return 'image/png';
            }
            when else {
                return 'image/jpeg';
            }
        }
    }

    public string createAuthHeader(AuthHeader authInfo) {
        string auth;
        string stringToSign = this.methodName + '\n\n' + authInfo.contentType + '\n' + authInfo.formatedDateString + '\n/' + this.bucketName + '/' + authInfo.fileName.toLowerCase() + '.' + authInfo.fileExtension.toLowerCase();
        Blob mac = Crypto.generateMac('HMACSHA1', Blob.valueOf(stringToSign), Blob.valueOf(this.awsSecret));
        string sign = EncodingUtil.base64Encode(mac);
        auth = 'AWS'+ ' ' + this.awsKey + ':' + sign;
        return auth;
    }
 
    public void uploadDocuments(string recordId) {
        //Create ContentDocument and with the ContentDocument.Id put on CententVersion 
        List<ContentVersion> contentVersionList = [
            SELECT Id, ContentDocumentId, VersionData, Title, FileExtension, Record_Id__c, Object_Api_Name__c
            FROM ContentVersion
            WHERE Record_Id__c = :recordId AND IsLatest = TRUE
            WITH SYSTEM_MODE
        ];
        for (ContentVersion attach : contentVersionList) {
            string attachmentBody = EncodingUtil.base64Encode(attach.VersionData);
            string formattedDateString = Datetime.now().formatGmt('EEE, dd MM yyyy HH:mm:ss z');
            string fileName = attach.Title;
            string contentType = this.contentType(attach.FileExtension);
            // end point
            string fileURL = 'https://'+this.bucketName + '.' + this.hostName + '/' + fileName.toLowerCase() + '.' + attach.fileExtension.toLowerCase();
            HttpRequest req = new HttpRequest();
            req.setMethod(this.methodName);
            req.setEndpoint(fileURL);
            req.setHeader('Host', this.bucketName + '.' + this.hostName);
            req.setHeader('Content-Lenght', String.valueOf(attachmentBody.length()));
            req.setHeader('Content-Enconding', 'UTF-8');
            req.setHeader('Content-Type', contentType);
            req.setHeader('Connection', 'Keep-alive');
            req.setHeader('Date', formattedDateString);
            req.setHeader('ACL', 'public-read');
            Blob imgBlob = EncodingUtil.base64Decode(attachmentBody);
            req.setBodyAsBlob(imgBlob);
            AuthHeader authInfo = new AuthHeader();
            authInfo.contentType = contentType;
            authInfo.fileName = fileName;
            authInfo.formatedDateString = formattedDateString;
            authInfo.fileExtension = attach.FileExtension;
            req.setHeader('Authorization', this.createAuthHeader(authInfo));
            Http h = new Http();
            HttpResponse response = h.send(req);
            System.debug('YNASC response: '+response);
        }
    }
}
