<cfscript>
/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013-2014 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
	include 'settings.cfm';
</cfscript>
<cfoutput>
	<plugin>

		<!-- Name : the name of the plugin -->
		<name>#variables.settings.pluginName#</name>

		<!-- Package : a unique, variable-safe name for the plugin -->
		<package>#variables.settings.package#</package>

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
		<loadPriority>#variables.settings.loadPriority#</loadPriority>

		<!-- Version : Meta information. May contain any value you wish. -->
		<version>#variables.settings.version#</version>

		<!--
			Provider : 
			Meta information. The name of the creator/organization that
			developed the plugin.
		-->
		<provider>#variables.settings.provider#</provider>

		<!--
			ProviderURL : 
			URL of the creator/organization that developed the plugin.
		-->
		<providerURL>#variables.settings.providerURL#</providerURL>

		<!-- Category : Usually either 'Application' or 'Utility' -->
		<category>#variables.settings.category#</category>
		
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
			<setting>
				<name>yourNameAttribute</name>
				<label>Your Label</label>
				<hint>Your hint</hint>
				<type>text|radioGroup|textArea|select|multiSelectBox</type>
				<required>false|true</required>
				<validation>none|email|date|numeric|regex</validation>
				<regex>your javascript regex goes here (if validation=regex)</regex>
				<message>Your message if validation fails</message>
				<defaultvalue>1</defaultvalue>
				<optionlist>1^2^3</optionlist>
				<optionlabellist>One^Two^Three</optionlabellist>
			</setting>
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
		<extensions>

			<!-- Example of using Custom UI in conjunction with onContentEdit() -->
			<!--- <extension type="Base" subType="Default">
				<attributeset name="onContentEdit Fields" container="Custom">
					<attribute 
						name="muraPluginExampleField"
						label="MuraPlugin Example Field"
						hint=""
						type="TextBox"
						defaultValue=""
						required="false"
						validation=""
						regex=""
						message=""
						optionList=""
						optionLabelList="" />
					<attribute 
						name="muraPluginSomeSelectMenu"
						label="MuraPlugin Some Select Menu"
						hint=""
						type="SelectBox"
						defaultValue=""
						required="false"
						validation=""
						regex=""
						message=""
						optionList="[mura]application.MuraPlugin.getMyCustomOptionList()[/mura]"
						optionLabelList="[mura]application.MuraPlugin.getMyCustomOptionLabelList()[/mura]" />
				</attributeset>
			</extension> --->
			
		</extensions>

	</plugin>
</cfoutput>