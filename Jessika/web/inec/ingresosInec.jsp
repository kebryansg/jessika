<%-- 
    Document   : ingresosInect
    Created on : 26-may-2017, 13:22:38
    Author     : Deivi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
    <script>
        $('.form_date').datetimepicker({
        format: "mm-yyyy",
        language: 'es',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: "year",         
        pickerPosition: "bottom-left",
        minView: 3,
        forceParse: 0,
        initialDate: new Date()
    });     
    
    </script>       
    <body>
        
<div class="container-fluid">
	<div class="row">
            <div class="col-md-12">
                <label for="inputName" style="padding-top: 10px" class="control-label col-xs-1">Ingreso</label>
                <div class="col-xs-2">
                    <div class="input-group date form_date"  data-date-format="mm-yyyy">
                        <input validate="date" class="form-control" id="dtpFechaReporte" size="16" type="text"  readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>                     
                </div>
                 <button id="btnGenerar" type="button" class="btn btn-primary">Generar</button> 
                
                 
            </div>
	</div>
    <center>
    <div id="mostrar_loading" style="display:none;"></div>
    <br>
    
    <div id="mostrar_tabla"></div>
    </center>
</div>
      
    </body>
    
 <script src="inec/js/ingresosInec.js" type="text/javascript" ></script>
</html>
