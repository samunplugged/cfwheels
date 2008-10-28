<cfoutput>
<cfif application.settings.showDebugInformation AND isDefined("request.wheels.showDebugInformation") AND request.wheels.showDebugInformation>
	<cfset request.wheels.execution.componentTotal = getTickCount() - request.wheels.execution.componentTotal>
	<div style="clear:both;margin-top:100px;text-align:left;background:##ececec;padding:10px;border-top:2px solid ##808080;border-bottom:2px solid ##808080;">
	<table cellspacing="0">
	<tr>
		<td valign="top"><strong>Application Name:</strong></td>
		<td>#application.applicationName#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Framework:</strong></td>
		<td>Wheels #application.wheels.version# (#application.settings.environment# mode)</td>
	</tr>
	<tr>
		<td valign="top"><strong>CFML Engine:</strong></td>
		<td>#application.wheels.serverName# #application.wheels.serverVersion#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Database:</strong></td>
		<td>#application.wheels.databaseProductName# #application.wheels.databaseVersion#</td>
	</tr>
	<tr>
		<td valign="top"><strong>URL Rewriting:</strong></td>
		<td>#application.wheels.URLRewriting#</td>
	</tr>
	<tr>
		<td valign="top"><strong>URL Obfuscation:</strong></td>
		<td><cfif application.settings.obfuscateURLs>On<cfelse>Off</cfif></td>
	</tr>
	<tr>
		<td valign="top"><strong>Plugins:</strong></td>
		<td><cfif StructCount(application.wheels.plugins) IS NOT 0><cfset loc.count = 0><cfloop collection="#application.wheels.plugins#" item="loc.i"><cfset loc.count = loc.count + 1><a href="<cfif application.wheels.URLRewriting IS 'On'>/plugins/#LCase(loc.i)#<cfelseif application.wheels.URLRewriting IS 'Partial'>/index.cfm/plugins/#LCase(loc.i)#<cfelse>/index.cfm?controller=plugins&action=#LCase(loc.i)#</cfif>">#loc.i#</a><cfif StructCount(application.wheels.plugins) GT loc.count>, </cfif></cfloop><cfelse>None</cfif></td>
	</tr>
	<tr>
		<td valign="top"><strong>Controller:</strong></td>
		<td>#request.wheels.params.controller#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Action:</strong></td>
		<td>#request.wheels.params.action#</td>
	</tr>
	<cfif StructKeyExists(request.wheels.params, "key")>
		<tr>
			<td valign="top"><strong>Key(s):</strong></td>
			<td>#request.wheels.params.key#</td>
		</tr>
	</cfif>
	<cfif StructCount(request.wheels.params) GT 3 OR (StructCount(request.wheels.params) GT 2 AND NOT StructKeyExists(request.wheels.params, "key"))>
		<tr>
			<td valign="top"><strong>Additional Params:</strong></td>
			<td>
			<cfloop collection="#request.wheels.params#" item="loc.i">
				<cfif loc.i IS NOT "fieldnames" AND loc.i IS NOT "controller" AND loc.i IS NOT "action" AND loc.i IS NOT "key">
					<cfif isStruct(request.wheels.params[loc.i])>
						<cfloop collection="#request.wheels.params[loc.i]#" item="loc.j">
							#lCase(loc.i)#.#lCase(loc.j)# = #request.wheels.params[loc.i][loc.j]#<br />
						</cfloop>
					<cfelse>
						#lCase(loc.i)# = #request.wheels.params[loc.i]#<br />
					</cfif>
				</cfif>
			</cfloop>
			</td>
		</tr>
	</cfif>
	<tr>
		<td valign="top"><strong>Execution Time:</strong></td>
		<td>#request.wheels.execution.componentTotal#ms</td>
	</tr>
	<tr>
		<td valign="top"><strong>Execution Time Details:</strong></td>
		<td>
		<cfset loc.keys = structSort(request.wheels.execution.components, "numeric", "desc")>
		<cfloop from="1" to="#arrayLen(loc.keys)#" index="loc.i">
			~#request.wheels.execution.components[loc.keys[loc.i]]#ms - #lCase(loc.keys[loc.i])#<br />
		</cfloop>
	</td>
	</tr>
	</table>
	</div>
</cfif>
</cfoutput>