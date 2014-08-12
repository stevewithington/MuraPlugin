/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013-2014 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.plugin.pluginGenericEventHandler' output=false {

	property name='$' hint='mura scope';

	include '../plugin/settings.cfm';

	public any function onApplicationLoad(required struct $) {
		// Register all event handlers/listeners of this .cfc with Mura CMS
		variables.pluginConfig.addEventHandler(this);

		// Makes any methods of the object accessible via application.yourPluginPackageName
		lock scope='application' type='exclusive' timeout=10 {
			application[variables.settings.package] = new contentRenderer(arguments.$);
		}

		set$(arguments.$);
	}

	public any function onSiteRequestStart(required struct $) {
		// Makes any methods of the object accessible via $.yourPluginPackageName
		var contentRenderer = new contentRenderer(arguments.$);
		arguments.$.setCustomMuraScopeKey(variables.settings.package, contentRenderer);
		set$(arguments.$);
	}

	// This will create a new tab on all content types (Page,Folder,Link,File,Folder,Calendar,Gallery)
	// The tab label will be the plugin's packageName by default
	public any function onContentEdit(required struct $) {
		var local = {};
		local.$ = arguments.$;
		set$(arguments.$);

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
		set$(arguments.$);

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