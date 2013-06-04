/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true output=false {

	property name='$';
	property name='pluginConfig';

	this.pluginName = 'MuraPlugin';

	include '../../config/applicationSettings.cfm';
	include '../../config/mappings.cfm';
	include '../mappings.cfm';

	public any function onApplicationStart() {
		include '../../config/appcfc/onApplicationStart_include.cfm';
		var $ = get$();
		setPluginConfig($.getPlugin(this.pluginName));
		return true;
	}

	public any function onRequestStart(required string targetPage) {
		var $ = get$();
		include '../../config/appcfc/onRequestStart_include.cfm';

		if ( StructKeyExists(url, $.globalConfig('appreloadkey')) ) {
			onApplicationStart();
		}

		// You may want to change the methods being used to secure the request
		secureRequest();
		return true;
	}

	public void function onRequest(required string targetPage) {
		var $ = get$();
		var pluginConfig = getPluginConfig();
		include arguments.targetPage;
	}


	// ----------------------------------------------------------------------
	// HELPERS

	public struct function get$() {
		return IsDefined('session') && StructKeyExists(session, 'siteid') ?
				application.serviceFactory.getBean('$').init(session.siteid) :
				application.serviceFactory.getBean('$').init('default');
	}

	private void function setPluginConfig(struct pluginConfig={}) {
		variables.pluginConfig = arguments.pluginConfig;
	}

	public any function secureRequest() {
		var $ = get$();
		if ( !allowedAccess() ) {
			location(url='#$.globalConfig('context')#/admin/index.cfm?muraAction=clogin.main&returnURL=/plugins/#this.pluginName#/', addtoken=false);
		}
	}

	public any function allowedAccess() {
		// You could also check the user's group with $.currentUser().isInGroup('Some Group Name')
		var $ = get$();
		return $.currentUser().isSuperUser() && inPluginDirectory() ? true : false;
	}

	public boolean function inPluginDirectory() {
		return ListFindNoCase(getPageContext().getRequest().getRequestURI(), 'plugins', '/');
	}

}