<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("passwd") == "")) {
    	response.sendRedirect("login.jsp");
    }else
    {
%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Product</title>
    <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <script  src="bootstrap/css/bootstrap.min.css"></script>
  <script  src="js/3.1.1/jquery.min.js"></script>
  <script  src="bootstrap/js/bootstrap.js"></script>
  <script src="bootstrap/js/bootstrap.min.js"></script>
     <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
      height:110px;
    }
   * {font-family: Helvetica Neue, Arial, sans-serif; }

body { background: url("images/bg3.jpg");}

h1, table { text-align: center; }

table {border-collapse: collapse;  width: 95%; margin: 0 auto .5rem;}

th, td { padding: 1rem; font-size: 2rem;color: }

tr {background: hsl(50, 50%, 80%); }

 td { transition: .4s ease-in;text-align: center; } 

tr:first-child {background: hsla(12, 100%, 40%, 0.5); }

tr:nth-child(even) { background: hsla(50, 50%, 80%, 0.7); }

td:empty {background: hsla(50, 25%, 60%, 0.7); }

tr:hover:not(#firstrow), tr:hover td:empty {background: #ff0; pointer-events: visible;}
tr:hover:not(#firstrow) { transform: scale(1.01); font-weight: 700; box-shadow: 0px 3px 1px rgba(0, 0, 0, 0.5);}
  .jumbotron {
      
      background: url("images/FlowerBackground.png") ;
      color: #fff;
      padding: 100px 95px;
      font-family: Montserrat, sans-serif;
       width: 100%;
     height: 150px;
     }
     .navbar {
      margin-bottom: 0;
      background-color:transparent ;
      z-index: 9999;
      border: 0;
      font-size: 20px !important;
      line-height: 2 !important;
      letter-spacing: 3px;
      border-radius: 0;
      font-family: arial, serif;
  }
     .navbar li a, .navbar .navbar-brand {
      color: white !important;
  }
  .navbar-nav li a:hover, .navbar-nav li.active a {
      color: pink !important;
      background-color: green !important;
  }
     .navbar-default .navbar-toggle {
      border-color: transparent;
      color: #fff !important;
  }  
</style>
</head>
 
<body>

<div  class="jumbotron text-center">
 <div class="navbar navbar-default">
  <div class="container">
    <div class="navbar-header">
   <% String companyname=(String)session.getAttribute("companyname");%>
      
    
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>  
                             
      </button>
       <span style=font-size:22px;text-transform:uppercase;margin-top:-25px > 
       <%out.println(companyname);%></span><br>
    
    
    <% String uname=(String)session.getAttribute("username");
    String user=(String)session.getAttribute("user");
    String firstname=(String)session.getAttribute("firstname");%>
     <span class="glyphicon glyphicon-user" style=font-size:44px;text-transform:capitalize> 
     <%out.println(firstname);%></span><br>
    </div><br>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
       <li><a href="product.jsp">
      		<span class="glyphicon glyphicon-list-alt"></span>Product</a></li>
      		 <li><a href="order.jsp">
      		<span class="glyphicon glyphicon-log-in"></span>Order</a></li>
      <%if(user.equalsIgnoreCase("FRANCHISORS"))
      			{%>
      <li><a href="franchiseelist.jsp">
            <span class="glyphicon glyphicon-user"></span>Franchisee</a></li>
            <%} %>  
      <li><a href="" >
      		<span class="glyphicon glyphicon-home"></span>Home</a></li>  
     <li><a href="loginprocess.jsp" >
            <span class="glyphicon glyphicon-log-out"></span>logout</a></li>
      </ul>
    </div>
  </div>
</div>
</div>
<div class="row">
   <div class="col-lg-12">
   <br>
   </div>
</div>
<table align="center" cellpadding="5" cellspacing="5" border="1"  >
<%!
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String sql=null;

%>
<%
try{ 
	String s=null;
	
	
	if(user.equalsIgnoreCase("FRANCHISORS"))
	{
		sql="select * from products where franchisorsID=?";
		s=(String)session.getAttribute("franchisorsid");
	}
	else 
	{
		sql="select modelname,color,type,quantity from orderitems where ordersID in (select ordersID from orders where franchiseesID=? and status='delivered')";
		s=(String)session.getAttribute("franchiseesid");
	}
Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/db","root","ajay");
    pst = con.prepareStatement(sql);
    pst.setString(1,s);
   int count=1; 
    rs = pst.executeQuery();
 if(user.equalsIgnoreCase("FRANCHISORS"))
 {%>
    <tr bgcolor="#A52A2A">

    <td><b>S/N</b></td>
    <td><b>ModelName</b></td>
    <td><b>Color</b></td>
    <td><b>Type</b></td>
    <td><b>price</b></td>
    <td><b>Status</b></td>
    <td><b>SellingPrice</b></td>
    <td><b>Quantity</b></td>

    </tr>
<%
while(rs.next()){
%>
<tr bgcolor="#DEB887">


      <tr><td><%out.println(count++);%></td>
      <td><%out.println(rs.getString(1));%></td>
      <td ><%out.println(rs.getString(2));%></td>
      <td><%out.println(rs.getString(3));%></td>
      <td ><%out.println(rs.getString(4));%></td>
      <td><%out.println(rs.getString(5));%></td>
      <td ><%out.println(rs.getString(6));%></td>
      <td><%out.println(rs.getString(8));%></td>
      
</tr>

<% 
}
 }
else 
{
	%>
	 <tr bgcolor="#A52A2A">

	    <td><b>S/N</b></td>
	    <td><b>ModelName</b></td>
	    <td><b>Color</b></td>
	    <td><b>Type</b></td>
	    <td><b>Quantity</b></td>
	    </tr>
	<%
	while(rs.next()){
	%>
	<tr bgcolor="#DEB887">


	      <tr><td><%out.println(count++);%></td>
	      <td><%out.println(rs.getString(1));%></td>
	      <td ><%out.println(rs.getString(2));%></td>
	      <td><%out.println(rs.getString(3));%></td>
	      <td ><%out.println(rs.getString(4));%></td>
	      
	       
	</tr>
	<%
}
}
}
 catch (Exception e) {
e.printStackTrace();
}
%>
</table>
<%} %>
