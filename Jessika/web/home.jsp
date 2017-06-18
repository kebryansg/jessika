<%@page import="java.util.List"%>
<%@page import="mvc.modelo.smDaoImp.IngresosDaoImp"%>
<%@page import="mvc.controlador.entidades.sm.HistorialClinico"%>
<%@page import="mvc.modelo.smDao.IngresosDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Jessika 3.0</title>

        <!-- Bootstrap Core CSS -->
        <link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
         
        <!-- Custom CSS -->
        <link href="resources/bootstrap/css/sb-admin.css" rel="stylesheet">
        <link href="resources/css/style_home.css" rel="stylesheet" type="text/css"/>
        <!-- Custom Fonts -->
        <link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="resources/font-awesome/css/style.css" rel="stylesheet" type="text/css">

        <link href="resources/bootstrap/css/bootstrap-datetimepicker.css"  rel="stylesheet" type="text/css"/>

        <link href="resources/js-ui/jquery-ui.css" rel="stylesheet"/>
        <link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="resources/bootstrap/table/bootstrap-table.min.css" rel="stylesheet" type="text/css"/>



        <script src="resources/js/jquery.min.js" type="text/javascript" ></script>
        <script src="resources/bootstrap/js/bootstrap.min.js" type="text/javascript"  ></script>
        <script src="resources/bootstrap/table/bootstrap-table.min.js" type="text/javascript"></script>
        <script src="resources/bootstrap/table/bootstrap-table-contextmenu.js" type="text/javascript"></script>
        <script src="resources/bootstrap/table/locale/bootstrap-table-es-ES.min.js" type="text/javascript"></script>
        
        <!--    desde aqui mis links -->


        <script type="text/javascript" src="resources/js/moment.js" async="async"></script>
        <script type="text/javascript" src="resources/bootstrap/js/bootstrap-datetimepicker.js" ></script>        
        <script src="resources/bootstrap/js/bootstrap-datetimepicker.es.js" type="text/javascript" ></script>


        <script type="text/javascript" src="resources/js/alertify.min.js" async="async"></script>
        <script type="text/javascript" src="resources/js/alertify.js" async="async"></script>
        <link rel="stylesheet" href="resources/css/alertify.core.css" />
        <link rel="stylesheet" href="resources/css/alertify.default.css" > />
        <script src="resources/js/jquery.twbsPagination.js" type="text/javascript" ></script>
        <script src="resources/js/validate.js" type="text/javascript"></script>
        <script src="resources/js/style.js" type="text/javascript"></script>
        <script src="resources/js/home.js" type="text/javascript"></script>


        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap-select.min.css" >
        <link href="resources/bootstrap/css/ajax-bootstrap-select.min.css" rel="stylesheet" type="text/css"/>
        <script src="resources/bootstrap/js/bootstrap-select.min.js"></script>
        <script src="resources/bootstrap/js/ajax-bootstrap-select.min.js" type="text/javascript"></script>

    </head>

    <body>
        <%
            HttpSession sesion = request.getSession();
            //if(sesion.getAttribute("usuario") == null)
            if (false) {
                response.sendRedirect("login.jsp");

            }
        %>
        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="home.jsp">Jessika 3.0</a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">


                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%=session.getAttribute("nombresUsuario")%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">                            
                            <li>
                                <a id="aSalida" href="#"><i class="fa fa-fw fa-power-off"></i> Salir</a>
                            </li>
                        </ul>
                    </li>


                </ul>
                <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <div class="collapse navbar-collapse navbar-ex1-collapse" id="TabAdm">
                    <ul class="nav navbar-nav side-nav">
                        <li class="active">
                            <a href="home.jsp"><i class="fa fa-fw fa-dashboard"></i> Inicio</a>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="#pacientes"> Pacientes <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="pacientes" class="collapse">
                                <li>
                                    <a data-url="paciente/paciente.jsp" data-title="Registrar Paciente" href="#"><i class="fa fa-user fa-fw" aria-hidden="true"></i>&nbsp; Registrar</a>
                                </li>
                                <li>
                                    <a data-url="paciente/listPacientes.jsp" data-title="Buscar Paciente" href="#"><i class="fa fa-address-book fa-fw" aria-hidden="true"></i>&nbsp; Buscar</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="#consultas"> Consultas <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="consultas" class="collapse">
                                <li>
                                    <a data-url="consulta/ListHistorialC.jsp" data-title="Registrar Consulta" href="#">&nbsp; Registrar</a>
                                </li>                            
                            </ul>
                        </li>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="#medicos">Médicos <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="medicos" class="collapse">
                                <li>
                                    <a data-url="medico/registrarMedico.jsp" data-title="Registrar Médico" href="#"><i class="fa fa-user fa-fw" aria-hidden="true"></i>&nbsp; Médico</a>
                                </li>
                                <li>
                                    <a data-url="medico/editarMedico.jsp" data-title="Mantenimiento Médico" href="#"><i class="fa fa-address-book fa-fw" aria-hidden="true"></i>&nbsp; Mantenimiento</a>
                                </li>
                                <li>
                                    <a data-url="medico/especialidad.jsp" data-title="Especialidades" href="#"><i class="fa fa-address-book fa-fw" aria-hidden="true"></i>&nbsp; Especialidad</a>
                                </li>
                            </ul>
                        </li>
                        </li>
                        <li>
                            <a href="javascript:;" data-toggle="collapse" data-target="#ingresos">Hospitalización<i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="ingresos" class="collapse">
                                <li>
                                    <a  data-url="ingresos/registroIngresos.jsp" data-title="Ingresos" href="#"><i class="fa fa-user fa-fw" aria-hidden="true"></i>&nbsp; Registrar</a>
                                </li>
                                <li>
                                    <a data-url="ingresos/editarIngresos.jsp" data-title="Mantenimiento Ingresos" href="#"><i class="fa fa-address-book fa-fw" aria-hidden="true"></i>&nbsp; Mantenimiento</a>
                                </li>                            
                            </ul>
                        </li>
                        <li>
                        <a href="javascript:;" data-toggle="collapse" data-target="#reportes">Reportes<i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="reportes" class="collapse">
                            <li>
                                <a  data-url="" data-title="Ingresos" href="#"><i class="fa fa-user fa-fw" aria-hidden="true"></i>&nbsp; Hospitalizaciones</a>
                            </li>
                            <li>
                                <a data-url="" data-title="Mantenimiento Ingresos" href="#"><i class="fa fa-address-book fa-fw" aria-hidden="true"></i>&nbsp; Consultas</a>
                            </li>                            
                        </ul>
                        <a href="javascript:;" data-toggle="collapse" data-target="#inec">Inec<i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="inec" class="collapse">
                            <li>
                                <a  data-url="inec/ingresosInec.jsp" data-title="Ingresos" href="#"><i class="fa fa-user fa-fw" aria-hidden="true"></i>&nbsp; Hospitalizaciones</a>
                            </li>                                                  
                            <li>
                                <a data-url="" data-title="Mantenimiento Ingresos" href="#"><i class="fa fa-address-book fa-fw" aria-hidden="true"></i>&nbsp; RAS</a>
                            </li>                            
                        </ul>
                        <a href="javascript:;" data-toggle="collapse" data-target="#establecimiento">Establecimiento<i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="establecimiento" class="collapse">
                            <li>
                                <a  data-url="configuracion/establecimiento.jsp" data-title="Ingresos" href="#"><i class="fa fa-user fa-fw" aria-hidden="true"></i>&nbsp; Configuración</a>
                            </li>                            
                            <li>
                                <a data-url="configuracion/camasConf.jsp" data-title="Mantenimiento Ingresos" href="#"><i class="fa fa-address-book fa-fw" aria-hidden="true"></i>&nbsp; Camas</a>
                            </li>                                                        
                        </ul>
                    </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>

            <div id="page-wrapper">

                <div class="container-fluid">

                <!-- Page Heading -->
                
                <div class="row">
                    <div class="col-sm-12">                        
                        <div class="panel panel-default" id="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title" id="titulo"> </h3>
                            </div>
                            <div id="contenido" class="panel-body">
                                <!-- /. ROW  -->
                                
                                <div class="row">
                                    <div class="col-md-3 col-sm-6 col-xs-6">           
                                        <div class="panel panel-back noti-box">
                                            <span class="icon-box bg-color-red set-icon">
                                                <i class="fa fa-envelope-o"></i>
                                            </span>
                                            <div class="text-box" >
                                                <p class="main-text">120</p>
                                                <p class="text-muted">Pacientes</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-6">           
                                        <div class="panel panel-back noti-box">
                                            <span class="icon-box bg-color-green set-icon">
                                                <i class="fa fa-bars"></i>
                                            </span>
                                            <div class="text-box" >
                                                <p class="main-text">30 </p>
                                                <p class="text-muted">Consultas</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-6">           
                                        <div class="panel panel-back noti-box">
                                            <span class="icon-box bg-color-blue set-icon">
                                                <i class="fa fa-bell-o"></i>
                                            </span>
                                            <div class="text-box" >
                                                <p class="main-text">240 </p>
                                                <p class="text-muted">Hospitaliaciones</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-6 col-xs-6">           
                                        <div class="panel panel-back noti-box">
                                            <span class="icon-box bg-color-brown set-icon">
                                                <i class="glyphicon glyphicon-user"></i>
                                            </span>
                                            <div class="text-box" >
                                                <p class="main-text">3</p>
                                                <p class="text-muted">Usuarios</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="contenido" class="panel-body">
                                    
                                </div>
                            </div>
                            <!-- /.col-sm-4 -->

                        </div>
                        <!-- /.row -->


                        <!-- / contenido -->            
                    </div>
                    <!-- /.container-fluid -->

                </div>
                </div>
                            </div>
                                    
                        </div>
                        <!-- /.col-sm-4 -->

                    </div>
                    <!-- /.row -->


                    <!-- / contenido -->            
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- /#wrapper -->

            <script type="text/javascript">
                $("#contenido").load("consulta/listConsultas.jsp");
            </script>
            <script type="text/javascript" src="usuario/login.js"></script>
            <div class="modal fade" id="modalConfiguracion" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Configuración</h4>
                        </div>
                        <div class="modal-body">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="form-control-label">Usuario</label>
                                    <input validate="text" type="text" class="form-control" id="recipient-name">
                                </div>
                                <div class="form-group">
                                    <label class="form-control-label">Contraseña Actual</label>
                                    <input validate="text" type="text" class="form-control" id="recipient-name">
                                </div>
                                <div class="form-group">
                                    <label class="form-control-label">Nueva Contraseña</label>
                                    <input validate="text" type="text" class="form-control" id="recipient-name">
                                </div>
                                <div class="form-group">
                                    <label class="form-control-label">Confirmar Contraseña</label>
                                    <input validate="text" type="text" class="form-control" id="recipient-name">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>
