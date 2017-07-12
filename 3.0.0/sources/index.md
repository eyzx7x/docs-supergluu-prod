# Super Gluu Documentation
Super Gluu is a secure authentication mobile application based on the free open source [oxPush3 code](https://github.com/GluuFederation/oxPush3). 

Super Gluu is tightly bundled with the [Gluu Server](https://gluu.org/gluu-server), a free open source identity and access management platform, and can be used to achieve strong authentication to applications that leverage the Gluu Server for user login.

The Super Gluu documentation is organized into the following sections:

- [User Guide](./user-guide/index.md)
- [Admin Guide](./admin-guide/index.md)
- [Developer Guide](./developer-guide/index.md)

## Security
During a Super Gluu authentication the Gluu Server does more than look at the device ID to grant access. Super Gluu uses the FIDO U2F endpoints on the Gluu Server to enroll a public key. The private key is stored on the device. When authentication happens, there is a challenge response to ensure that the device has the respective private key. 

## How to Use Super Gluu 
In order to use Super Gluu you **must** have a Gluu Server. If you do not already have a Gluu Server, you can follow the [installation guide](https://gluu.org/docs/ce/installation-guide/) in our documentation. Once you have a Gluu Server installed you can follow the Super Gluu [admin guide](https://gluu.org/docs/supergluu/admin-guide/) to configure and begin using Super Gluu for strong authentication to applications. 

### Workflows
Super Gluu supports two workflows: 

- It can be used as a one-step authentication, where the person scans a QR code, and the Gluu Server looks up which person is associated with that phone. 

- It can also be used for a two step authentication, where the person logs into a website with username and password, and then receives an out of band push notification to the mobile device to authorize access.   

In both cases users are prompted to scan a QR code in order to register their device against their account in the Gluu Server. In the second workflow, where a username and password are required as a first step, the user will begin receiving push notifications for all authentications after the initial device registration process. 

## Download Super Gluu		
The Super Gluu mobile app can be downloaded for free!

 - [Download the Android app](https://play.google.com/store/apps/details?id=gluu.super.gluu)

 - [Download the iOS app](https://itunes.apple.com/us/app/super-gluu/id1093479646?ls=1&mt=8)

## Business Model 		
 
 - By default Super Gluu includes advertisements.    		
		
 - Users can upgrade to Ad Free with an in-app purchase for $0.99 per month. If your organization needs to purchase Ad Free licenses for many users, please [schedule a meeting](https://gluu.org/booking) with us to discuss bulk pricing.
 		
 - In addition, Super Gluu can be re-skinned, custom branded, and published to the app marketplaces for your organization by Gluu, or even integrated with one of your organization's existing mobile application. 	
 		
 Learn more about our offerings on the pricing section of the [Super Gluu website](http://super.gluu.org/).  

## NSTIC Funding
Funding for this project was in part provided by an [NSTIC pilot](https://www.nist.gov/itl/tig/pilot-projects#MorphoTrust_USA) project in which Gluu participated. The base code is available on [Github]( https://github.com/GluuFederation/oxPush2). 
