/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.plugin.plugincfc' output=false {

	public void function install() {
		super.install();
	}
	
	public void function update() output=false {
		super.update();
	}

	public void function delete() output=false {
		super.delete();
	}

	// public void function toBundle(pluginConfig, bundle, siteid) output=false {
	// 	var bundleUtil = new BundleUtility();
	// 	bundleUtil.toBundle(argumentCollection=arguments);
	// }


}