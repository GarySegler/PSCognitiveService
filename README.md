[![Build status](https://ci.appveyor.com/api/projects/status/jgiom7ww0nhc5kt7?svg=true)](https://ci.appveyor.com/project/PrateekKumarSingh/pscognitiveservice)

# PowerShell Module for Microsoft Cognitive Services (aka, ProjectOxford)
<a href='https://www.microsoft.com/cognitive-services'>Microsoft Cognitive Services</a> are some machine learning Artificial intelligent REST API's to give Human-like cognition abilities to your applications.

# Pre-Requisites
You need to do one-time registration for each Microsoft Cognitive Services API from <a href="https://www.microsoft.com/cognitive-services/en-us/sign-up">HERE</a>, before start using the module, because it won’t work without an API Key.

## 1. Installation

### [PowerShell v5](https://www.microsoft.com/en-us/download/details.aspx?id=50395) and Later
You can install the `PSCognitiveService` module directly from the PowerShell Gallery

<img src=https://raw.githubusercontent.com/PrateekKumarSingh/PSCognitiveService/master/Media/Install.jpg width=100% height=90%>

* **[Recommended]** Install to your personal PowerShell Modules folder
```PowerShell
Install-Module PSCognitiveService -scope CurrentUser
```
* **[Requires Elevation]** Install for Everyone (computer PowerShell Modules folder)
```PowerShell
Install-Module PSCognitiveService
```
### PowerShell v4 and Earlier
To install to your personal modules folder run:
```PowerShell
iex (new-object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/PrateekKumarSingh/PSCognitiveService/master/Install.ps1')
```

## 2. Subscribe
Microsoft Cognitive services are offered and subscribed through the <a href ='https://portal.azure.com'>Azure Portal</a> to achieve that -

- **Create cognitive service accounts** in azure portal.
- **Obtain subscription keys** 
- **Set $Env variables** locally, which would consumed by the module cmdlets to make REST API call's.

Personally, going to azure portal and obtaining subscription keys is a turn down for me. 

But, ```New-CognitiveServiceAccount```cmdlet that is included in this module to create Azure cognitive service accounts/subscription from your console.

Example, if you want to use the ```Search-Web``` cmdlet that utlizes ```Bing Search``` capabilities, you need to subscribe to Cognitive Service account of type: ```Bing.Search.v7```, just run the below cmdlet.

```PowerShell
New-CognitiveServiceAccount -AccountType Bing.Search.v7

# alternatively, specify ResourceGroup, Location and SKU
New-CognitiveServiceAccount -AccountType ComputerVision -ResourceGroupName ResourceGroup1 -Location centralindia -SKUName S1
```

## 3. Configure Locally

Alright, you are now subscribed, but how to obtain the subscription key(s) and set-up ```$ENV``` variable(s) in the session to run these cmdlets. 

It is as simple as a below cmdlet and Kaboom! you are subscribed and local configuration is complete!

```PowerShell
New-LocalConfiguration -FromAzure -AddKeysToProfile -Verbose
```
**NOTE** - Please add the subscription keys to your ```$Profile``` using ```-AddKeysToProfile``` switch for future use and to avoid above configuration step.

<img src=https://raw.githubusercontent.com/PrateekKumarSingh/PSCognitiveService/master/Media/Subscribe.gif width=100% height=90%>



# Usage

This module provides a set of PowerShell cmdlets, which are PowerShell wrappers to query and access MS Cognitve service APIs and endpoints with ease and simplicity.

## Computer Vision

#### Get-ImageAnalysis
Analyze an image and returns visual features and other details

```PowerShell
$path = 'C:\temp\Picture.jpg'
# by default chooses all visual features and details in the image
Get-ImageAnalysis -path $path -Verbose

# selective visual features and details in the image
$visual_features = [enum]::GetNames([visualFeatures])
$details = [enum]::GetNames([details])
Get-ImageAnalysis -path $path -VisualFeatures $visual_features -Details $details

# using computer vision classes and functions
$url = "https://upload.wikimedia.org/wikipedia/commons/d/d9/Bill_gates_portrait.jpg"

# create computer vision object to expose [vision] class instances and method overload definitions
# outside the nested PowerShell module
$Object = New-CognitiveServiceInstance -Name Vision

# analyze image
$Object.analyze([uri]$url)
$Object.analyze([IO.FileInfo]$path)

# analyze image with visual features and details
$Object.analyze($url, $visual_features, $details)
$Object.analyze($path, $visual_features, $details)

# help information
Get-Help analyze
```

#### Get-ImageText
Optical character recognition to read and return text,orientation, language from an image

```PowerShell
# Optical character recognition using a URL
Get-ImageText -URL 'http://quotesnhumor.com/wp-content/uploads/2016/02/Top-25-Believe-Quotes-believe-images.jpg' -Verbose

# Optical character recognition using a path
ocr -Path C:\Temp\qoute.jpg -Verbose

# Optical character recognition using computer vision classes and functions
$path = 'C:\temp\qoute.jpg'
$url = "http://www.imagesquotes.com/wp-content/uploads/2013/01/inspirational_quotes_motivational.jpg"

# create computer vision object
$Object = New-CognitiveServiceInstance -Name Vision

# using the OCR(url) method
$Object.OCR([uri]$url)
$Object.result.regions.lines | foreach {$_.words.text -join ' '} # prints result line-wise

# using the OCR(path) method
$Object.OCR([IO.FileInfo]$path)
```

#### Get-ImageTag
Tags an image with the context of contents and visual features inside the image.

```PowerShell
# get image tags using a path that are relevant to the content of the supplied image
$Path = 'C:\temp\Bill.jpg'
ConvertTo-Thumbnail -Path $Path

# get image tags using a URL
$URL = 'https://drscdn.500px.org/photo/159533631/m%3D900/v2?webp=true&sig=61eee244d82e8eac7354bf31800c17a8d0627aba1d941f96f5a9e5e4910de693'
Get-ImageTag -URL $url -Verbose

# using alias
tag -URL $URL -Verbose
tag -URL $path -Verbose

# create computer vision object
$Object = New-CognitiveServiceInstance -Name Vision

# using the tag(url) method
$Object.tag([uri]$url)
$Object.result.tags.name | foreach {'#'+$_} # prints hashtags

# using the tag(path) method
$Object.tag([IO.FileInfo]$path)
```


#### ConvertTo-Thumbnail
Converts an image to a thumbnail with specified dimensions
```PowerShell
# convert to thumbnail using a path
$Path = 'C:\temp\Bill.jpg'
ConvertTo-Thumbnail -Path $Path

# convert to thumbnail using a URL
$URL = 'https://drscdn.500px.org/photo/159533631/m%3D900/v2?webp=true&sig=61eee244d82e8eac7354bf31800c17a8d0627aba1d941f96f5a9e5e4910de693'
ConvertTo-Thumbnail -URL $URL -Width 100 -Height 100 -Verbose -SmartCropping

# convert to thumbnail using a URL with specific dimensions
Thumbnail -URL $URL -OutFile c:\temp\t.png -Width 100 -Height 100 -Verbose
Thumbnail -URL $URL -OutFile c:\temp\t.png -Width 100 -Height 100 -Verbose -SmartCropping

# convert to thumbnail using computer vision classes and .toThumbnail() method
$Object = New-CognitiveServiceInstance -Name Vision

# using URL
$Object.toThumbnail([System.IO.FileInfo] $path, [System.IO.FileInfo] 'c:\temp\test.png', 200, 200, $true)

# using path
$Object.toThumbnail([System.Uri] $url, [System.IO.FileInfo] 'c:\temp\test.png', 200, 200, $true)
```

### Face

#### Get-Face
Identifies faces and attributes in an image.

```PowerShell
# detect face using a local image
$path = 'C:\temp\Bill.jpg'
Get-Face -Path $path -FaceId -FaceLandmarks 
Get-Face -Path $path -FaceId -FaceLandmarks -FaceAttributes age, gender |fl *

# detect face using [face] object and detect(path) method
$object = New-CognitiveServiceInstance -Name Face
$path = [System.IO.FileInfo] 'C:\temp\Bill.jpg'
$object.detect($path)
$object.result.facerectangle
$object.result.facelandmarks

# detect face using [face] object and detect(path, Face_Attributes, FaceID, FaceLandmarks) method
$object = New-CognitiveServiceInstance -Name Face
$path = [System.IO.FileInfo] 'C:\temp\Bill.jpg'
$Face_Attributes = [enum]::GetNames([FaceAttributes])
$object.detect($path, $Face_Attributes, $true, $true)
$object.result.faceattributes.facialHair

# detect face using a url
$Url = 'https://pbs.twimg.com/profile_images/963507920016216064/Ug29J5-J.jpg'
Get-Face -URL $url -FaceId -FaceLandmarks -Verbose
Get-Face -URL $url -FaceId -FaceLandmarks -FaceAttributes age, gender -Verbose |fl *

# detect face using [face] object and detect(url) method
$object = New-CognitiveServiceInstance -Name Face
$url = [uri] 'https://pbs.twimg.com/profile_images/963507920016216064/Ug29J5-J.jpg'
$object.detect($url)


# detect face using [face] object and detect(url, Face_Attributes, FaceID, FaceLandmarks) method
$object = New-CognitiveServiceInstance -Name Face
$url = [uri] 'https://pbs.twimg.com/profile_images/963507920016216064/Ug29J5-J.jpg'
$Face_Attributes = [enum]::GetNames([FaceAttributes])
$object.detect($url, $Face_Attributes, $true, $true)
$object.result.faceattributes
```

### Content Moderation
#### Test-AdultRacyContent
Adult and racy content verification

```PowerShell
# moderate content using [Moderate] object and processimage(path) method
$object = New-CognitiveServiceInstance -Name Moderate
$path = [System.IO.FileInfo] 'C:\temp\test.png'
$object.processimage($path)

Test-AdultRacyContent -Text "go eff yourself" -Verbose
Test-AdultRacyContent -Text "go eff yourself" -AutoCorrect -PersonalIdentifiableInformation -Verbose

# moderate content using [Moderate] object and processimage(path, cachesimage) method
$object = New-CognitiveServiceInstance -Name Moderate
$path = [System.IO.FileInfo] 'C:\temp\test.png'
$object.processimage($path, $true)
Test-AdultRacyContent -Path $Path -Verbose -CachesImage

# moderate content using [Moderate] object and processimage(url) method
$object = New-CognitiveServiceInstance -Name Moderate
$url = [uri] 'https://pbs.twimg.com/profile_images/963507920016216064/Ug29J5-J.jpg'
$object.processimage($url)

# moderate content using [Moderate] object and processimage(url, cachesimage) method
$object = New-CognitiveServiceInstance -Name Moderate
$url = [uri] 'https://pbs.twimg.com/profile_images/963507920016216064/Ug29J5-J.jpg'
$object.processimage($url, $true)
$object.processimage($url, $false)
Test-AdultRacyContent -URL $url -Verbose -CachesImage

# moderate content using [Moderate] object and processtext(text) method
$object = New-CognitiveServiceInstance -Name Moderate
$text = 'Holy shit! this is crap.'
$object.processtext($text)
$object.result.Classification

# moderate content using [Moderate] object and processtext(text, autocorrect, personalIdentifiableInfo, listId, classify, language) method
$object = New-CognitiveServiceInstance -Name Moderate
$text = 'Holy shit! this is crap.'
$object.processtext($text, $true, $true, '', 'eng')
$object.result.Status
```

