<cfscript>
/**
* 
* This file is part of MuraPlugin
*
* Copyright 2013-2015 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/

	$ = StructKeyExists(session, 'siteid') ? 
		application.serviceFactory.getBean('$').init(session.siteid) : 
		application.serviceFactory.getBean('$').init('default');

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

		<div class="row-fluid">

			<!--- Message --->
			<div class="control-group">
				<label for="size" class="control-label">Message</label>
				<div class="controls">
					<input type="text" 
						name="message" 
						id="message" 
						class="objectParam span12" 
						value="#params.message#">
				</div>
			</div>
		</div>

		<!--- MISC. : Not necessary, just using as an example of how to add hidden fields --->
		<input type="hidden" name="configuredDTS" class="objectParam" value="#Now()#" />
		<input type="hidden" name="configuredBy" class="objectParam" value="#HTMLEditFormat($.currentUser('LName'))#, #HTMLEditFormat($.currentUser('FName'))#" />

	</div>

</cfoutput>
