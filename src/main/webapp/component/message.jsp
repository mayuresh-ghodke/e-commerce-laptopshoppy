
<% 
	String message= (String) session.getAttribute("failedMessage");
	if(message != null)
	{		
		//out.println(message);		
	%>	
	<div class="alert alert-danger alert-dismissible fade show" role="alert">
  		<strong><%= message %></strong>
		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
		   <span aria-hidden="true">&times;</span>
		</button>
	</div>	
	<%		
		session.removeAttribute("failedMessage");					
	}
%>

<%
	String success=(String)session.getAttribute("successMessage");
	if(success != null)
	{		
		//out.println(message);		
		%>	
		<div class="alert alert-success alert-dismissible fade show" role="alert">
				<strong><%= success %></strong>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
			   <span aria-hidden="true">&times;</span>
			</button>
		</div>	
		<%		
			session.removeAttribute("successMessage");					
	}
%>




