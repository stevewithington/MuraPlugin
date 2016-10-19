<cfscript>
/**
*
* This file is part of MuraPlugin
*
* Copyright 2013-2016 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
* NOTE:
* This is essentially just a simple 'include' file
* You could do whatever you need here (e.g., db lookups, etc.)
* Also, since this will be rendered via the front-end,
* you have access to the Mura $cope!
*
*/
	pluginpath = m.globalConfig('context') & '/plugins/MuraPlugin';
	param name='objectparams.sayhellomessage' default='';

</cfscript>
<cfoutput>
	<h3>Say Hello</h3>
  <p>This is a &quot;configurable&quot; display object from <strong>MuraPlugin</strong>.</p>

	<h4>Message</h4>
	<cfif Len(objectparams.sayhellomessage)>
		<div class="alert alert-success">
			#esapiEncode('html', objectparams.sayhellomessage)#
		</div>
	<cfelse>
		<div class="alert alert-danger">
			No <strong>message</strong> has been entered.
		</div>
	</cfif>

	<!--
	<script>
	  // If you wish to add CSS or JS ...
	  Mura(function(m) { 
			var pluginpath = '#pluginpath#';

	    m.loader() 
	      .loadcss(pluginpath + '/display_objects/sayhello/my.css') 
	      .loadjs(
	        pluginpath + '/display_objects/sayhello/my.js',
	        pluginpath + '/display_objects/sayhello/other.js',
	        function() {
	          // Do something with the loaded JS
	        }
	      ); 
	  });
	</script>
	-->
</cfoutput>
