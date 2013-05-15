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
<!--- 
	NOTE:
	We're going to pack everything up into a tilde (~) separated list where THE LAST ITEM in the list 
	is a JSON formatted list of params to be passed over to the display method.
--->
<cfoutput>
	<select name="availableObjects" id="availableObjects" class="dropdown">

		<!--- Here you could loop over a query to output various options, etc. --->
		<option value='plugin~Display Object 1~#$.event('objectid')#~{"objDisplayFile":"displayObject1.cfm"}'>
			Display Object 1
		</option>

		<option value='plugin~Display Object 2~#$.event('objectid')#~{"objDisplayFile":"displayObject2.cfm"}'>
			Display Object 2
		</option>

	</select>
</cfoutput>