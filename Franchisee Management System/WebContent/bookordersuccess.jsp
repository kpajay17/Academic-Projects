 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.util.Random"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%
 Connection con=null;
 PreparedStatement pst=null;
 PreparedStatement pst1=null;

 String sql=null;
 String sql1=null;
String user=(String)session.getAttribute("user");
//System.out.println(user);
String franchisorsid="fr001";
//System.out.println(franchisorsid);
String franchiseesid=(String)session.getAttribute("franchiseesid");
//System.out.println(franchiseesid);
Random rand = new Random();
int id = rand.nextInt(90000) + 10000;
String orderid=""+id;
System.out.println(orderid);
int oid = rand.nextInt(90000) + 10000;
String orderitemsid=""+oid;
System.out.println(orderitemsid);
String Type = request.getParameter("type");
System.out.println(Type);
String color = request.getParameter("color");
String mname = request.getParameter("modelname");
int quant =Integer.parseInt( request.getParameter("quantity"));
Date dateobj = new Date();
DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
String orderdate = df1.format(dateobj).toString();
System.out.println(orderdate);
String status="not delivered";

try
{
	//sql="insert into orders values (?,?,?,?,?)";
	//sql1="insert into orderitems values (?,?,?,?,?,?)";
   Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost/db","root","ajay");
	pst = con.prepareStatement("insert into orders values(?,?,?,?,?)");
    pst.setString(1,orderid);
    pst.setString(2,franchiseesid);
    pst.setString(3,franchisorsid);
    pst.setString(4,orderdate);
    pst.setString(5,status);
   int flag = pst.executeUpdate();
  	pst1 = con.prepareStatement("insert into orderitems values(?,?,?,?,?,?)");
    pst1.setString(1,orderitemsid);
    pst1.setString(2,mname);
    pst1.setString(3,color);
    pst1.setString(4,Type);
    pst1.setString(5,orderid);
    pst1.setInt(6,quant);
   
   int flag1=pst1.executeUpdate();
    if(flag>0 && flag1>0) {
    	%>
 <script type="text/javascript">
alert("order successfully done");
window.location='bookorder.jsp';
</script>
    	<%
 }else
 { 
	 %>
	 <script type="text/javascript">
	 alert("order failed  !!!")
	 </script>
	 <% 
 }
    
}catch(Exception e)
{
 	%>
	<script>
	alert("Error Please Try Again");
    </script>
    
    <%
  
}

%>