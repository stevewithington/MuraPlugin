/**
* 
* This file is part of MuraPlayer TM
*
* Copyright 2010-2013 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.plugin.plugincfc' output=false {

	property name='config';
	property name='packageName';
	
	/**
	* Constructor
	*/
	public any function init(config='') output=false {
		if ( IsSimpleValue(arguments.config) && StructKeyExists(application, 'configBean') ) {
			arguments.config = application.configBean;
		};
		setConfig(arguments.config);
		setPackageName('MuraPlayer');
		return this;
	};
	
	/**
	* install()
	*/
	public void function install() {
		var local = {};
		// need to check and see if this is already installed ... if so, then abort!
		local.moduleid = getConfig().getModuleID();
		// only if this is NOT installed
		if ( val(getInstallationCount()) neq 1 ) {
			getConfig().getPluginManager().deletePlugin(local.moduleid);
		};
		super.install();
	};
	
	/**
	* update()
	*/
	public void function update() output=false {
		var local = {};
		super.update();
	};
	
	/**
	* delete()
	*/
	public void function delete() output=false {
		var local = {};
		super.delete();
	};
	
	/**
	* i check to see if this plugin has already been installed. if so, i delete the new one.
	*/
	private any function getInstallationCount(boolean debug=false) output=false {
		var qs = '';
		var qoq = '';
		var rs = application.configBean.getPluginManager().getAllPlugins();
		var local = {};
		local.ret = 0;
		if ( rs.recordcount ) {
			qs = new query();
			qs.setDBType('query');
			qs.setName('qoq');
			qs.setAttributes(rs=rs);
			qs.addParam(name='package', value=getPackageName(), cfsqltype='cf_sql_varchar', maxlength=100);
			qs.setSQL('SELECT * FROM rs where package = :package');
			local.result = qs.execute();
			local.metaInfo = local.result.getPrefix();
			if ( local.metaInfo.recordcount ) {
				local.ret = val(local.metaInfo.recordcount);
			};
		};
		if ( arguments.debug ) {
			return local.result;
		} else {
			return local.ret;
		};
	};

	/**
	* toBundle()
	*/
	// public void function toBundle(pluginConfig, bundle, siteid) output=false {
	// 	var bundleUtil = new BundleUtility();
	// 	bundleUtil.toBundle(argumentCollection=arguments);
	// }

	/**
	* Metadata property inspector
	*/
	public struct function getProperties() output=false {
		var local = {};
		local.properties = {};
		local.data = getMetaData(this).properties;
		for ( local.i=1; local.i lte ArrayLen(local.data); local.i++ ) {
			local.properties[local.data[local.i].name] = Evaluate('get#local.data[local.i].name#()');
		};
		return local.properties;
	};

}