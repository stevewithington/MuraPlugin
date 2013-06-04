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

	$ = StructKeyExists(session, 'siteid') ? 
		application.serviceFactory.getBean('MuraScope').init('session.siteid') : 
		application.serviceFactory.getBean('MuraScope').init('default');

	params = IsJSON($.event('params')) ? DeSerializeJSON($.event('params')) : {};

	defaultParams = {
		message = ''
	};
	
	StructAppend(params, defaultParams, false);
</cfscript>

<style type="text/css">
	#availableObjectParams dt { padding-top:1em; }
	#availableObjectParams dt.first { padding-top:0; }
</style>

<cfoutput>

	<div id="availableObjectParams"	
		data-object="plugin" 
		data-name="sayAnything" 
		data-objectid="#$.event('objectID')#">

		<dl class="singleColumn">

			<!--- Message --->
			<dt class="first">
				<label for="size">Message</label>
			</dt>
			<dd>
				<input type="text" 
					name="message" 
					id="message" 
					class="objectParam" 
					value="#params.message#" />
			</dd>

			<!--- MISC. : Not necessary, just using as an example of how to add hidden fields --->
			<input type="hidden" name="configuredDTS" class="objectParam" value="#Now()#" />
			<input type="hidden" name="configuredBy" class="objectParam" value="#HTMLEditFormat($.currentUser('LName'))#, #HTMLEditFormat($.currentUser('FName'))#" />

		</dl>

	</div>

</cfoutput>