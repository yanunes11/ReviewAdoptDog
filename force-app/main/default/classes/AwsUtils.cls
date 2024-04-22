public with sharing class AwsUtils {
    // AwsUtils.AwsParameters authHeader = new AwsUtils.AwsParameters();
    // authHeader.bucketName = 'adoptdog-image';
    // authHeader.methodName = 'PUT';
    // authHeader.hostName = 's3.us-east-2.amazonaws.com';
    // AwsUtils service = new AwsUtils(authHeader);
    // service.uploadDocuments('a02bm000000QEyoAAG');

    public string bucketName;
    public string methodName;
    public string hostName; //end-point

    public class AwsParameters {
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
 
    // public void uploadDocuments(string recordId) {
    //     //Create ContentDocument and with the ContentDocument.Id put on CententVersion 
    //     List<ContentVersion> contentVersionList = [
    //         SELECT Id, ContentDocumentId, VersionData, Title, FileExtension, Record_Id__c, Object_Api_Name__c
    //         FROM ContentVersion
    //         WHERE Record_Id__c = :recordId AND IsLatest = TRUE
    //         WITH SYSTEM_MODE
    //         LIMIT 1
    //     ];
    //     for (ContentVersion attach : contentVersionList) {

    //         System.debug('YNASC - Attach: '+attach);

    //         string attachmentBody = EncodingUtil.base64Encode(attach.VersionData);
            
    //         string formattedDateString = Datetime.now().formatGmt('EEE, dd MM yyyy HH:mm:ss z');
    //         System.debug('YNASC - formattedDateString: '+formattedDateString);
    //         string fileName = attach.Title;
            
    //         string contentType = this.contentType(attach.FileExtension);
    //         System.debug('YNASC - contentType: '+contentType);
    //         // end point
    //         string fileURL = 'https://'+this.bucketName + '.' + this.hostName + '/' + fileName.toLowerCase() + '.' + attach.fileExtension.toLowerCase();
    //         System.debug('YNASC - fileURL: '+fileURL);

    //         HttpRequest req = new HttpRequest();
    //         req.setMethod(this.methodName);
    //         req.setEndpoint(fileURL);
    //         req.setHeader('Host', this.bucketName + '.' + this.hostName);
    //         req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
    //         req.setHeader('Content-Encoding', 'UTF-8');
    //         req.setHeader('Content-Type', contentType);
    //         req.setHeader('Connection', 'Keep-alive');
    //         req.setHeader('Date', formattedDateString);
    //         req.setHeader('ACL', 'public-read');
    //         Blob imgBlob = EncodingUtil.base64Decode(attachmentBody);
    //         req.setBodyAsBlob(imgBlob);

    //         AuthHeader authInfo = new AuthHeader();
    //         authInfo.contentType = contentType;
    //         authInfo.fileName = fileName;
    //         authInfo.formatedDateString = formattedDateString;
    //         authInfo.fileExtension = attach.FileExtension;

    //         req.setHeader('Authorization', this.createAuthHeader(authInfo));
    //         Http h = new Http();
    //         HttpResponse response = h.send(req);
    //         System.debug('YNASC response: '+response);
    //     }
    // }

    public void uploadDocuments(string recordId) {
        //Create ContentDocument and with the ContentDocument.Id put on CententVersion 
        List<ContentVersion> contentVersionList = [
            SELECT Id, ContentDocumentId, VersionData, Title, FileExtension, Record_Id__c, Object_Api_Name__c
            FROM ContentVersion
            WHERE Record_Id__c = :recordId AND IsLatest = TRUE
            WITH SYSTEM_MODE
            LIMIT 1
        ];
        for (ContentVersion attach : contentVersionList) {

            System.debug('YNASC - Attach: '+attach);

            string attachmentBody = EncodingUtil.base64Encode(attach.VersionData);
            
            string formattedDateString = Datetime.now().formatGmt('EEE, dd MM yyyy HH:mm:ss z');
            System.debug('YNASC - formattedDateString: '+formattedDateString);
            string fileName = attach.Title;
            
            string contentType = this.contentType(attach.FileExtension);
            System.debug('YNASC - contentType: '+contentType);
            // end point
            string fileURL = 'https://'+this.bucketName + '.' + this.hostName + '/' + fileName.toLowerCase() + '.' + attach.fileExtension.toLowerCase();
            System.debug('YNASC - fileURL: '+fileURL);

            HttpRequest req = new HttpRequest();
            req.setMethod(this.methodName);
            req.setEndpoint('callout:awsAdopt');
            req.setHeader('Host', this.bucketName + '.' + this.hostName);
            req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
            req.setHeader('Content-Encoding', 'UTF-8');
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

            // req.setHeader('Authorization', this.createAuthHeader(authInfo));
            Http h = new Http();
            HttpResponse response = h.send(req);
            System.debug('YNASC response: '+response);
        }
    }
}
