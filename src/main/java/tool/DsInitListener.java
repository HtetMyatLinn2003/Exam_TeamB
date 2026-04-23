package tool;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.Dao;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DsInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/exam");
            Dao.ds = ds;
        } catch (Exception e) {
            throw new RuntimeException("データソースの初期化に失敗しました: jdbc/exam", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
