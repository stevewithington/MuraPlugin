<cfsilent><cfscript>
/**
*
* This file is part of MuraPlugin
*
* Copyright 2013-2016 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/

/*
    This file is where you create your own custom user interface to collect
    any custom extended attributes you wish. Be sure to set the tab for your
    class extension Attribute Set to be 'Custom UI'!

    This particular example is for onContentEdit() which assumes you have a
    'Base/Default' class extension so that any attribute sets and attributes
    will apply to all Mura content types (Page,Folder,Link,File,Folder,Calendar,Gallery)
*/
</cfscript></cfsilent>
<cfoutput>
  <div class="fieldset">

    <div class="form-group control-group">
      <!---
        These fields don't actually exist in Mura ...
        and they've not been created as an extended attribute yet!

        They're listed here merely as examples.

        Also, using onContentEdit() assumes you've added class extensions
        under Base/Default to apply to all content types. Or, you could
        target a specific content Type and/or SubType using:
        on{Type}Edit(), or on{Type}{SubType}Edit()
      --->
      <label for="muraPluginExampleField" class="control-label">Example Field</label>
      <input name="muraPluginExampleField" type="text" value="#local.$.content('muraPluginExampleField')#" class="form-control" />
    </div>

    <div class="form-group control-group">
      <label for="muraPluginSomeSelectMenu" class="control-label">Some Select Menu:</label>
      <select name="muraPluginSomeSelectMenu" class="form-control">
        <option>- Select Something -</option>
        <cfscript>
          // this assumes you have the following methods defined in your plugin!
          // see the /MuraPlugin/Application.cfc onApplicationStart() method ...
          // and /MuraPlugin/extensions/contentRenderer.cfc file
          local.myOptionList = application[variables.settings.package].getMyCustomOptionList();
          local.myOptionLabelList = application[variables.settings.package].getMyCustomOptionLabelList();
          for ( local.i=1; local.i <= ListLen(local.myOptionList, '^'); local.i++ ) {
            local.option = ListGetAt(local.myOptionList, local.i, '^');
            local.label = ListGetAt(local.myOptionLabelList, local.i, '^');
            WriteOutput('<option value="#local.option#"');
            if ( $.content('muraPluginSomeSelectMenu') == local.option ) {
              WriteOutput(' selected="selected"');
            };
            WriteOutput('>#local.label#</option>');
          };
        </cfscript>
      </select>
    </div>

  </div>
</cfoutput>
<script>
  jQuery(document).ready(function($){
    // do any jQuery stuff you want here
    //console.log('Custom tab included.');
  });
</script>
