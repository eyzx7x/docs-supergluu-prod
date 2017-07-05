# Developer Guide

## Overview
Super Gluu is two-factor authentication mobile application for iOS and Android. Super Gluu can be used as a strong authentication mechanism to access resources that are protected by Gluu's free open source central authentication server, called the [Gluu Server](https://gluu.org/gluu-server). The below documentation describes what is happening during user enrollment and authentication. 

!!! Note
    Super Gluu is based on the free open source [oxPush3 project](https://github.com/GluuFederation/oxPush3). 

## QR Code
During enroll/authentication, app does few steps:
  
  1) Scan QR code
  
  Each QR code contains data - app, state, issuer, created, for example:
  
      {
      "app" : "https://example.gluu.org",
       "state" : "dek4nwk6-dk56-sr43-4frt-4jfi30fltimd"
       "issuer" : "https://example.gluu.org"
       "created" : "2016-06-12T12:00:01.874000"
      }
  
  2) Data from QR code is tranformated to Fido U2F metadata:
  
      String discoveryUrl = oxPush2Request.getIssuer();
      discoveryUrl += "/.well-known/fido-u2f-configuration";
      final String discoveryJson = CommunicationService.get(discoveryUrl, null);
      final U2fMetaData u2fMetaData = new Gson().fromJson(discoveryJson, U2fMetaData.class);
  
  This metadata should be sent to server:
  
      // need to check what we need to do enroll or authentication
      final List<byte[]> keyHandles = dataStore.getKeyHandlesByIssuerAndAppId(oxPush2Request.getIssuer(),
      oxPush2Request.getApp());
      final boolean isEnroll = (keyHandles.size() == 0) || StringUtils.equals(oxPush2Request.getMethod(), "enroll");
      final String u2fEndpoint;
      if (isEnroll) 
        u2fEndpoint = u2fMetaData.getRegistrationEndpoint();// if enroll then get registration endpoint
      } else {
        u2fEndpoint = u2fMetaData.getAuthenticationEndpoint();// if authentication then get corresponding endpoint
      }
      
      validChallengeJsonResponse = CommunicationService.get(u2fEndpoint, parameters);
    
  
  After we get a result from server we can manage next step - do enroll or authentication:
  
        if (isEnroll) {
            tokenResponse = oxPush2RequestListener.onEnroll(challengeJson, oxPush2Request, isDeny);
        } else {
            tokenResponse = oxPush2RequestListener.onSign(challengeJson, u2fMetaData.getIssuer(), isDeny);
        }
        
## Enroll process
  
If you scan QR-code for the first time and your device UDID isn't attached to your user id then app will do enroll, first need to prepare data properties:
  
        String version = request.getString(JSON_PROPERTY_VERSION);
        String appParam = request.getString(JSON_PROPERTY_APP_ID);
        String challenge = request.getString(JSON_PROPERTY_SERVER_CHALLENGE);
        String origin = oxPush2Request.getIssuer();

        EnrollmentResponse enrollmentResponse = u2fKey.register(new EnrollmentRequest(version, appParam, challenge, oxPush2Request));
        
  
During registeration app generates an unique keyHandle, keyPair (public/private keys) to sign all data and uses ECC algoritm to encode the required data.
  
        TokenEntry tokenEntry = new TokenEntry(keyPairGenerator.keyPairToJson(keyPair), enrollmentRequest.getApplication(), enrollmentRequest.getOxPush2Request().getIssuer());
        .
        .
        .
        dataStore.storeTokenEntry(keyHandle, tokenEntry);
        byte[] userPublicKey = keyPairGenerator.encodePublicKey(keyPair.getPublic());

        byte[] applicationSha256 = DigestUtils.sha256(application);
        byte[] challengeSha256 = DigestUtils.sha256(challenge);
        byte[] signedData = rawMessageCodec.encodeRegistrationSignedBytes(applicationSha256, challengeSha256, keyHandle, userPublicKey);
        byte[] signature = keyPairGenerator.sign(signedData, certificatePrivateKey);
        return new EnrollmentResponse(userPublicKey, keyHandle, vendorCertificate, signature);

Now we need make all information in one byte array. Also need to set one aditional parameter which determines if we decide to approve or deny our request:
  
        JSONObject clientData = new JSONObject();
        if (isDeny){
            clientData.put(JSON_PROPERTY_REQUEST_TYPE, REGISTER_CANCEL_TYPE);//Deny
        } else {
            clientData.put(JSON_PROPERTY_REQUEST_TYPE, REQUEST_TYPE_REGISTER);//Approve
        }
        clientData.put(JSON_PROPERTY_SERVER_CHALLENGE, challenge);
        clientData.put(JSON_PROPERTY_SERVER_ORIGIN, origin);

        String clientDataString = clientData.toString();
        byte[] resp = rawMessageCodec.encodeRegisterResponse(enrollmentResponse);
        
        JSONObject response = new JSONObject();
        response.put("registrationData", Utils.base64UrlEncode(resp));
        response.put("clientData", Utils.base64UrlEncode(clientDataString.getBytes(Charset.forName("ASCII"))));
        response.put("deviceData", Utils.base64UrlEncode(deviceDataString.getBytes(Charset.forName("ASCII"))));

        TokenResponse tokenResponse = new TokenResponse();
        tokenResponse.setResponse(response.toString());
        tokenResponse.setChallenge(new String(challenge));
        tokenResponse.setKeyHandle(new String(enrollmentResponse.getKeyHandle()));

        return tokenResponse;

For authentication no need to make extra data, all information is associated with your device UDID and each time gets the data from data store:
  
        TokenEntry tokenEntry = dataStore.getTokenEntry(keyHandle);
        String keyPairJson = tokenEntry.getKeyPair();
        keyPair = keyPairGenerator.keyPairFromJson(keyPairJson);
        int counter = dataStore.incrementCounter(keyHandle);
        byte userPresence = userPresenceVerifier.verifyUserPresence();
        byte[] applicationSha256 = DigestUtils.sha256(application);
        byte[] challengeSha256 = DigestUtils.sha256(challenge);
        byte[] signedData = rawMessageCodec.encodeAuthenticateSignedBytes(applicationSha256, userPresence, counter, challengeSha256);
        return new AuthenticateResponse(userPresence, counter, signature);

Methods onEnroll and onSign are preparing parameters and data before call to server. For more information about this two methods you can get it from Git repo [super gluu](https://github.com/GluuFederation/super-gluu.)
  
Now when we have final data we can do last call to server:
  
        final Map<String, String> parameters = new HashMap<String, String>();
        parameters.put("username", oxPush2Request.getUserName());
        parameters.put("tokenResponse", tokenResponse.getResponse());
        
        final String resultJsonResponse = CommunicationService.post(u2fEndpoint, parameters);
  
String resultJsonResponse contains result JSON. From result JSON we can extract some additional information. Also we can check if enroll/authentication was success or not using this filed - u2fOperationResult.getStatus().
  
        // Collect output information
        LogInfo log = new LogInfo();
        log.setIssuer(oxPush2Request.getIssuer());
        log.setUserName(oxPush2Request.getUserName());
        log.setLocationIP(oxPush2Request.getLocationIP());
        log.setLocationAddress(oxPush2Request.getLocationCity());
        log.setCreatedDate(String.valueOf(System.currentTimeMillis()));//oxPush2Request.getCreated());
        log.setMethod(oxPush2Request.getMethod());

