<% String mensajeError = (String) request.getSession().getAttribute("mensajeErrorABM");

    if (mensajeError != null) {%>

        <div class="alert alert-warning alert-dismissible">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>¡Error!</strong><%=mensajeError%>
        </div>
        <%request.getSession().removeAttribute("mensajeErrorABM");
    }%>