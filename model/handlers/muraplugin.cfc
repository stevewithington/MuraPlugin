/**
*
* This file is part of MuraPlugin
*
* Copyright 2013-2016 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.plugin.pluginGenericEventHandler' output=false {

	include '../../plugin/settings.cfm';

	public any function onApplicationLoad(required struct m) {
		// Register all event handlers/listeners of this .cfc with Mura CMS
		variables.pluginConfig.addEventHandler(this);
	}

	// Add any event handlers here

}
