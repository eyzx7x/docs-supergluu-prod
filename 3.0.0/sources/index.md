# Super Gluu Documentation
Super Gluu is a secure two-factor authentication mobile application based on the free open source [oxPush3 code](https://github.com/GluuFederation/oxPush3). Super Gluu can be used to achieve multi-factor authentication to applications that use your free open source [Gluu Server](http://gluu.org/gluu-server) for login.

The Super Gluu documentation is organized into the following sections:

- [User Guide](./user-guide/index.md)
- [Admin Guide](./admin-guide/configure-oxtrust.md)
- [Developer Guide](./developer-guide/index.md)

## App Download & Pricing		
The Super Gluu mobile app can be downloaded for free from the [Android](https://play.google.com/store/apps/details?id=gluu.super.gluu) or [iOS](https://itunes.apple.com/us/app/super-gluu/id1093479646?ls=1&mt=8) marketplace. 		
 
 - By default the Super Gluu app includes ads.    		
		
 - Users can upgrade to Ad Free with an in-app purchase for $0.99 per month. If your organization needs Ad Free licenses for many users, [schedule a meeting](https://gluu.org/booking) with us to discuss.
 		
 - In addition, Super Gluu can be re-skinned, custom branded, and published to the app marketplaces for your organization by Gluu. 	
 		
 Learn more about our offerings on the pricing section of the [Super Gluu website](http://super.gluu.org/).  

## How it works

### Super Gluu Workflows
Super Gluu supports two workflows: 

- It can be used as a one-step authentication, where the person scans a QR code, and the Gluu Server looks up which person is associated with that phone. 

- It can also be used for a two step authentication, where the person logs into a website with username and password, and then receives an out of band push notification to the mobile device to authorize access.   

In both cases users are prompted to scan a QR code in order to register their device against their account in the Gluu Server. In the second workflow, where a username and password are required as a first step, the user will begin receiving push notifications for all authentications after the initial device registration process. 

### The Gluu Server
Super Gluu is tightly bundled with the Gluu Server identity and access management platform. The Gluu Server supports the SAML and OpenID Connect open web standards for configuring single sign-on across many applications. Using these standard protocols, you can send users from web and mobile apps to your Gluu Server to handle login, and use Super Gluu to enable strong authentication.  

[Read the docs](https://gluu.org/docs/ce) to learn more about launching a central authentication and authorization service using the Gluu Server. 

### FIDO U2F
The Gluu Server does more than look at the device ID to grant access. Super Gluu uses the FIDO U2F endpoints on the Gluu Server to enroll a public key. When authentication happens, there is a challenge response to ensure that the device has the respective private key.

## NSTIC Funding
Funding for this project was in part provided by an NSTIC pilot project in which Gluu participated. The base code is available on [Github]( https://github.com/GluuFederation/oxPush2). 
