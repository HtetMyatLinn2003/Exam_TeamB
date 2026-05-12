package scoremanager.main;

import bean.Teacher;
import bean.Test;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String studentNo = request.getParameter("studentNo");
        String subjectCd = request.getParameter("subjectCd");
        String noStr     = request.getParameter("no");
        int no = Integer.parseInt(noStr);

        TestDao testDao = new TestDao();
        Test test = testDao.get(studentNo, subjectCd, teacher.getSchool().getCd(), no);

        request.setAttribute("test", test);
        request.getRequestDispatcher("test_update.jsp").forward(request, response);
    }
}
