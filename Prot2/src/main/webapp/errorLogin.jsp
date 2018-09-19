
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="es">
    <head>
        
        <title>Iniciar sesión - Ta'angapp</title>

        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        
        <link href="css/iniciarSesion.css" rel="stylesheet">

    </head>
<!-- -->
    <body class="text-center">


        <form class="form-signin" action="<%=request.getContextPath()%>/LoginServlet" method="POST">
            
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                
                Error de credenciales

            </div>
            
            <h1 class="text-right" >Ta'angapp</h1>
            <h1 class="h3 mb-3 font-weight-normal">Sistema de Gestión de Marcas</h1>
            <img class="mb-4 img-fluid" src="imagenes/estudioJuridico.jpg" alt="Sanchez y asociados"  />
            <div>
                <label for="" class="sr-only">Usuario: </label>
                <input name="usuario" type="text" id="inputUser" class="form-control" placeholder="Usuario"   title="Se aceptan letras, números y guión bajo" required autofocus>
            </div>
            <div>
                <label for="" class="sr-only">Contraseña: </label>
                <input name="contrasena" type="password" id="inputPassword" class="form-control" placeholder="Contraseña" title = "Escriba su contraseña" required>

            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit" name="conectar">Ingresar</button>

        </form>
    </body>
</html>