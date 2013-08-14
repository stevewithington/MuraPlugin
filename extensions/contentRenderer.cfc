/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.cfobject' output=false {

	property name='$';

	include '../plugin/settings.cfm';

	public any function init(required struct $) {
		set$(arguments.$);
		return this;
	}

	public string function sayHello() {
		return '<h3>Hello from contentRenderer.sayHello()</h3>';
	}

	/* 
	* CONFIGURED DISPLAY OBJECTS
	* --------------------------------------------------------------------- */

	// This method will be called by dspConfiguredSayAnything()
	public string function sayAnything(string message='Hello from contentRenderer.sayAnything()') {
		return arguments.message;
	}

	public any function dspConfiguredSayAnything(required struct $) {
		var local = {};
		set$(arguments.$);

		local.params = arguments.$.event('objectParams');
		
		local.defaultParams = {
			message = 'Hello from contentRenderer.dspConfiguredSayAnything()'
		};

		StructAppend(local.params, local.defaultParams, false);

		local.str = '<div class="objSayAnything">' & sayAnything(argumentCollection=local.params) & '</div>';

		return local.str;
	}

}