<div>
	<span class="aui-button-content">
		<input type="button" 
			id="submitSetParams" 
			name="submitSetParams"  
			value="<liferay-ui:message key='button-submit' />"
			onClick="<portlet:namespace />setValues()" 
			/>
		<input type="button" 
			id="submitGetParams" 
			name="submitGetParams"  
			value="<liferay-ui:message key='button-refresh' />"
			onClick="<portlet:namespace />getValues();" 
			/>
	</span>
</div>

<script>
<portlet:namespace />getValues();
document.getElementById("<portlet:namespace />status").innerHTML='<liferay-ui:message key="label-ready"/>';

function <portlet:namespace />setValues(){	
	var brightness;
	var gain;
	var exposure;
	var contrast;
	var gamma;
	
	var correct = true;
	
	var text="";
	
	var status = document.getElementById("<portlet:namespace />status");
	
	status.innerHTML = '<liferay-ui:message key="label-setting-parameters"/>';
	
	var expNumN=/^\d+$/;
	var expNumR=/^\d+[.]\d+$/;
	
	var validate = true;

	<% if (checkboxGain.equalsIgnoreCase("1") 
			&& !gain_value.equalsIgnoreCase("<liferay-ui:message key='label-error' />")) {%>
		gain = document.getElementById("<portlet:namespace />gain_value").value;
	<% } else {%>
		gain = "error";
	<% } %>
	
	<% if (checkboxExposure.equalsIgnoreCase("1") 
			&& !expT_value.equalsIgnoreCase("<liferay-ui:message key='label-error' />")) {%>
		exposure = document.getElementById("<portlet:namespace />expT_value").value;
	<% } else {%>
		exposure = "error";
	<% } %>
	
	gamma = document.getElementById("<portlet:namespace />gamma_value").value;
		
	if (!expNumN.test(gamma)){
		validate=false;
		alert('<liferay-ui:message key="msg-error-parameter"/>');
	}
	
	if (!expNumN.test(gain)){
		validate=false;
		alert('<liferay-ui:message key="msg-error-parameter"/>');
	}
	
	if (!expNumR.test(exposure)){
		validate=false;
		alert('<liferay-ui:message key="msg-error-parameter"/>');	
	}
	
	
	if (validate){
		
	
	
		AUI().use('aui-io-request', function(A){
			var url = '<%=setValues%>';
			A.io.request(url, {
				method : 'POST',
				data: {
					'gamma': gamma,
					'gain': gain,
					'exposure': exposure
				},
				dataType: 'json',
				on: {
					failure: function() {
						status.innerHTML = '<liferay-ui:message key="msg-error-not-send-command"/>';
					},
					success: function() {   
						var data = this.get('responseData');
						var success = data.success;
						if (success) {
							status.innerHTML = '<liferay-ui:message key="label-ready"/>';
						} else {
							if (data.message == "error_operation"){
								status.innerHTML = '<liferay-ui:message key="msg-error-operation"/>';
							} else if (data.message == "error_execution"){
								status.innerHTML = '<liferay-ui:message key="msg-error-execution"/>';
							} else if (data.message == "error_reservation_not_active"){
								status.innerHTML = '<liferay-ui:message key="msg-error-reservation_not_active"/>';
							} else if (data.message == "error_limit"){
								status.innerHTML = '<liferay-ui:message key="msg-error-limit"/>';
							} else if (data.message == "error_reservation_null"){
								status.innerHTML = '<liferay-ui:message key="msg-error-reservation_null"/>';
							} else if (data.message == "error_parameter"){
								status.innerHTML = '<liferay-ui:message key="msg-error-parameter"/>';
							}
						}
					}   
				} 
			});
		});
	}

}

function <portlet:namespace />getValues(){	
	var brightness_field = document.getElementById("<portlet:namespace />brightness_value");
	var gain_field = document.getElementById("<portlet:namespace />gain_value");
	var exposure_field = document.getElementById("<portlet:namespace />expT_value");
	var status = document.getElementById("<portlet:namespace />status");
	
	status.innerHTML = '<liferay-ui:message key="label-getting-parameters"/>';
	
	AUI().use('aui-io-request', function(A){
		var url = '<%=getValues%>';
		
		A.io.request(url, {
			method : 'POST',
			data: {
			},
			dataType: 'json',
			on: {
				failure: function() {
					status.innerHTML = '<liferay-ui:message key="msg-error-not-send-command"/>';
				},
				success: function() {
					var data = this.get('responseData');
					var success = data.success;
	
					if (success) {
						status.innerHTML = '<liferay-ui:message key="label-ready"/>';
						document.getElementById("<portlet:namespace />gamma_value").value = data.gamma;
						document.getElementById("<portlet:namespace />gain_value").value = data.gain;
						document.getElementById("<portlet:namespace />expT_value").value = data.exposure;
					} else {
						if (data.message == "error_operation"){
							status.innerHTML = '<liferay-ui:message key="msg-error-operation"/>';
						} else if (data.message == "error_execution"){
							status.innerHTML = '<liferay-ui:message key="msg-error-execution"/>';
						} else if (data.message == "error_reservation_not_active"){
							status.innerHTML = '<liferay-ui:message key="msg-error-reservation_not_active"/>';
						} else if (data.message == "error_limit"){
							status.innerHTML = '<liferay-ui:message key="msg-error-limit"/>';
						} else if (data.message == "error_reservation_null"){
							status.innerHTML = '<liferay-ui:message key="msg-error-reservation_null"/>';
						}
						document.getElementById("<portlet:namespace />GLORIAwebcam").src = "<%=request.getContextPath()%>/images/not_available.png";
						document.getElementById("<portlet:namespace />gamma_value").value = "<liferay-ui:message key='label-error' />";
						document.getElementById("<portlet:namespace />gain_value").value = "<liferay-ui:message key='label-error' />";
						document.getElementById("<portlet:namespace />expT_value").value = "<liferay-ui:message key='label-error' />";
						
					} // end-if
				} // end-success  
			} // end-on 
		}); // end-request
	}); // end-AUI
} // end-function

</script>