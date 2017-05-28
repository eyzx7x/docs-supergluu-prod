#Configure oxTrust

## Overview

This section explain on how to configure OxTrust in Gluu CE to 
configure SuperGluu with Gluu CE Server.

1. Navigate to `Configuration` > `Manage Custom Scripts`.
2. Click on the `Person Authentication tab`: 
3. Select the ‘SuperGluu’ Script: 

    ![config](../img/admin-guide/oxtrust-config.png)
 
4. Enable the script by ticking the check box…
5. Ok
6. Change Authentication method should go to ‘Super Gluu’ - ‘Super Gluu’ ( So.. in both case ( SSO operation and oxTrust login ), Gluu Server will ask for SuperGluu 2FA authN. 

    ![config1](../img/admin-guide/oxtrust-config1.png)
 
7. How to register a new Device? 

    If you haven’t registered any device to your account; you can just complete this by scanning the QR code Gluu Server presentated to you at 2nd factor authentication level. 
    
    Download and install SuperGluu app from app store in your device. 
    Perform authentication in Gluu Server. 
    In second phase, you will see a QR code like below, just scan it with your device. Your device will be enrolled automatically with your account. 

    ![supergluuQR](../img/admin-guide/supergluuQR.png)
 
8. What if someone lost his/her device? 

They need to inform system administrator or manager of Gluu Server who will do next: 
    
   8.1 Find out the ‘DN’ of this user from ldap. 
    
   8.2 Find out the oxID ‘DN’ associated with #8.1 
    
   8.3 Remote 8.2 DN. 

To give you an example… 

Say user ‘abc’ lost his device and want to enroll new device for this two factor authentication purpose. Mr. Gluu Server admin will: 

(a) Get the DN of user ‘abc’ which will be something like this… `dn: inum=@!ABCD.1234.XXX.XXX.YYYY.8770,ou=people,o=@!DEFG.5678.XXX.XXX.ZZZ,o=gluu”`
 
(b) Now find out the ‘oxID’ DN which is associated with this user’s DN. Might be something like this: 


```
dn: oxId=1487683146561,ou=fido,inum=@!ABCD.1234.XXX.XXX.YYYY.8770,ou=people,o=@!DEFG.5678.XXX.XXX.ZZZ,o=gluu
objectClass: oxDeviceRegistration
objectClass: top
oxDeviceData: {"uuid":"b82abc-a1b2-3abc-bcccc-2222222222222","type":"normal","platform":"android","name":"zico","os_name":"kitkat","os_version":"4.4.4","push_token":"dddddddddd:aaaaaa_58_cccccc_4t_bbbbbbbbbbbbb_aaaaaaaaaaaaaa_ggggggggg"}
oxDeviceKeyHandle: fyyyyyyyyyyyyy_jaaaaaaaaaaaa_mKJw
oxStatus: active
oxApplication: https://test.gluu.org/identity/authentication/authcode
oxCounter: 2
creationDate: 20170221131906.559Z
oxId: 11111111111111111
oxDeviceRegistrationConf: {"publicKey":"BIGbwF…………….","attestationCert":"MIICJjCCAcygAwIBAgKBgQDzLA-......L5ztE"}
oxLastAccessTime: 20170
```

(c ) Delete this oxID DN. 

Old device is gone. Now user can enroll new device. 
 

