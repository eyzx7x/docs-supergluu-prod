# Super Gluu Documentation
Super Gluu is a secure two-factor authentication mobile application. It is based on the free open source [oxPush2 code](https://github.com/GluuFederation/oxPush2).

- [User Guide](./user-guide/index.md)
- [Admin Guide](./admin-guide/configure-oxtrust.md)
- [Developer Guide](./developer-guide/index.md)

Super Gluu can be used to achieve multi-factor authentication to applications that use a [Gluu Server](http://gluu.org/gluu-server) for login.

### App Download & Pricing		
The Super Gluu mobile app can be downloaded for free from the [Android](https://play.google.com/store/apps/details?id=gluu.super.gluu) or [iOS](https://itunes.apple.com/us/app/super-gluu/id1093479646?ls=1&mt=8) marketplace. 		
 
 - The free version of Super Gluu includes ads.    		
		
 - An ad free version of the app can be purchased by users individually for $0.99 per month, or in bulk by an organization (discounts available when licenses are purchased in bulk).     		
 		
 - In addition, Super Gluu can be re-skinned, custom branded, and published to the app marketplaces for your organization by Gluu. 		
 		
 Learn more about our offerings on the pricing section of the [Super Gluu website](http://super.gluu.org/).  

## How it works
Super Gluu supports two workflows. It can be used as a one-step authentication to a website, where the person scans a QR code, and the Gluu Server looks up which person is associated with that phone. It can also be used for a two step authentication, where the person logs into a website with username and password, and then the person receives an out of band push notification to the mobile device to authorize access.

## FIDO U2F
The Gluu Server does more than look at the device ID to grant access. This application uses the FIDO U2F endpoints on the Gluu Server to enroll a public key. When authentication happens, there is a challenge response to ensure that the device has the respective private key.

## NSTIC Funding
Funding for this project was provided as part of a NSTIC pilot. The base code is available on [Github]( https://github.com/GluuFederation/oxPush2). This means that if you want to brand the application with your own logo, and make it available on the App Store, you are welcome to do so.

## Gluu Server IAM Platform
The best and easiest way to use Super Gluu is in conjunction with the Gluu Server. 

The Gluu Server is an identity and access management platform that implements open standards such as SAML, OpenID Connect, UMA, FIDO and SCIM to enable single sign-on, strong authentication, and identity and access management. 

You can point many applications at the Gluu Server to handle user authentication. The Gluu Server ships with out-of-the-box support for Super Gluu. Follow the [admin guide](./admin-guide/index.md) to learn how to enable Super Gluu authentication in your Gluu Server. Once enabled, users will need to pass Super Gluu two-factor authentication in order to access any resources protected by the Gluu Server. 

There are free open source distributions of the Gluu Server available for several linux distributions, including Centos, Ubuntu and Red Hat. Gluu offers free and commercial support for the Gluu Server. Visit our [pricing page](http://gluu.org/pricing) to learn more. 
