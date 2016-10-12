/**
*
* This file is part of MuraPlugin
*
* Copyright 2013-2016 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.cfobject' output=false {

	include '../plugin/settings.cfm';

	public any function init() {
		return this;
	}

	public string function sayHello() {
		var str = '<h3>Hello from displayObjects.sayHello()</h3>';

		// The following needs to be defined in case this method were injected into
		// Mura's contentRenderer. Injected methods don't have access to any other
		// methods of this CFC unless those methods have been injected also.
		// var $ = StructKeyExists(variables, '$') ? variables.$ : get$(arguments);
		// str &= '<h4>#$.content('title')#</h4>';

		return str;
	}

	/*
	* CONFIGURED DISPLAY OBJECTS
	* --------------------------------------------------------------------- */

	// This method will be called by dspConfiguredSayAnything()
	public string function sayAnything(string message='Hello from displayObjects.sayAnything()') {
		return arguments.message;
	}

	public any function dspConfiguredSayAnything(required struct $) {
		var local = {};

		local.params = arguments.$.event('objectParams');

		local.defaultParams = {
			message = 'Hello from displayObjects.dspConfiguredSayAnything()'
		};

		StructAppend(local.params, local.defaultParams, false);

		local.str = '<div class="objSayAnything">' & sayAnything(argumentCollection=local.params) & '</div>';

		return local.str;
	}

	/*
	* CUSTOM TAB METHODS
	* --------------------------------------------------------------------- */
	public any function getMyCustomOptionList() {
		// you could easily query a database, or whatever else you want here
		return '1^2^3^4';
	}

	public any function getMyCustomOptionLabelList() {
		return 'Option 1^Option 2^Option 3^Option 4';
	}


	/*
	* MURA SCOPE
	* --------------------------------------------------------------------- */
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

}
