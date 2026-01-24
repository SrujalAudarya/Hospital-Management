package com.srujal.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("ROLE") : null;

        // Allow login page without session
        boolean loginPage = req.getRequestURI().endsWith("admin_login.jsp");

        if (("ADMIN".equals(role) && session != null) || loginPage) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
        }
    }
}

