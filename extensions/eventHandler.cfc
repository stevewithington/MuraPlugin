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

	public any function onApplicationLoad(required struct $) {
		variables.pluginConfig.addEventHandler(this);
		set$(arguments.$);
	}

	public any function onSiteRequestStart(required struct $) {
		var contentRenderer = new contentRenderer(arguments.$);
		arguments.$.setCustomMuraScopeKey('MuraPlugin', contentRenderer);
		set$(arguments.$);
	}

}