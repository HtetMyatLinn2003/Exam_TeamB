package scoremanager.main;

import java.util.List;

import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.SubjectDao;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String subjectCd = request.getParameter("subjectCd");
        String classNum  = request.getParameter("classNum");

        SubjectDao subjectDao = new SubjectDao();
        ClassNumDao classNumDao = new ClassNumDao();
        List<Subject> subjects   = subjectDao.filter(teacher.getSchool());
        List<String>  classNums  = classNumDao.filter(teacher.getSchool());

        List<Test> tests = null;
        if (subjectCd != null && !subjectCd.isEmpty()) {
            TestDao testDao = new TestDao();
            tests = testDao.filterBySubjectAndClass(subjectCd, classNum, teacher.getSchool());
        }

        request.setAttribute("subjects",  subjects);
        request.setAttribute("classNums", classNums);
        request.setAttribute("tests",     tests);
        request.setAttribute("subjectCd", subjectCd);
        request.setAttribute("classNum",  classNum);
        request.getRequestDispatcher("test_list.jsp").forward(request, response);
    }
}
