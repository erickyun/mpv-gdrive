# Google Drive video support for mpv

Put gdrive.lua in ~/.config/mpv/scripts/gdrive.lua  
Put gdrive.conf in ~/.config/mpv/script-opts/gdrive.conf

Now we have to fill in your gdrive accounts Client ID, Client Secret and Refresh Token for gdrive.conf 
to use this script



## Getting your Client ID and Secret

Log in to your Google Account and go to this website:

https://console.developers.google.com/


### Create Credentials

Create a new project using the dropdown at the top.

<img width="463" alt="Create a new project" src="https://cloud.githubusercontent.com/assets/3598622/22397261/060eac9e-e56e-11e6-907c-717932605569.png">

After you enter a name

Next Step

<img width="463" alt="Enable Gdrive" src="https://user-images.githubusercontent.com/71968711/153625344-2bd04e58-f220-4c44-a5e4-4078e78cff5f.jpg">

Now go to library and ENABLE "Google Drive Api"
 


  NEXT STEPS
  
Go to your developer console.
Go to OAuth consent screen.

<img width="328" alt="OAuth consent screen" src="https://user-images.githubusercontent.com/71968711/152443205-d3faa5b4-5078-49b3-9de9-c770f67561dd.jpg">

User Type "External" after click create

<img width="556" alt="User Type" src="https://user-images.githubusercontent.com/71968711/152443398-1e1c2162-d887-42ca-8c6f-f4d697269acf.png">

Fill required places "*" only 

<img width="556" alt="req" src="https://user-images.githubusercontent.com/71968711/152443524-b42c5099-45a5-43a2-b632-fd481cf31ba9.png">


in this step Don't worry about the other fields. Go to next step.

<img width="556" alt="req" src="https://user-images.githubusercontent.com/71968711/152443663-3fb1cf55-91df-455c-8cf9-b5793a817b1b.png">


Click on +Add users, under test users.
Add your gmail account

<img width="556" alt="acc" src="https://user-images.githubusercontent.com/71968711/152443786-c3bf9a85-d318-46ac-b7fd-e47e94f1aa12.png">

Save continue and Publish App
  
  
Go to "Credentials" 

<img width="246" alt="Consent Screen" src="https://user-images.githubusercontent.com/71968711/152441635-0e4ed524-7185-4716-a4b7-9b518ec1c908.jpg">

click the button that says "Create Credentials" and select "OAuth Client ID".

<img width="646" alt="Create Credentials" src="https://user-images.githubusercontent.com/71968711/152442150-4b557097-0eca-4198-9a25-dd7584e72794.png">

Next select application type "Desktop app" or "Web Application"

<img width="646" alt="web Application" src="https://user-images.githubusercontent.com/71968711/152442534-f3f2ab6f-ab46-474f-a43a-fa9bbe0328c6.png">



Add https://developers.google.com/oauthplayground in "Authorized redirect URIs". You will need to use this in the next step to get your refresh token. Once you have the token, you can remove the URI.

<img width="910" alt="Authorized redirect URIs" src="https://user-images.githubusercontent.com/71968711/152442752-7375e972-ad5b-4e89-8d67-4142e1a13b9a.png">



Click Create and take note of your **Client ID** and **Client Secret**.

<img width="910" alt="Create" src="https://user-images.githubusercontent.com/71968711/152442933-a0615444-6e63-454c-a57c-b96cb048dfa4.jpg">






##Next we will be getting your Refresh Token
---

Next: [Getting your Refresh Token](2-getting-your-refresh-token.md) | [Back to README](../README.md)



## Getting your Refresh Token

Go to https://developers.google.com/oauthplayground.

> Make sure you added this URL to your Authorized redirect URIs in the [previous step](1-getting-your-dlient-id-and-secret.md).

In the top right corner, click the settings icon, check "Use your own OAuth credentials" and paste your Client ID and Client Secret.

<img width="463" alt="Use your own OAuth credentials" src="https://cloud.githubusercontent.com/assets/3598622/22397216/24fe7d88-e56d-11e6-82cf-2d75365d8800.png">

In step 1 on the left, scroll to "Drive API v3", expand it and check the first drive scope.

<img width="488" alt="Check Scopes" src="https://user-images.githubusercontent.com/3598622/28462312-fa4397ea-6e1a-11e7-93ad-365b891052a6.png">

Click "Authorize APIs" and allow access to your account when prompted.
There will be a few warning prompts, just proceed.

When you get to step 2, check "Auto-refresh the token before it expires" and click "Exchange authorization code for tokens".

<img width="493" alt="Exchange authorization code for tokens" src="https://cloud.githubusercontent.com/assets/3598622/22397183/8472095c-e56c-11e6-85be-83adf00837c7.png">

When you get to step 3, click on step 2 again and you should see your **refresh token**.

<img width="487" alt="Refresh Token" src="https://cloud.githubusercontent.com/assets/3598622/22397176/2cef7a98-e56c-11e6-83b9-b4653850dbca.png">

---

[Back to README](../README.md)


Now You have have everything you need to use this script your done


Note: the refresh token does expire in a couple of days so when the script doesn't work you have to get ONLY the refresh token again (So you have to ONLY repeat the steps in [refresh token](https://github.com/erickyun/mpv-gdrive#getting-your-refresh-token) again no need for the other steps)


## Helper userscript

- Install a userscript extension for your browser (I use ViolentMonkey)
- Add script by URL:
  https://raw.githubusercontent.com/nhanb/mpv-gdrive/master/userscript/gdrive-id.js

Now when browsing Google Drive you should have something like this on the
bottom left:

![](https://user-images.githubusercontent.com/1446315/79535328-4c868700-80a7-11ea-9750-77175d2928c8.png)



