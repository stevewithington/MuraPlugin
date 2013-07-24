<cfscript>
/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
</cfscript>
<cfoutput>
	<plugin>

		<!-- Name : the name of the plugin -->
		<name>MuraPlugin</name>

		<!-- Package : a unique, variable-safe name for the plugin -->
		<package>MuraPlugin</package>

		<!--
			DirectoryFormat : 
			This setting controls the format of the plugin directory.
				* default : /plugins/{packageName}_{autoIncrement}/
				* packageOnly : /plugins/{packageName}/
		-->
		<directoryFormat>packageOnly</directoryFormat>

		<!--
			LoadPriority : 
			Options are 1 through 10.
			Determines the order that the plugins will fire during the
			onApplicationLoad event. This allows plugins to use other
			plugins as services. This does NOT affect the order in which
			regular events are fired.
		-->
		<loadPriority>5</loadPriority>

		<!-- Version : Meta information. May contain any value you wish. -->
		<version>1.4.2</version>

		<!--
			Provider : 
			Meta information. The name of the creator/organization that
			developed the plugin.
		-->
		<provider>Blue River Interactive</provider>

		<!--
			ProviderURL : 
			URL of the creator/organization that developed the plugin.
		-->
		<providerURL>http://blueriver.com</providerURL>

		<!-- Category : Usually either 'Application' or 'Utility' -->
		<category>Application</category>
		
		<!--
			ORMCFCLocation : 
			May contain a list of paths where Mura should look for 
			custom ORM components.
		-->
		<!-- <ormCFCLocation>/extensions/orm</ormCFCLocation> -->

		<!-- 
			CustomTagPaths : 
			May contain a list of paths where Mura should look for
			custom tags.
		-->
		<!-- <customTagPaths></customTagPaths> -->

		<!--
			Mappings :
			Allows you to define custom mappings for use within your plugin.
		-->
		<mappings>
			<!--
			<mapping
				name="myMapping"
				directory="someDirectory/anotherDirectory" />
			-->
			<!--
				Mappings will automatically be bound to the directory
				your plugin is installed, so the above example would
				refer to: {context}/plugins/{packageName}/someDirectory/anotherDirectory/
			-->
		</mappings>

		<!--
			AutoDeploy :
			Works with Mura's plugin auto-discovery feature. If true,
			every time Mura loads, it will look in the /plugins directory
			for new plugins and install them. If false, or not defined,
			Mura will register the plugin with the default setting values,
			but a Super Admin will need to login and manually complete
			the deployment.
		-->
		<!-- <autoDeploy>false|true</autoDeploy> -->

		<!--
			SiteID :
			Works in conjunction with the autoDeploy attribute.
			May contain a comma-delimited list of SiteIDs that you would
			like to assign the plugin to during the autoDeploy process.
		-->
		<!-- <siteID></siteID> -->

		<!-- 
				Plugin Settings :
				The settings contain individual settings that the plugin
				requires to function.
		-->
		<settings>
			<!--
			<setting
				name="yourNameAttribute"
				label="Your Label"
				hint="Your hint"
				type="text|radioGroup|textArea|select|multiSelectBox"
				required="false|true"
				validation="none|email|date|numeric|regex"
				regex="your javascript regex goes here (if validation=regex)"
				message="Your message if validation fails"
				defaultvalue=""
				optionlist="1^2^3"
				optionlabellist="One^Two^Three" />
			-->
		</settings>

		<!-- Event Handlers -->
		<eventHandlers>
			<!-- only need to register the eventHandler.cfc via onApplicationLoad() -->
			<eventHandler 
				event="onApplicationLoad" 
				component="extensions.eventHandler" 
				persist="false" />
		</eventHandlers>

		<!--
			Display Objects :
			Allows developers to provide widgets that end users can apply to a
			content node's display region(s) when editing a page. They'll be
			listed under the Layout & Objects tab. The 'persist' attribute
			for CFC-based objects determine whether they are cached or instantiated
			on a per-request basis.
		-->
		<displayobjects location="global">

			<displayobject
				name="Say Hello (CFM)"
				displayobjectfile="extensions/display_objects/sayHello.cfm" />

			<displayobject
				name="Say Hello (CFC)"
				component="extensions.contentRenderer"
				displaymethod="sayHello"
				persist="false" />

			<!-- Configurable Display Object Example -->
			<displayobject
				name="Say Anything Configurable Display Object"  
				component="extensions.contentRenderer"
				displaymethod="dspConfiguredSayAnything"
				configuratorJS="extensions/configurators/sayAnything/configurator.js"
				configuratorInit="initSayAnythingConfigurator"
				persist="false" />

		</displayobjects>

		<!-- 
			Extensions :
			Allows you to create custom Class Extensions of any type.
			See /default/includes/themes/MuraBootstrap/config.xml.cfm
			for examples.
		-->
		<!-- <extensions></extensions> -->

	</plugin>
</cfoutput>