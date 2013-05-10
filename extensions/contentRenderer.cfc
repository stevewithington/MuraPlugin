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

	public any function init(required struct $) {
		set$(arguments.$);
		return this;
	}

	public any function sayHello() {
		return '<h3>Hello from sayHello.cfc</h3>';
	}

}