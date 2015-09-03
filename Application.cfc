/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013-2015 Stephen J. Withington, Jr.
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
		return true;
	}

	public any function onRequestStart(required string targetPage) {
		include '../../config/appcfc/onRequestStart_include.cfm';

		if ( isRequestExpired() ) {
			onApplicationStart();
			lock scope='session' type='exclusive' timeout=10 {
				setupSession();
			}
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

	public void function onSessionStart() {
		include '../../config/appcfc/onSessionStart_include.cfm';
		setupSession();
	}

	public void function onSessionEnd() {
		include '../../config/appcfc/onSessionEnd_include.cfm';
	}


	// ----------------------------------------------------------------------
	// HELPERS

	private struct function get$() {
		if ( !StructKeyExists(arguments, '$') ) {
			var siteid = StructKeyExists(session, 'siteid') ? session.siteid : 'default';

			arguments.$ = StructKeyExists(request, 'murascope')
				? request.murascope
				: StructKeyExists(application, 'serviceFactory')
					? application.serviceFactory.getBean('$').init(siteid)
					: {};
		}

		return arguments.$;
	}

	public any function secureRequest() {
		var $ = get$();
		return !inPluginDirectory() || $.currentUser().isSuperUser() 
			? true 
			: ( inPluginDirectory() && !StructKeyExists(session, 'siteid') ) 
				|| ( inPluginDirectory() && !$.getBean('permUtility').getModulePerm($.getPlugin(variables.settings.pluginName).getModuleID(),session.siteid) )
				? goToLogin() 
				: true;
	}

	public boolean function inPluginDirectory() {
        var uri = getPageContext().getRequest().getRequestURI();
		return ListFindNoCase(uri, 'plugins', '/') && ListFindNoCase(uri, variables.settings.package,'/');
	}

	private void function goToLogin() {
		var $ = get$();
		location(url='#$.globalConfig('context')#/admin/index.cfm?muraAction=clogin.main&returnURL=#$.globalConfig('context')#/plugins/#$.getPlugin(variables.settings.pluginName).getPackage()#/', addtoken=false);
	}

	private boolean function isRequestExpired() {
		var p = variables.settings.package;
		return variables.settings.reloadApplicationOnEveryRequest
				|| !StructKeyExists(session, p) 
				|| !StructKeyExists(application, 'appInitializedTime')
				|| DateCompare(now(), session[p].expires, 's') == 1 
				|| DateCompare(application.appInitializedTime, session[p].created, 's') == 1
				|| (StructKeyExists(variables.settings, 'reloadApplicationOnEveryRequest') 
				    && variables.settings.reloadApplicationOnEveryRequest);
	}

	private void function setupSession() {
		var p = variables.settings.package;
		StructDelete(session, p);
		// Expires - s:seconds, n:minutes, h:hours, d:days
		session[p] = {
			created = Now()
			, expires = DateAdd('d', 1, Now())
			, sessionid = Hash(CreateUUID())
		};
	}

}
