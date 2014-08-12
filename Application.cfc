/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013-2014 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true output=false {

	property name='$';

	include 'plugin/settings.cfm';
	include '../../config/applicationSettings.cfm';
	include '../../config/mappings.cfm';
	include '../mappings.cfm';

	public any function onApplicationStart() {
		include '../../config/appcfc/onApplicationStart_include.cfm';
		var $ = get$();
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
		var pluginConfig = $.getPlugin(variables.settings.pluginName);
		include arguments.targetPage;
	}


	// ----------------------------------------------------------------------
	// HELPERS

	public struct function get$() {
		return IsDefined('session') && StructKeyExists(session, 'siteid') 
			? application.serviceFactory.getBean('$').init(session.siteid) 
			: application.serviceFactory.getBean('$').init('default');
	}

	public any function secureRequest() {
		var $ = get$();
		return !inPluginDirectory() || $.currentUser().isSuperUser() 
			? true 
			: ( inPluginDirectory() && !structKeyExists(session, 'siteid') ) 
				|| ( inPluginDirectory() && !$.getBean('permUtility').getModulePerm($.getPlugin(variables.settings.pluginName).getModuleID(),session.siteid) )
				? goToLogin() 
				: true;
	}

	public boolean function inPluginDirectory() {
		return ListFindNoCase(getPageContext().getRequest().getRequestURI(), 'plugins', '/');
	}

	private void function goToLogin() {
		var $ = get$();
		location(url='#$.globalConfig('context')#/admin/index.cfm?muraAction=clogin.main&returnURL=#$.globalConfig('context')#/plugins/#$.getPlugin(variables.settings.pluginName).getPackage()#/', addtoken=false);
	}

}