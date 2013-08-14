/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013 Stephen J. Withington, Jr.
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
		set$(arguments.$);
	}

	public any function onSiteRequestStart(required struct $) {
		// Makes any methods of the object accessible via $.yourPluginPackageName
		var contentRenderer = new contentRenderer(arguments.$);
		arguments.$.setCustomMuraScopeKey(variables.settings.package, contentRenderer);
		set$(arguments.$);
	}

}