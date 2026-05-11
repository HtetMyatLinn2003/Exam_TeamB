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
            Context context = new InitialContext();
            DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/exam");
            Dao.ds = ds;
            System.out.println("★★★ DataSource取得成功 ★★★");
        } catch (Exception e) {
            System.out.println("★★★ DataSource取得失敗: " + e.getClass().getName());
            System.out.println("★★★ メッセージ: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}