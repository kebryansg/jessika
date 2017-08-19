<%@page import="java.util.Date"%>
<%@page import="mvc.modelo.smDaoImp.ExcelDaoImp"%>
<%@page import="mvc.modelo.smDao.ExcelDao"%>
<%@page import="mvc.modelo.smDao.ExcelDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Jessika 3.0</title>
        <!-- BOOTSTRAP STYLES-->
        <link href="resources/bootstrap/css/bootstrap.css" rel="stylesheet" />
        <!-- FONTAWESOME STYLES-->
        <link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">

            <!-- CUSTOM STYLES-->
            <link href="resources/font-awesome/css/custom.css" rel="stylesheet">    
                <link href="resources/css/style_home.css" rel="stylesheet">
                    <!-- GOOGLE FONTS-->
                    <!--<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />-->
                    <script src="resources/js/jquery.min.js" type="text/javascript" ></script>
                    <script src="resources/js/validate.js" type="text/javascript"></script>


                    </head>
                    <style>
                        .bx
                        {
                            outline: 1px blue solid;
                        }

                    </style>
                    <body>
                        <%

                            HttpSession sesion = request.getSession();
                            if (sesion.getAttribute("usuario") != null) {
                                response.sendRedirect("home.jsp");
                            }
                        %>
                        <div class="full-page">
                            <div class="container">
                                <div class="row text-center ">
                                    <div class="col-md-12">
                                        <br /><br />
                                        <h2> Jessika 3.0 : Login</h2>

                                        <h5>( Inicia sesión para acceder al sistema)</h5>
                                        <br />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <strong>   Ingrese Los Datos </strong>  
                                            </div>
                                            <div class="panel-body">
                                                <form role="form">
                                                    <br />
                                                    <div class="form-group input-group">
                                                        <span class="input-group-addon"><i class="fa fa-tag"  ></i></span>
                                                        <input  id="txtUsuario" validate="text" type="text" class="form-control" placeholder="Usuario " />
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <span class="input-group-addon"><i class="fa fa-lock"  ></i></span>
                                                        <input id="txtClave" validate="text" type="password" class="form-control"  placeholder="Contraseña" />
                                                    </div>


                                                    <div class="form-group">
                                                        <label class="checkbox-inline">
                                                            <input type="checkbox" /> Recordarme
                                                        </label>
                                                        <span class="pull-right">
                                                            <a href="#" >Olvidó su contraseña? </a> 
                                                        </span>
                                                    </div>

                                                    <a href="#"  id="btnLogin" class="btn btn-primary ">Iniciar sesión</a>

                                                </form>
                                            </div>

                                        </div>
                                    </div>


                                </div>
                            </div>
                            <div class="logo-emp">
                                <img src="resources/img/Logo Ui Life-10.png" class="img-responsive img-logo">
                            </div>
                        </div>





                        <!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
                        <!-- JQUERY SCRIPTS -->


                    </body>
                    <script type="text/javascript" src="resources/js/alertify.min.js" async="async"></script>
                    <script type="text/javascript" src="resources/js/alertify.js" async="async"></script>

                    <link rel="stylesheet" href="resources/css/alertify.core.css" />
                    <link rel="stylesheet" href="resources/css/alertify.default.css" >
                        <script type="text/javascript" src="usuario/login.js"></script>
                        </html>
