package com.playdata.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {
        // 서블릿에 대한 처리 전에 실행되는 부분
        servletRequest.setCharacterEncoding("UTF-8");
        servletResponse.setCharacterEncoding("UTF-8");

        // 요청이 들어올 때마다 실행되는 메소드(기준점)
        filterChain.doFilter(servletRequest, servletResponse);

        // 서블릿에 대한 처리 후에 실행되는 부분
    }
}
