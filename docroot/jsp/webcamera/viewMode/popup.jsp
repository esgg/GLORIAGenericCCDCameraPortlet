<!--  PopUp  -->
<jsp:useBean id="popupImgURL" class="java.lang.String" scope="request" />
<jsp:useBean id="popupImgFits" class="java.lang.String" scope="request" />
<jsp:useBean id="errorImage" class="java.lang.String" scope="request" />
<HTML>
<HEAD>
</HEAD>
<BODY>

<div class="imgView">
	<% if (!errorImage.equals("error")){%>
		<img src="<%=popupImgURL %>" width="800px" height="600px"/>
	<% } else {%>
		<img src="<%=popupImgURL %>" width="200x" height="125px"/>
	<% } %>
	 
</div> 
<% if (!errorImage.equals("error")){%>
	<div>
	<a target="_blank" href="<%=popupImgFits%>"><img width="64px" height="64px" src="<%=request.getContextPath()%>/images/webcamera/download.png"></img></a>
	<a target="_blank" href="<%=popupImgURL%>&download=true"><img width="64px" height="64px" src="<%=request.getContextPath()%>/images/webcamera/download_JPG.png"></img></a>
	</div>
<% } %>	
</BODY>
</HTML>