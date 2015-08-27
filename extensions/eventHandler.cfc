/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013-2015 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.plugin.pluginGenericEventHandler' output=false {

	include '../plugin/settings.cfm';

	public any function onApplicationLoad(required struct $) {
		// Register all event handlers/listeners of this .cfc with Mura CMS
		variables.pluginConfig.addEventHandler(this);

		// Makes any methods of the object accessible via application.yourPluginPackageName
		lock scope='application' type='exclusive' timeout=10 {
			application[variables.settings.package] = new displayObjects().init();
		}
	}

	public any function onSiteRequestStart(required struct $) {
		// Makes any methods of the object accessible via $.yourPluginPackageName
		var displayObjects = new displayObjects().init();
		arguments.$.setCustomMuraScopeKey(variables.settings.package, displayObjects);

		// if you want to inject your own custom methods into the contentRenderer, you
		// could easily do that as follows
		$.getContentRenderer().injectMethod('sayHello', displayObjects.sayHello);
		// you could could loop over a CFC as a structure and inject whatever you want
	}

	// This will create a new tab on all content types (Page,Folder,Link,File,Folder,Calendar,Gallery)
	// The tab label will be the plugin's packageName by default
	public any function onContentEdit(required struct $) {
		var local = {};
		local.$ = arguments.$;

		savecontent variable='local.str' {
			include 'includes/onContentEdit.cfm';
		}

		return local.str;
	}

	// This assumes you've created a Folder/Employees custom class extension
	// Examples have been commented out in the /MuraPlugin/plugin/config.xml.cfm file
	// The on{Type}{SubType}Edit() method won't work yet. A pull request was issued as of Mura v6.1.6014
	/*
	public any function onFolderEmployeesEdit(required struct $) {
		var local = {};
		local.$ = arguments.$;

		// example of how to define a custom label for your tab
		local.$.event('tabLabel', 'Employee Info');

		// check plugin permissions before rendering custom tab
		if ( local.$.getBean('permUtility').getModulePerm(local.$.getPlugin(variables.settings.pluginName).getModuleID(), local.$.event('siteid') ) ) {
			savecontent variable='local.str' {
				include 'includes/onFolderEmployeesEdit.cfm';
			}
		}

		return local.str;
	}
	*/

}