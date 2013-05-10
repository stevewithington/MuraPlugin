#MuraBanners TM

MuraBanners enables you to have a specific banner for each page of the site. If no banner is selected for a specific page, then this plugin begins checking each parent on up to the Home Page looking for one to use, unless you explicitly set Use Parent Banner to No, or its parent doesn't have a banner and is set to No. You can even specify the width and height of the banner.

##Content Editors/Authors

Simply go to the Extended Attributes tab, then upload a banner image (.jpg, .jpeg, .gif, .png). If your layout template doesn't already contain the code for the banner to display, you can use [mura] tags to do so inline with your content via the Content Editor.

###Example:

```html
[mura]$.muraBanners.dspBanner()[/mura]
```

The banner may also be assigned to a display region as a configurable content display object. Go to Layouts & Objects > Select 'Plugins' from the 'Available Content Objects' select menu > Select 'MuraBanners' from the list of plugins > Select 'MuraBanner' and assign it to your desired display region. When the 'MuraBanner' configurator appears, select your desired 'Banner Size' from the list of options and click 'Save' then Publish your page.

##Developers & Designers

You can easily drop the following code into any layout template (e.g., header.cfm) and be done:

###Example:
```cfml
#$.muraBanners.dspBanner(width=yourDesiredWidth, height=yourDesiredHeight)#
```

###Mura 6.0 Example
As of Mura 6.0, you can now create custom image sizes via Site Config > Edit Site > Images tab. This enables you to select your own crop region of the banner image! Simply pass in the size attribute with your custom image name.
```cfml
#$.muraBanners.dspBanner(size='mybannerimage')#
```


##Tested With
* Mura CMS Core Version 6.0+
* Adobe ColdFusion 10.0.4
* Railo 4.0.2

### Should Also Work On
* Mura CMS Core Version 5.6.4859
* Adobe ColdFusion 9.0.1
* Railo 3.3.1


##License
Copyright 2012 Stephen J. Withington, Jr.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.